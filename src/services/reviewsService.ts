import { Review, ReviewInput } from '../contracts/types';
import { reviews } from '../data/reviews';

export const reviewsService = {
  async listReviews(venueId: string): Promise<Review[]> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    return reviews
      .filter(review => review.venueId === venueId)
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());
  },

  async createReview(input: ReviewInput): Promise<Review> {
    await new Promise(resolve => setTimeout(resolve, 500));
    
    const newReview: Review = {
      id: `r_${Date.now()}`,
      ...input,
      authorName: input.isAnonymous ? undefined : 'New User',
      createdAt: new Date(),
    };
    
    // In real app, this would persist to backend
    console.log('Created review:', newReview);
    
    return newReview;
  },
};