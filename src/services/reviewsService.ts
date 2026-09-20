import { Review, ReviewInput } from '../contracts/types';
import { supabase } from '../lib/supabase';

export interface UserReviewHistoryItem {
  id: string;
  venueId: string;
  venueName: string;
  venueType: 'club' | 'bar';
  ratings: {
    music: number;
    vibe: number;
    crowd: number;
    safety: number;
  };
  comment: string;
  queueTime?: number;
  createdAt: Date;
}

export interface UserReviewHistoryResult {
  reviews: UserReviewHistoryItem[];
  totalCount: number;
  totalPages: number;
}

interface PaginatedReviewHistoryRpcRow {
  review_id: string;
  venue_id: string;
  venue_name: string;
  venue_type: 'club' | 'bar';
  music_rating: number;
  vibe_rating: number;
  crowd_rating: number;
  safety_rating: number;
  review_text: string | null;
  queue_time: number | null;
  created_at: string;
  total_count: number;
}

const isPaginatedReviewHistoryRpcRows = (value: unknown): value is PaginatedReviewHistoryRpcRow[] => {
  if (!Array.isArray(value)) {
    return false;
  }

  return value.every((row) =>
    row !== null &&
    typeof row === 'object' &&
    typeof row.review_id === 'string' &&
    typeof row.venue_id === 'string' &&
    typeof row.venue_name === 'string' &&
    (row.venue_type === 'club' || row.venue_type === 'bar') &&
    typeof row.created_at === 'string'
  );
};

