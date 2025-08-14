import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, MapPin, Star, MessageCircle } from 'lucide-react';
import { Venue, Review, VibeSummary } from '../contracts/types';
import { venuesService } from '../services/venuesService';
import { reviewsService } from '../services/reviewsService';
import { vibeService } from '../services/vibeService';
import { formatTimeAgo } from '../lib/utils';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';
import VibeCard from '../components/VibeCard';
import Avatar from '../components/Avatar';

const VenueDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [venue, setVenue] = useState<Venue | null>(null);
  const [reviews, setReviews] = useState<Review[]>([]);
  const [vibeSummary, setVibeSummary] = useState<VibeSummary | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (id) {
      loadVenueData(id);
    }
  }, [id]);

  const loadVenueData = async (venueId: string) => {
    setLoading(true);
    try {
      const [venueData, reviewsData, vibeData] = await Promise.all([
  | 'world-famous'
  | 'inclusive'
  | 'riverside'
  | 'underground'
  | 'rooftop'
  | 'historic'
  | 'traditional'
  | 'beer-garden'
  | 'cocktails'
  | 'upscale'
  | 'alternative'
  | 'quirky'
  | 'city-view'
  | 'family-friendly';
        reviewsService.listReviews(venueId),
        vibeService.getVibeSummary(venueId)
      ]);

      setVenue(venueData);
      setReviews(reviewsData);
      setVibeSummary(vibeData);
    } catch (error) {
      console.error('Failed to load venue data:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!venue) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="text-center">
          <p className="text-ash mb-4">Venue not found</p>
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
            <div className="flex items-center space-x-2">
              <h1 className="font-space text-xl text-ink">{venue.name}</h1>
              {venue.hasLiveVibe && (
                <Badge variant="raven" size="sm">LIVE</Badge>
              )}
            </div>
            <div className="flex items-center space-x-1 text-sm text-ash">
              <MapPin size={12} />
              <span>{venue.district}</span>
            </div>
          </div>
        </div>
      </div>

      <div className="px-4 pt-4 space-y-6">
        {/* Tags */}
        <div className="flex flex-wrap gap-2">
          {venue.tags.map(tag => (
            <Badge key={tag}>{tag}</Badge>
          ))}
        </div>

        {/* Description */}
        {venue.description && (
          <Card>
            <p className="text-ash text-sm leading-relaxed">{venue.description}</p>
          </Card>
        )}

        {/* Tonight's Vibe */}
        {vibeSummary && <VibeCard summary={vibeSummary} />}

        {/* Ratings */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Overall Ratings</h3>
          <div className="grid grid-cols-2 gap-4">
            <RatingBar label="Music" value={venue.ratings.music} />
            <RatingBar label="Vibe" value={venue.ratings.vibe} />
            <RatingBar label="Crowd" value={venue.ratings.crowd} />
            <RatingBar label="Safety" value={venue.ratings.safety} />
          </div>
        </Card>

        {/* Add Review Button */}
        <Link to="/submit" state={{ venueId: venue.id, venueName: venue.name }}>
          <Button className="w-full justify-center">
            <MessageCircle size={16} className="mr-2" />
            Add Review
          </Button>
        </Link>

        {/* Reviews */}
        <div>
          <h3 className="font-space text-lg text-ink mb-4">
            Recent Reviews ({reviews.length})
          </h3>
          
          {reviews.length === 0 ? (
            <Card>
              <p className="text-ash text-center py-4">
                No reviews yet. Be the first to share your experience!
              </p>
            </Card>
          ) : (
            <div className="space-y-4">
              {reviews.map((review, index) => (
                <motion.div
                  key={review.id}
                  initial={{ y: 20, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  transition={{ delay: index * 0.1 }}
                >
                  <Card>
                    <div className="flex items-start space-x-3">
                      <Avatar
                        name={review.authorName || 'Anonymous'}
                        isAnonymous={review.isAnonymous}
                      />
                      <div className="flex-1">
                        <div className="flex items-center justify-between mb-2">
                          <span className="text-sm text-ink font-medium">
                            {review.isAnonymous ? 'Anonymous' : review.authorName}
                          </span>
                          <span className="text-xs text-ash">
                            {formatTimeAgo(review.createdAt)}
                          </span>
                        </div>
                        
                        <p className="text-sm text-ash mb-3 leading-relaxed">
                          {review.comment}
                        </p>
                        
                        <div className="grid grid-cols-2 gap-2">
                          {Object.entries(review.ratings).map(([key, value]) => (
                            <div key={key} className="flex justify-between text-xs">
                              <span className="text-ash capitalize">{key}:</span>
                              <span className="text-ink font-medium">{value}%</span>
                            </div>
                          ))}
                        </div>
                        
                        {review.queueTime && (
                          <div className="mt-2 text-xs text-ash">
                            Queue time: {review.queueTime} minutes
                          </div>
                        )}
                      </div>
                    </div>
                  </Card>
                </motion.div>
              ))}
            </div>
          )}
        </div>
      </div>
    </motion.div>
  );
};

export default VenueDetail;