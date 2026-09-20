import { beforeEach, describe, expect, it, vi } from 'vitest';
import { clubsService } from './clubsService';
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

describe('clubsService.listClubs', () => {
  const fromMock = supabase.from as unknown as ReturnType<typeof vi.fn>;

  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('maps district, tags and ratings from source rows', async () => {
    const clubsRows = [
      {
        id: 3,
        name: 'Pulse Club',
        description: 'Warehouse techno',
        outdoor_area: true,
        smoke_room: true,
        awareness_room: false,
        dark_room: true,
        crusing_area: false,
        cash_only: true,
        card_accepted: true,
        districts: { name: 'Friedrichshain' },
        club_ratings: { music_rating: 1, vibe_rating: 1, crowd_rating: 1, safety_rating: 1 },
        club_themes: [{ themes: { name: 'techno' } }],
        club_tonight_vibe: [{ status: 'live' }],
      },
    ];

    const reviewRows = [
      { club_id: 3, music_rating: 4, vibe_rating: 5, crowd_rating: 3, safety_rating: 2 },
      { club_id: 3, music_rating: 2, vibe_rating: 3, crowd_rating: 5, safety_rating: 4 },
    ];

    fromMock.mockImplementation((table: string) => {
      if (table === 'clubs') {
        return {
          select: vi.fn().mockReturnValue(
            createAwaitableQuery({
              data: clubsRows,
              error: null,
            })
          ),
        };
      }

      if (table === 'club_reviews') {
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

    const result = await clubsService.listClubs();

    expect(result).toHaveLength(1);
    expect(result[0]).toMatchObject({
      id: '3',
      district: 'Friedrichshain',
      hasLiveVibe: true,
      ratings: {
        music: 60,
        vibe: 80,
        crowd: 80,
        safety: 60,
      },
    });
    expect(result[0].tags).toEqual(
      expect.arrayContaining([
        'techno',
        'outdoor-area',
        'smoking-area',
        'dark-room',
        'cash-only',
        'card-accepted',
      ])
    );
  });

  it('falls back safely when relation data is missing', async () => {
    fromMock.mockImplementation((table: string) => {
      if (table === 'clubs') {
        return {
          select: vi.fn().mockReturnValue(
            createAwaitableQuery({
              data: [
                {
                  id: 8,
                  name: 'Fallback Club',
                  districts: null,
                  club_ratings: null,
                  club_themes: null,
                  club_tonight_vibe: null,
                },
              ],
              error: null,
            })
          ),
        };
      }

      if (table === 'club_reviews') {
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

    const result = await clubsService.listClubs();

    expect(result).toHaveLength(1);
    expect(result[0].district).toBe('Unknown District');
    expect(result[0].hasLiveVibe).toBe(false);
    expect(result[0].tags).toEqual([]);
    expect(result[0].ratings).toEqual({
      music: 0,
      vibe: 0,
      crowd: 0,
      safety: 0,
    });
  });

  it('returns empty array when clubs query fails', async () => {
    fromMock.mockImplementation((table: string) => {
      if (table === 'clubs') {
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

    const result = await clubsService.listClubs();
    expect(result).toEqual([]);
  });
});
