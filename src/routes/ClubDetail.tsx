import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, MapPin, Star, MessageCircle } from 'lucide-react';
import { Venue, Review, VibeSummary } from '../contracts/types';
import { clubsService } from '../services/clubsService';
import { reviewsService } from '../services/reviewsService';
import { vibeService } from '../services/vibeService';
import { formatTimeAgo } from '../lib/utils';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';
import VibeCard from '../components/VibeCard';
import Avatar from '../components/Avatar';

const ClubDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [club, setClub] = useState<Venue | null>(null);
  const [reviews, setReviews] = useState<Review[]>([]);
  const [vibeSummary, setVibeSummary] = useState<VibeSummary | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (id) {
      loadClubData(id);
    }
  }, [id]);

  const loadClubData = async (clubId: string) => {
    setLoading(true);
    try {
      const [clubData, reviewsData, vibeData] = await Promise.all([
        clubsService.getClub(clubId),
        reviewsService.listReviews(clubId),
        vibeService.getVibeSummary(clubId)
      ]);

      setClub(clubData);
      setReviews(reviewsData);
      setVibeSummary(vibeData);
    } catch (error) {
      console.error('Failed to load club data:', error);
    } finally {
      setLoading(false);
    }
  };

  // Calculate average ratings from reviews
  const calculateAverageRatings = () => {
    if (reviews.length === 0) {
      return club?.ratings || { music: 0, vibe: 0, crowd: 0, safety: 0 };
    }

    const totals = reviews.reduce(
      (acc, review) => ({
        music: acc.music + review.ratings.music,
        vibe: acc.vibe + review.ratings.vibe,
        crowd: acc.crowd + review.ratings.crowd,
        safety: acc.safety + review.ratings.safety,
      }),
      { music: 0, vibe: 0, crowd: 0, safety: 0 }
    );

    return {
      music: Math.round(totals.music / reviews.length),
      vibe: Math.round(totals.vibe / reviews.length),
      crowd: Math.round(totals.crowd / reviews.length),
      safety: Math.round(totals.safety / reviews.length),
    };
  };

  const averageRatings = calculateAverageRatings();

  if (loading) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!club) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="text-center">
          <p className="text-ash mb-4">Club not found</p>
          <Button onClick={() => navigate('/clubs')}>Back to Clubs</Button>
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
              <h1 className="font-space text-xl text-ink">{club.name}</h1>
            </div>
            <div className="flex items-center space-x-1 text-sm text-ash">
              <MapPin size={12} />
              <span>{club.district}</span>
            </div>
          </div>
        </div>
      </div>

      <div className="px-4 pt-4 space-y-6">
        {/* Tags */}
        <div className="flex flex-wrap gap-2">
          {club.tags.map(tag => (
            <Badge key={tag}>{tag}</Badge>
          ))}
        </div>

        {/* Description */}
        {club.description && (
          <Card>
            <p className="text-ash text-sm leading-relaxed">{club.description}</p>
          </Card>
        )}

        {/* Tonight's Vibe */}
        {vibeSummary && <VibeCard summary={vibeSummary} />}

        {/* Ratings */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Overall Ratings</h3>
          <div className="grid grid-cols-2 gap-4">
            <RatingBar label="Music" value={averageRatings.music} />
            <RatingBar label="Vibe" value={averageRatings.vibe} />
            <RatingBar label="Crowd" value={averageRatings.crowd} />
            <RatingBar label="Safety" value={averageRatings.safety} />
          </div>
        </Card>

        {/* Add Review Button */}
        <Link to="/submit" state={{ venueId: club.id, venueName: club.name }}>
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
                    <div>
                      <div className="flex justify-end mb-2">
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

export default ClubDetail;