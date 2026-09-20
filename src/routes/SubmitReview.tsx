import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, LogIn } from 'lucide-react';
import { Review, VenueRatings } from '../contracts/types';
import { useAuth } from '../contexts/useAuth';
import { reviewsService } from '../services/reviewsService';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import PageStateView from '../components/ui/PageStateView';

const SubmitReview: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  
  const { venueId, venueName, venueType = 'club' } = location.state || {};
  const { user, loading: checkingAuth } = useAuth();

  const [ratings, setRatings] = useState<VenueRatings>({
    music: 50,
    vibe: 50,
    crowd: 50,
    safety: 50,
  });
  
  const [comment, setComment] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleRatingChange = (aspect: keyof VenueRatings, value: number) => {
    setRatings(prev => ({ ...prev, [aspect]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!venueId || !user) {
      return;
    }

    setIsSubmitting(true);
    setError(null);
    
    try {
      // Use the appropriate service method based on venue type
      if (venueType === 'bar') {
        await reviewsService.createBarReview({
          barId: venueId,
          venueId,
          userId: user.id,
          ratings,
          comment,
          isAnonymous: true,
        });
      } else {
        await reviewsService.createReview({
          venueId,
          userId: user.id,
          ratings,
          comment,
          isAnonymous: true,
        });
      }
      
      // Build optimistic review for immediate echo on detail page
      const optimisticReview: Review = {
        id: Math.random().toString(36).slice(2),
        venueId,
        isAnonymous: true,
        ratings,
        comment,
        createdAt: new Date(),
      };

      // Navigate back to appropriate detail page with optimistic data
      const detailRoute = venueType === 'bar' ? `/bars/${venueId}` : `/clubs/${venueId}`;
      navigate(detailRoute, { replace: true, state: { optimisticReview } });
      
    } catch (error: unknown) {
      console.error('Failed to submit review:', error);
      const message = error instanceof Error ? error.message : 'Failed to submit review. Please try again.';
      setError(message);
    } finally {
      setIsSubmitting(false);
    }
  };

  if (checkingAuth) {
    return <PageStateView loading />;
  }

  if (!venueId) {
    return (
      <PageStateView
        message="No venue selected"
        primaryAction={{
          label: `Back to ${venueType === 'bar' ? 'Bars' : 'Clubs'}`,
          onClick: () => navigate(venueType === 'bar' ? '/bars' : '/clubs'),
        }}
      />
    );
  }

  // Show login prompt if user is not authenticated
  if (!user) {
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
              aria-label="Go back"
              className="text-ash hover:text-ink transition-colors -m-2 p-3 tap-fast"
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

        <div className="px-4 pt-8 max-w-md mx-auto">
          <Card className="text-center py-8">
            <LogIn size={48} className="mx-auto text-raven mb-4" />
            <h2 className="font-space text-xl text-ink mb-3">Login Required</h2>
            <p className="text-ash mb-6 leading-relaxed">
              You need to be logged in to submit a review. Don't worry - your reviews will remain anonymous to other users.
            </p>
            <div className="space-y-3">
              <Button 
                onClick={() => navigate('/profile', {
                  state: {
                    returnTo: '/submit',
                    submitState: { venueId, venueName, venueType },
                  },
                })}
                className="w-full justify-center"
              >
                <LogIn size={16} className="mr-2" />
                Login / Sign Up
              </Button>
              <Button 
                variant="ghost"
                onClick={() => navigate(-1)}
                className="w-full justify-center"
              >
                Go Back
              </Button>
            </div>
          </Card>
        </div>
      </motion.div>
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
            aria-label="Go back"
            className="text-ash hover:text-ink transition-colors -m-2 p-3 tap-fast"
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
        {/* Error Message */}
        {error && (
          <Card className="border-blood/30 bg-blood/5">
            <p className="text-blood text-sm">{error}</p>
          </Card>
        )}

        {/* Rating Sliders */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Rate Your Experience</h3>
          
          <div className="space-y-6">
            {Object.entries(ratings).map(([aspect, value]) => {
              const sliderId = `rating-${venueType}-${aspect}`;
              // Map rating aspects to appropriate labels based on venue type
              const getAspectLabel = (aspect: string, venueType: string) => {
                if (venueType === 'bar') {
                  switch (aspect) {
                    case 'music': return 'Quality';
                    case 'vibe': return 'Vibe';
                    case 'crowd': return 'Price';
                    case 'safety': return 'Friendliness';
                    default: return aspect;
                  }
                }
                // Default club labels
                return aspect.charAt(0).toUpperCase() + aspect.slice(1);
              };

              return (
                <div key={aspect} className="space-y-2">
                  <div className="flex justify-between items-center">
                    <label htmlFor={sliderId} className="text-sm font-medium text-ink">
                      {getAspectLabel(aspect, venueType)}
                    </label>
                  <span className="text-sm text-raven font-semibold">
                    {value}%
                  </span>
                </div>
                
                <div className="relative">
                  <input
                    id={sliderId}
                    type="range"
                    min="0"
                    max="100"
                    value={value}
                    onChange={(e) => handleRatingChange(aspect as keyof VenueRatings, parseInt(e.target.value))}
                    className="w-full h-2 bg-ash/20 rounded-lg appearance-none cursor-pointer slider"
                    style={{
                      background: `linear-gradient(to right, #8ACE00 0%, #8ACE00 ${value}%, rgba(156, 163, 175, 0.2) ${value}%, rgba(156, 163, 175, 0.2) 100%)`
                    }}
                  />
                </div>
                </div>
              );
            })}
          </div>
        </Card>

        {/* Comment */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-3">Your Experience</h3>
          <textarea
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            placeholder="Sip it. Spill it. Savor it."
            rows={4}
            maxLength={500}
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

        {/* Submit Button */}
        <div className="space-y-3">
          <button
            type="submit"
            disabled={isSubmitting}
            className="spill-button mx-auto"
            aria-busy={isSubmitting}
          >
            <svg className="spill-svgIcon" viewBox="0 0 512 512" height="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm50.7-186.9L162.4 380.6c-19.4 7.5-38.5-11.6-31-31l55.5-144.3c3.3-8.5 9.9-15.1 18.4-18.4l144.3-55.5c19.4-7.5 38.5 11.6 31 31L325.1 306.7c-3.2 8.5-9.9 15.1-18.4 18.4zM288 256a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z"></path>
            </svg>
            Spill
          </button>
          
          <p className="text-xs text-ash text-center">
            All REVIEWS ARE <span className="font-bold text-raven">ANONYMOUS</span>
          </p>
        </div>
      </form>
    </motion.div>
  );
};

export default SubmitReview;