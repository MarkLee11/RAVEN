import { beforeEach, describe, expect, it, vi } from 'vitest';
import { reviewsService } from './reviewsService';
import { supabase } from '../lib/supabase';

vi.mock('../lib/supabase', () => ({
  supabase: {
    from: vi.fn(),
  },
}));

type ClubReviewRow = {
  id: number;
  club_id: number;
  music_rating: number;
  vibe_rating: number;
  crowd_rating: number;
  safety_rating: number;
  review_text: string;
  created_at: string;
};

describe('reviewsService.listReviews', () => {
  const fromMock = supabase.from as unknown as ReturnType<typeof vi.fn>;

  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('maps rows to review model', async () => {
    const dbRows: ClubReviewRow[] = [
      {
        id: 101,
        club_id: 9,
        music_rating: 4.2,
        vibe_rating: 3.5,
        crowd_rating: 4.9,
        safety_rating: 2.1,
        review_text: 'Nice night',
        created_at: '2026-01-01T10:00:00.000Z',
      },
    ];

    const order = vi.fn().mockResolvedValue({
      data: dbRows,
      error: null,
    });
    const eq = vi.fn().mockReturnValue({ order });
    const select = vi.fn().mockReturnValue({ eq });
    fromMock.mockReturnValue({ select });

    const result = await reviewsService.listReviews('9');

    expect(fromMock).toHaveBeenCalledWith('club_reviews');
    expect(result).toHaveLength(1);
    expect(result[0]).toMatchObject({
      id: '101',
      venueId: '9',
      comment: 'Nice night',
      ratings: {
        music: 84,
        vibe: 70,
        crowd: 98,
        safety: 42,
      },
    });
  });

  it('returns empty array when query fails', async () => {
    const order = vi.fn().mockResolvedValue({
      data: null,
      error: { message: 'boom' },
    });
    const eq = vi.fn().mockReturnValue({ order });
    const select = vi.fn().mockReturnValue({ eq });
    fromMock.mockReturnValue({ select });

    const result = await reviewsService.listReviews('9');
    expect(result).toEqual([]);
  });

  it('getUserReviewHistory batches venue lookup instead of per-review query', async () => {
    const inCalls: Array<{ table: string; ids: number[] }> = [];
    const fromDispatcher = vi.fn((table: string) => {
      if (table === 'club_reviews') {
        return {
          select: vi.fn(() => ({
            eq: vi.fn(() => ({
              order: vi.fn().mockResolvedValue({
                data: [
                  {
                    id: 1,
                    club_id: 11,
                    music_rating: 4,
                    vibe_rating: 4,
                    crowd_rating: 4,
                    safety_rating: 4,
                    review_text: 'club one',
                    queue_time: 5,
                    created_at: '2026-01-02T10:00:00.000Z',
                  },
                  {
                    id: 2,
                    club_id: 11,
                    music_rating: 5,
                    vibe_rating: 5,
                    crowd_rating: 5,
                    safety_rating: 5,
                    review_text: 'club two',
                    queue_time: 6,
                    created_at: '2026-01-01T10:00:00.000Z',
                  },
                ],
                error: null,
              }),
            })),
          })),
        };
      }

      if (table === 'bar_reviews') {
        return {
          select: vi.fn(() => ({
            eq: vi.fn(() => ({
              order: vi.fn().mockResolvedValue({
                data: [
                  {
                    id: 3,
                    bar_id: 22,
                    quality_rating: 88,
                    vibe_rating: 77,
                    price_rating: 66,
                    friendliness_rating: 55,
                    review_text: 'bar one',
                    queue_time: 3,
                    created_at: '2026-01-03T10:00:00.000Z',
                  },
                ],
                error: null,
              }),
            })),
          })),
        };
      }

      if (table === 'clubs') {
        return {
          select: vi.fn(() => ({
            in: vi.fn((column: string, ids: number[]) => {
              expect(column).toBe('id');
              inCalls.push({ table: 'clubs', ids });
              return Promise.resolve({
                data: [{ id: 11, name: 'Club Name' }],
                error: null,
              });
            }),
          })),
        };
      }

      if (table === 'bars') {
        return {
          select: vi.fn(() => ({
            in: vi.fn((column: string, ids: number[]) => {
              expect(column).toBe('id');
              inCalls.push({ table: 'bars', ids });
              return Promise.resolve({
                data: [{ id: 22, name: 'Bar Name' }],
                error: null,
              });
            }),
          })),
        };
      }

      return {
        select: vi.fn(() => ({
          eq: vi.fn(() => ({
            order: vi.fn().mockResolvedValue({ data: [], error: null }),
          })),
        })),
      };
    });

    fromMock.mockImplementation(fromDispatcher);

    const result = await reviewsService.getUserReviewHistory('user-1', 1, 10);

    expect(result.totalCount).toBe(3);
    expect(result.reviews[0].venueType).toBe('bar');
    expect(inCalls).toEqual([
      { table: 'clubs', ids: [11] },
      { table: 'bars', ids: [22] },
    ]);
  });
});