export const reviewsService = {
  async listReviews(venueId: string): Promise<Review[]> {
    try {
      const { data, error } = await supabase
        .from('club_reviews')
        .select('id, club_id, music_rating, vibe_rating, crowd_rating, safety_rating, review_text, created_at')
        .eq('club_id', parseInt(venueId))
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching reviews:', error);
        return [];
      }

      if (!data) return [];

      // Transform database data to Review format
      const reviews: Review[] = data.map(review => ({
        id: review.id.toString(),
        venueId: review.club_id.toString(),
        authorName: undefined, // Keep anonymous
        isAnonymous: true,
        ratings: {
          music: Math.round((review.music_rating || 0) * 20), // Convert 0-5 to 0-100
          vibe: Math.round((review.vibe_rating || 0) * 20),
          crowd: Math.round((review.crowd_rating || 0) * 20),
          safety: Math.round((review.safety_rating || 0) * 20),
        },
        comment: review.review_text || '',
        createdAt: new Date(review.created_at),
      }));

      return reviews;
    } catch (error) {
      console.error('Failed to load reviews:', error);
      return [];
    }
  },

  async createReview(input: ReviewInput): Promise<Review> {
    try {
      const { data, error } = await supabase
        .from('club_reviews')
        .insert({
          club_id: parseInt(input.venueId),
          user_id: input.userId, // This should be passed from the component
          music_rating: input.ratings.music / 20, // Convert 0-100 to 0-5
          vibe_rating: input.ratings.vibe / 20,
          crowd_rating: input.ratings.crowd / 20,
          safety_rating: input.ratings.safety / 20,
          review_text: input.comment.trim() || null,
        })
        .select()
        .single();

      if (error) {
        throw error;
      }

      // Transform back to Review format
      const newReview: Review = {
        id: data.id.toString(),
        venueId: data.club_id.toString(),
        authorName: undefined,
        isAnonymous: true,
        ratings: {
          music: Math.round(data.music_rating * 20),
          vibe: Math.round(data.vibe_rating * 20),
          crowd: Math.round(data.crowd_rating * 20),
          safety: Math.round(data.safety_rating * 20),
        },
        comment: data.review_text || '',
        createdAt: new Date(data.created_at),
      };

      return newReview;
    } catch (error) {
      console.error('Failed to create review:', error);
      throw error;
    }
  },

  async listBarReviews(barId: string): Promise<Review[]> {
    try {
      const { data, error } = await supabase
        .from('bar_reviews')
        .select('*')
        .eq('bar_id', parseInt(barId))
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching bar reviews:', error);
        return [];
      }

      if (!data) return [];

      // Transform database data to Review format
      const reviews: Review[] = data.map(review => ({
        id: review.id.toString(),
        venueId: review.bar_id.toString(),
        authorName: undefined, // Keep anonymous
        isAnonymous: true,
        ratings: {
          // Map bar ratings to old structure for compatibility
          music: Math.round(review.quality_rating || 0), // quality -> music
          vibe: Math.round(review.vibe_rating || 0),
          crowd: Math.round(review.price_rating || 0), // price -> crowd
          safety: Math.round(review.friendliness_rating || 0), // friendliness -> safety
        },
        comment: review.review_text || '',
        queueTime: review.queue_time,
        createdAt: new Date(review.created_at),
      }));

      return reviews;
    } catch (error) {
      console.error('Failed to load bar reviews:', error);
      return [];
    }
  },

  async createBarReview(input: ReviewInput & { barId?: string }): Promise<Review> {
    try {
      const barId = input.barId || input.venueId;
      if (!barId) {
        throw new Error('Bar ID is required');
      }

      const { data, error } = await supabase
        .from('bar_reviews')
        .insert({
          bar_id: parseInt(barId),
          user_id: input.userId,
          // Map old structure to new bar rating dimensions
          quality_rating: input.ratings.music, // music -> quality
          price_rating: input.ratings.crowd, // crowd -> price
          vibe_rating: input.ratings.vibe,
          friendliness_rating: input.ratings.safety, // safety -> friendliness
          review_text: input.comment.trim() || null,
          queue_time: input.queueTime,
        })
        .select()
        .single();

      if (error) {
        throw error;
      }

      // Transform back to Review format
      const newReview: Review = {
        id: data.id.toString(),
        venueId: data.bar_id.toString(),
        authorName: undefined,
        isAnonymous: true,
        ratings: {
          music: Math.round(data.quality_rating),
          vibe: Math.round(data.vibe_rating),
          crowd: Math.round(data.price_rating),
          safety: Math.round(data.friendliness_rating),
        },
        comment: data.review_text || '',
        queueTime: data.queue_time,
        createdAt: new Date(data.created_at),
      };

      return newReview;
    } catch (error) {
      console.error('Failed to create bar review:', error);
      throw error;
    }
  },

  async getUserClubsVisited(userId: string): Promise<number> {
    try {
      const { data, error } = await supabase
        .from('club_reviews')
        .select('club_id')
        .eq('user_id', userId);

      if (error) {
        throw error;
      }

      // Count distinct club_ids to avoid duplicates
      const uniqueClubIds = new Set(data?.map(review => review.club_id) || []);
      return uniqueClubIds.size;
    } catch (error) {
      console.error('Failed to get user clubs visited count:', error);
      return 0;
    }
  },

  async getUserBarsVisited(userId: string): Promise<number> {
    try {
      const { data, error } = await supabase
        .from('bar_reviews')
        .select('bar_id')
        .eq('user_id', userId);

      if (error) {
        throw error;
      }

      // Count distinct bar_ids to avoid duplicates
      const uniqueBarIds = new Set(data?.map(review => review.bar_id) || []);
      return uniqueBarIds.size;
    } catch (error) {
      console.error('Failed to get user bars visited count:', error);
      return 0;
    }
  },

  // Get user's review history with pagination
  async getUserReviewHistory(userId: string, page: number = 1, limit: number = 3): Promise<UserReviewHistoryResult> {
    const normalizedPage = Math.max(1, page);
    const normalizedLimit = Math.max(1, limit);

    try {
      const rpcResult = await supabase.rpc('get_user_review_history_paginated', {
        p_user_id: userId,
        p_page: normalizedPage,
        p_limit: normalizedLimit,
      });

      if (rpcResult.error) {
        throw rpcResult.error;
      }

      if (!isPaginatedReviewHistoryRpcRows(rpcResult.data)) {
        throw new Error('Invalid paginated review history RPC payload');
      }

      const rows = rpcResult.data;
      const totalCount = rows.length > 0 ? Number(rows[0].total_count) || 0 : 0;
      const totalPages = totalCount > 0 ? Math.ceil(totalCount / normalizedLimit) : 0;

      return {
        reviews: rows.map((row) => ({
          id: row.review_id,
          venueId: row.venue_id,
          venueName: row.venue_name,
          venueType: row.venue_type,
          ratings: {
            music: Math.round(row.music_rating || 0),
            vibe: Math.round(row.vibe_rating || 0),
            crowd: Math.round(row.crowd_rating || 0),
            safety: Math.round(row.safety_rating || 0),
          },
          comment: row.review_text || '',
          queueTime: row.queue_time ?? undefined,
          createdAt: new Date(row.created_at),
        })),
        totalCount,
        totalPages,
      };
    } catch (rpcError) {
      console.error('Error fetching paginated review history via RPC, falling back to in-memory merge:', rpcError);
    }

    try {
      const [clubReviewsResult, barReviewsResult] = await Promise.all([
        supabase
          .from('club_reviews')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', { ascending: false }),
        supabase
          .from('bar_reviews')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', { ascending: false }),
      ]);

      if (clubReviewsResult.error) {
        console.error('Error fetching club reviews:', clubReviewsResult.error);
      }
      if (barReviewsResult.error) {
        console.error('Error fetching bar reviews:', barReviewsResult.error);
      }

      const clubIds = Array.from(
        new Set((clubReviewsResult.data || []).map((review) => Number(review.club_id)).filter((id) => Number.isFinite(id)))
      );
      const barIds = Array.from(
        new Set((barReviewsResult.data || []).map((review) => Number(review.bar_id)).filter((id) => Number.isFinite(id)))
      );

      const [clubsLookupResult, barsLookupResult] = await Promise.all([
        clubIds.length
          ? supabase.from('clubs').select('id, name').in('id', clubIds)
          : Promise.resolve({ data: [], error: null }),
        barIds.length
          ? supabase.from('bars').select('id, name').in('id', barIds)
          : Promise.resolve({ data: [], error: null }),
      ]);

      if (clubsLookupResult.error) {
        console.error('Error fetching club names:', clubsLookupResult.error);
      }
      if (barsLookupResult.error) {
        console.error('Error fetching bar names:', barsLookupResult.error);
      }

      const clubNameMap = new Map<number, string>(
        ((clubsLookupResult.data || []) as Array<{ id: number; name: string }>).map((club) => [Number(club.id), club.name])
      );
      const barNameMap = new Map<number, string>(
        ((barsLookupResult.data || []) as Array<{ id: number; name: string }>).map((bar) => [Number(bar.id), bar.name])
      );

      const allReviews: UserReviewHistoryItem[] = [];

      // Add club reviews
      if (clubReviewsResult.data && clubReviewsResult.data.length > 0) {
        for (const review of clubReviewsResult.data) {
          allReviews.push({
            id: `club_${review.id}`,
            venueId: review.club_id.toString(),
            venueName: clubNameMap.get(Number(review.club_id)) || 'Unknown Club',
            venueType: 'club' as const,
            ratings: {
              music: Math.round((review.music_rating || 0) * 20), // Convert 0-5 to 0-100
              vibe: Math.round((review.vibe_rating || 0) * 20),
              crowd: Math.round((review.crowd_rating || 0) * 20),
              safety: Math.round((review.safety_rating || 0) * 20),
            },
            comment: review.review_text || '',
            queueTime: review.queue_time,
            createdAt: new Date(review.created_at),
          });
        }
      }

      // Add bar reviews
      if (barReviewsResult.data && barReviewsResult.data.length > 0) {
        for (const review of barReviewsResult.data) {
          allReviews.push({
            id: `bar_${review.id}`,
            venueId: review.bar_id.toString(),
            venueName: barNameMap.get(Number(review.bar_id)) || 'Unknown Bar',
            venueType: 'bar' as const,
            ratings: {
              music: Math.round(review.quality_rating || 0), // Already 0-100
              vibe: Math.round(review.vibe_rating || 0),
              crowd: Math.round(review.price_rating || 0),
              safety: Math.round(review.friendliness_rating || 0),
            },
            comment: review.review_text || '',
            queueTime: review.queue_time,
            createdAt: new Date(review.created_at),
          });
        }
      }

      // Sort by date (newest first)
      allReviews.sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());

      // Calculate pagination
      const totalCount = allReviews.length;
      const totalPages = Math.ceil(totalCount / normalizedLimit);
      const offset = (normalizedPage - 1) * normalizedLimit;
      const paginatedReviews = allReviews.slice(offset, offset + normalizedLimit);

      return {
        reviews: paginatedReviews,
        totalCount,
        totalPages,
      };
    } catch (error) {
      console.error('Failed to get user review history:', error);
      return {
        reviews: [],
        totalCount: 0,
        totalPages: 0,
      };
    }
  },
};