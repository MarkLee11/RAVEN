import { beforeEach, describe, expect, it, vi } from 'vitest';
import { barsService } from './barsService';
import { supabase } from '../lib/supabase';

vi.mock('../lib/supabase', () => ({
  supabase: {
    from: vi.fn(),
  },
}));

const createAwaitableQuery = <T>(result: { data: T; error: unknown }) => {
  const promise = Promise.resolve(result);
  const query = {
    then: promise.then.bind(promise),
    catch: promise.catch.bind(promise),
    finally: promise.finally.bind(promise),
    eq: vi.fn(),
  };
  query.eq.mockReturnValue(query);
  return query;
};

describe('barsService.listBars', () => {
  const fromMock = supabase.from as unknown as ReturnType<typeof vi.fn>;

  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('maps district, tags and ratings from source rows', async () => {
    const barsRows = [
      {
        id: 7,
        name: 'Neon Bar',
        description: 'Late night spot',
        cash_only: true,
        card_accepted: true,
        districts: { name: 'Mitte' },
        bar_ratings: {
          quality_rating: 1,
          price_rating: 1,
          vibe_rating: 1,
          friendliness_rating: 1,
        },
        bar_themes: [{ themes: { name: 'cocktails', category: 'drinks' } }],
        bar_locations: [{ address_line: 'Main St 10' }],
      },
    ];

    const reviewRows = [
      { bar_id: 7, quality_rating: 4, price_rating: 2, vibe_rating: 5, friendliness_rating: 3 },
      { bar_id: 7, quality_rating: 2, price_rating: 4, vibe_rating: 3, friendliness_rating: 5 },
    ];

    fromMock.mockImplementation((table: string) => {
      if (table === 'bars') {
        return {
          select: vi.fn().mockReturnValue(
            createAwaitableQuery({
              data: barsRows,
              error: null,
            })
          ),
        };
      }

      if (table === 'bar_reviews') {
        return {
          select: vi.fn().mockReturnValue({
            in: vi.fn().mockResolvedValue({
              data: reviewRows,
              error: null,
            }),
          }),
        };
      }

      return {
        select: vi.fn().mockReturnValue(createAwaitableQuery({ data: [], error: null })),
      };
    });

    const result = await barsService.listBars();

    expect(result).toHaveLength(1);
    expect(result[0]).toMatchObject({
      id: '7',
      district: 'Mitte',
      tags: ['cocktails', 'cash-only', 'card-accepted'],
      ratings: {
        music: 3,
        crowd: 3,
        vibe: 4,
        safety: 4,
      },
      address: 'Main St 10',
    });
  });

  it('falls back safely when relation data is missing', async () => {
    fromMock.mockImplementation((table: string) => {
      if (table === 'bars') {
        return {
          select: vi.fn().mockReturnValue(
            createAwaitableQuery({
              data: [
                {
                  id: 11,
                  name: 'Fallback Bar',
                  districts: null,
                  bar_ratings: null,
                  bar_themes: null,
                  cash_only: false,
                  card_accepted: false,
                  bar_locations: [],
                },
              ],
              error: null,
            })
          ),
        };
      }

      if (table === 'bar_reviews') {
        return {
          select: vi.fn().mockReturnValue({
            in: vi.fn().mockResolvedValue({
              data: [],
              error: null,
            }),
          }),
        };
      }

      return {
        select: vi.fn().mockReturnValue(createAwaitableQuery({ data: [], error: null })),
      };
    });

    const result = await barsService.listBars();

    expect(result).toHaveLength(1);
    expect(result[0].district).toBe('Unknown District');
    expect(result[0].tags).toEqual([]);
    expect(result[0].ratings).toEqual({
      music: 0,
      vibe: 0,
      crowd: 0,
      safety: 0,
    });
  });

  it('returns empty array when bars query fails', async () => {
    fromMock.mockImplementation((table: string) => {
      if (table === 'bars') {
        return {
          select: vi.fn().mockReturnValue(
            createAwaitableQuery({
              data: null,
              error: { message: 'query failed' },
            })
          ),
        };
      }

      return {
        select: vi.fn().mockReturnValue(createAwaitableQuery({ data: [], error: null })),
      };
    });

    const result = await barsService.listBars();
    expect(result).toEqual([]);
  });
});
