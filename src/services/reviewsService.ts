import { Review, ReviewInput } from '../contracts/types';
import { supabase } from '../lib/supabase';

export const reviewsService = {
  async listReviews(venueId: string): Promise<Review[]> {
    try {
      const { data, error } = await supabase
        .from('club_reviews')
        .select('*')
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
};