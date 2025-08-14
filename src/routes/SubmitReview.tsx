import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, Star, Upload } from 'lucide-react';
import { VenueRatings, ReviewInput } from '../contracts/types';
import { reviewsService } from '../services/reviewsService';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';

const SubmitReview: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  
  const { venueId, venueName } = location.state || {};
  
  const [ratings, setRatings] = useState<VenueRatings>({
    music: 50,
    vibe: 50,
    crowd: 50,
    safety: 50,
  });
  
  const [comment, setComment] = useState('');
  const [queueTime, setQueueTime] = useState<number | undefined>();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleRatingChange = (aspect: keyof VenueRatings, value: number) => {
    setRatings(prev => ({ ...prev, [aspect]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!venueId) {
      return;
    }

    setIsSubmitting(true);
    
    try {
      const reviewInput: ReviewInput = {
        venueId,
        ratings,
        comment: comment.trim() || undefined,
        queueTime,
        isAnonymous: true, // All reviews are anonymous
      };

      await reviewsService.createReview(reviewInput);
      
      // Show success toast
      const successMessage = 'Review submitted successfully!';
      console.log(successMessage);
      
      // Navigate back to venue
      navigate(`/venues/${venueId}`, { replace: true });
      
    } catch (error) {
      console.error('Failed to submit review:', error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const getRatingColor = (value: number): string => {
    if (value >= 80) return 'bg-brat';
    if (value >= 60) return 'bg-yellow-500';
    if (value >= 40) return 'bg-orange-500';
    return 'bg-blood';
  };

  const isFormValid = true; // Always valid since all fields are optional

  if (!venueId) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="text-center">
          <p className="text-ash mb-4">No venue selected</p>
          <Button onClick={() => navigate('/venues')}>Back to Venues</Button>
        </div>
      </div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-berlin-black"
    >
      {/* Header */}
      <div className="sticky top-0 bg-berlin-black/95 backdrop-blur-sm border-b border-ash/10 p-4">
        <div className="flex items-center space-x-3">
          <button
            onClick={() => navigate(-1)}
            className="text-ash hover:text-ink transition-colors"
          >
            <ArrowLeft size={20} />
          </button>
          <div className="flex-1">
            <h1 className="font-space text-xl text-ink">Add Review</h1>
            {venueName && (
              <p className="text-sm text-ash">{venueName}</p>
            )}
          </div>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="px-4 pt-4 space-y-6">
        {/* Rating Sliders */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Rate Your Experience</h3>
          
          <div className="space-y-6">
            {Object.entries(ratings).map(([aspect, value]) => (
              <div key={aspect} className="space-y-2">
                <div className="flex justify-between items-center">
                  <label className="text-sm font-medium text-ink capitalize">
                    {aspect}
                  </label>
                  <span className="text-sm text-raven font-semibold">
                    {value}%
                  </span>
                </div>
                
                <div className="relative">
                  <input
                    type="range"
                    min="0"
                    max="100"
                    value={value}
                    onChange={(e) => handleRatingChange(aspect as keyof VenueRatings, parseInt(e.target.value))}
                    className="w-full h-2 bg-ash/20 rounded-lg appearance-none cursor-pointer slider"
                    style={{
                      background: `linear-gradient(to right, ${getRatingColor(value)} 0%, ${getRatingColor(value)} ${value}%, rgba(156, 163, 175, 0.2) ${value}%, rgba(156, 163, 175, 0.2) 100%)`
                    }}
                  />
                </div>
              </div>
            ))}
          </div>
        </Card>

        {/* Queue Time */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-3">Queue Time (Optional)</h3>
          <input
            type="number"
            placeholder="Minutes waited"
            min="0"
            max="240"
            value={queueTime || ''}
            onChange={(e) => setQueueTime(e.target.value ? parseInt(e.target.value) : undefined)}
            className="w-full bg-berlin-black border border-ash/30 rounded-md px-3 py-2 text-ink placeholder-ash focus:border-raven focus:outline-none"
          />
        </Card>

        {/* Comment */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-3">Your Experience</h3>
          <textarea
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            placeholder="Share your experience... What was the vibe? How was the music? Any tips for others? (Optional)"
            rows={4}
            className="w-full bg-berlin-black border border-ash/30 rounded-md px-3 py-2 text-ink placeholder-ash focus:border-raven focus:outline-none resize-none"
          />
          <div className="flex justify-between items-center mt-2">
            <span className="text-xs text-ash">
              Optional field
            </span>
            <span className="text-xs text-ash">
              {comment.length}/500
            </span>
          </div>
        </Card>

        {/* Photo Upload Placeholder */}
        <Card>
          <div className="text-center py-8">
            <Upload size={24} className="mx-auto text-ash mb-2" />
            <p className="text-sm text-ash">Photo upload coming soon (Optional)</p>
          </div>
        </Card>

        {/* Submit Button */}
        <div className="space-y-3">
          <Button
            type="submit"
            size="lg"
            className="w-full justify-center"
            disabled={!isFormValid}
            isLoading={isSubmitting}
          >
            <Star size={16} className="mr-2" />
            Submit Review
          </Button>
          
          <p className="text-xs text-ash text-center">
            Only ratings are required. Everything else is optional.
          </p>
        </div>
      </form>
    </motion.div>
  );
};

export default SubmitReview;