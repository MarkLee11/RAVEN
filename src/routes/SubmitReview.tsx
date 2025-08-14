import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, Star, Upload, LogIn } from 'lucide-react';
import { VenueRatings } from '../contracts/types';
import { supabase } from '../lib/supabase';
import { reviewsService } from '../services/reviewsService';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';

const SubmitReview: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  
  const { venueId, venueName } = location.state || {};
  
  const [user, setUser] = useState<any>(null);
  const [checkingAuth, setCheckingAuth] = useState(true);
  const [ratings, setRatings] = useState<VenueRatings>({
    music: 50,
    vibe: 50,
    crowd: 50,
    safety: 50,
  });
  
  const [comment, setComment] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  useEffect(() => {
    checkUser();
  }, []);

  const checkUser = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      setUser(user);
    } catch (error) {
      console.error('Error checking user:', error);
    } finally {
      setCheckingAuth(false);
    }
  };

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
      // Use the reviewsService to create the review
      await reviewsService.createReview({
        venueId,
        userId: user.id,
        ratings,
        comment,
        isAnonymous: true,
      });
      
      // Show success state
      setSuccess(true);
      
      // Clear form
      setRatings({ music: 50, vibe: 50, crowd: 50, safety: 50 });
      setComment('');
      
      // Navigate back after a short delay
      setTimeout(() => {
        navigate(`/clubs/${venueId}`, { replace: true });
      }, 2000);
      
    } catch (error: any) {
      console.error('Failed to submit review:', error);
      setError(error.message || 'Failed to submit review. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const getRatingColor = (value: number): string => {
    if (value >= 80) return 'bg-raven';
    if (value >= 60) return 'bg-yellow-500';
    if (value >= 40) return 'bg-orange-500';
    return 'bg-blood';
  };

  if (checkingAuth) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!venueId) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="text-center">
          <p className="text-ash mb-4">No venue selected</p>
          <Button onClick={() => navigate('/clubs')}>Back to Clubs</Button>
        </div>
      </div>
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

        <div className="px-4 pt-8 max-w-md mx-auto">
          <Card className="text-center py-8">
            <LogIn size={48} className="mx-auto text-raven mb-4" />
            <h2 className="font-space text-xl text-ink mb-3">Login Required</h2>
            <p className="text-ash mb-6 leading-relaxed">
              You need to be logged in to submit a review. Don't worry - your reviews will remain anonymous to other users.
            </p>
            <div className="space-y-3">
              <Button 
                onClick={() => navigate('/profile')}
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

  // Show success state
  if (success) {
    return (
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        className="min-h-screen bg-berlin-black flex items-center justify-center"
      >
        <div className="text-center px-4">
          <div className="w-16 h-16 bg-raven/20 rounded-full flex items-center justify-center mx-auto mb-4">
            <Star size={32} className="text-raven" />
          </div>
          <h2 className="font-space text-2xl text-ink mb-2">Review Submitted!</h2>
          <p className="text-ash mb-4">Thank you for sharing your experience.</p>
          <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
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

        {/* Comment */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-3">Your Experience</h3>
          <textarea
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            placeholder="Share your experience... What was the vibe? How was the music? Any tips for others? (Optional)"
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
            disabled={isSubmitting}
            isLoading={isSubmitting}
          >
            <Star size={16} className="mr-2" />
            Submit Review
          </Button>
          
          <p className="text-xs text-ash text-center">
            Only ratings are required. Your review will be anonymous to other users.
          </p>
        </div>
      </form>
    </motion.div>
  );
};

export default SubmitReview;