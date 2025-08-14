import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, MapPin, Star, MessageCircle } from 'lucide-react';
import { Venue, Review, VibeSummary } from '../contracts/types';
import { barsService } from '../services/barsService';
import { reviewsService } from '../services/reviewsService';
import { vibeService } from '../services/vibeService';
import { favoritesService } from '../services/favoritesService';
import { formatTimeAgo } from '../lib/utils';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';
import VibeCard from '../components/VibeCard';
import Avatar from '../components/Avatar';

const BarDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [bar, setBar] = useState<Venue | null>(null);
  const [reviews, setReviews] = useState<Review[]>([]);
  const [vibeSummary, setVibeSummary] = useState<VibeSummary | null>(null);
  const [loading, setLoading] = useState(true);
  const [isFavorite, setIsFavorite] = useState(false);

  useEffect(() => {
    if (id) {
      loadBarData(id);
    }
  }, [id]);

  useEffect(() => {
    // 页面加载时滚动到顶部
    window.scrollTo(0, 0);
  }, []);

  const loadBarData = async (barId: string) => {
    setLoading(true);
    try {
      const [barData, reviewsData, favoriteStatus] = await Promise.all([
        barsService.getBar(barId),
        reviewsService.listBarReviews(barId),
        favoritesService.isFavorite(barId, 'bar')
      ]);

      setBar(barData);
      setReviews(reviewsData);
      setIsFavorite(favoriteStatus);
      // Bars don't have vibe summary feature
      setVibeSummary(null);
    } catch (error) {
      console.error('Failed to load bar data:', error);
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

  // Calculate average ratings from reviews, fallback to default bar ratings
  const calculateAverageRatings = () => {
    if (reviews.length === 0) {
      return bar?.ratings || { music: 0, vibe: 0, crowd: 0, safety: 0 };
    }
    
    const totals = reviews.reduce((acc, review) => ({
      music: acc.music + review.ratings.music,
      vibe: acc.vibe + review.ratings.vibe,
      crowd: acc.crowd + review.ratings.crowd,
      safety: acc.safety + review.ratings.safety,
    }), { music: 0, vibe: 0, crowd: 0, safety: 0 });
    
    return {
      music: Math.round(totals.music / reviews.length),
      vibe: Math.round(totals.vibe / reviews.length),
      crowd: Math.round(totals.crowd / reviews.length),
      safety: Math.round(totals.safety / reviews.length),
    };
  };

  const currentRatings = calculateAverageRatings();

  if (!bar) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="text-center">
          <p className="text-ash mb-4">Bar not found</p>
          <Button onClick={() => navigate('/bars')}>Back to Bars</Button>
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
              <h1 className="font-space text-xl text-ink">{bar.name}</h1>
              {bar.hasLiveVibe && (
                <Badge variant="raven" size="sm">LIVE</Badge>
              )}
            </div>
            <div className="flex items-center space-x-1 text-sm text-ash">
              <MapPin size={12} />
              <span>{bar.district}</span>
            </div>
          </div>
          <button
            aria-label="Toggle favorite"
            onClick={async () => {
              if (!bar) return;
              const success = await favoritesService.toggleFavorite(bar.id, 'bar');
              if (success) {
                setIsFavorite(prev => !prev);
              }
            }}
            className="p-1.5"
          >
            <svg
              width="20"
              height="20"
              viewBox="0 0 24 24"
              fill={isFavorite ? '#8ACE00' : 'transparent'}
              stroke="white"
              strokeWidth="1.5"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <polygon points="12 2 14.85 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 9.15 8.26 12 2" />
            </svg>
          </button>
        </div>
      </div>

      <div className="px-4 pt-4 space-y-6">
        {/* Tags */}
        <div className="flex flex-wrap gap-2">
          {bar.tags.map(tag => (
            <Badge key={tag}>{tag}</Badge>
          ))}
        </div>

        {/* Description */}
        {bar.description && (
          <Card>
            <p className="text-ash text-sm leading-relaxed">{bar.description}</p>
          </Card>
        )}

        {/* Tonight's Vibe */}
        {vibeSummary && <VibeCard summary={vibeSummary} />}

        {/* Ratings */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Overall Ratings</h3>
          <div className="grid grid-cols-2 gap-4">
            <RatingBar label="Quality" value={currentRatings.music} />
            <RatingBar label="Vibe" value={currentRatings.vibe} />
            <RatingBar label="Price" value={currentRatings.crowd} />
            <RatingBar label="Friendliness" value={currentRatings.safety} />
          </div>
        </Card>

        {/* Add Review Button */}
        <Link to="/submit" state={{ venueId: bar.id, venueName: bar.name, venueType: 'bar' }} className="flex justify-center">
          <button className="pour-words-button">
            Pour Words
            <div className="star-1">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                xmlSpace="preserve"
                version="1.1"
                style={{shapeRendering:"geometricPrecision", textRendering:"geometricPrecision", imageRendering:"optimizeQuality", fillRule:"evenodd", clipRule:"evenodd"}}
                viewBox="0 0 784.11 815.53"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g id="Layer_x0020_1">
                  <path
                    className="fil0"
                    d="M392.05 0c-20.9,210.08 -184.06,378.41 -392.05,407.78 207.96,29.37 371.12,197.68 392.05,407.74 20.93,-210.06 184.09,-378.37 392.05,-407.74 -207.98,-29.38 -371.16,-197.69 -392.06,-407.78z"
                  />
                </g>
              </svg>
            </div>
            <div className="star-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                xmlSpace="preserve"
                version="1.1"
                style={{shapeRendering:"geometricPrecision", textRendering:"geometricPrecision", imageRendering:"optimizeQuality", fillRule:"evenodd", clipRule:"evenodd"}}
                viewBox="0 0 784.11 815.53"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g id="Layer_x0020_1">
                  <path
                    className="fil0"
                    d="M392.05 0c-20.9,210.08 -184.06,378.41 -392.05,407.78 207.96,29.37 371.12,197.68 392.05,407.74 20.93,-210.06 184.09,-378.37 392.05,-407.74 -207.98,-29.38 -371.16,-197.69 -392.06,-407.78z"
                  />
                </g>
              </svg>
            </div>
            <div className="star-3">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                xmlSpace="preserve"
                version="1.1"
                style={{shapeRendering:"geometricPrecision", textRendering:"geometricPrecision", imageRendering:"optimizeQuality", fillRule:"evenodd", clipRule:"evenodd"}}
                viewBox="0 0 784.11 815.53"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g id="Layer_x0020_1">
                  <path
                    className="fil0"
                    d="M392.05 0c-20.9,210.08 -184.06,378.41 -392.05,407.78 207.96,29.37 371.12,197.68 392.05,407.74 20.93,-210.06 184.09,-378.37 392.05,-407.74 -207.98,-29.38 -371.16,-197.69 -392.06,-407.78z"
                  />
                </g>
              </svg>
            </div>
            <div className="star-4">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                xmlSpace="preserve"
                version="1.1"
                style={{shapeRendering:"geometricPrecision", textRendering:"geometricPrecision", imageRendering:"optimizeQuality", fillRule:"evenodd", clipRule:"evenodd"}}
                viewBox="0 0 784.11 815.53"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g id="Layer_x0020_1">
                  <path
                    className="fil0"
                    d="M392.05 0c-20.9,210.08 -184.06,378.41 -392.05,407.78 207.96,29.37 371.12,197.68 392.05,407.74 20.93,-210.06 184.09,-378.37 392.05,-407.74 -207.98,-29.38 -371.16,-197.69 -392.06,-407.78z"
                  />
                </g>
              </svg>
            </div>
            <div className="star-5">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                xmlSpace="preserve"
                version="1.1"
                style={{shapeRendering:"geometricPrecision", textRendering:"geometricPrecision", imageRendering:"optimizeQuality", fillRule:"evenodd", clipRule:"evenodd"}}
                viewBox="0 0 784.11 815.53"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g id="Layer_x0020_1">
                  <path
                    className="fil0"
                    d="M392.05 0c-20.9,210.08 -184.06,378.41 -392.05,407.78 207.96,29.37 371.12,197.68 392.05,407.74 20.93,-210.06 184.09,-378.37 392.05,-407.74 -207.98,-29.38 -371.16,-197.69 -392.06,-407.78z"
                  />
                </g>
              </svg>
            </div>
            <div className="star-6">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                xmlSpace="preserve"
                version="1.1"
                style={{shapeRendering:"geometricPrecision", textRendering:"geometricPrecision", imageRendering:"optimizeQuality", fillRule:"evenodd", clipRule:"evenodd"}}
                viewBox="0 0 784.11 815.53"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g id="Layer_x0020_1">
                  <path
                    className="fil0"
                    d="M392.05 0c-20.9,210.08 -184.06,378.41 -392.05,407.78 207.96,29.37 371.12,197.68 392.05,407.74 20.93,-210.06 184.09,-378.37 392.05,-407.74 -207.98,-29.38 -371.16,-197.69 -392.06,-407.78z"
                  />
                </g>
              </svg>
            </div>
          </button>
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
                          <div className="flex justify-between text-xs">
                            <span className="text-ash capitalize">quality:</span>
                            <span className="text-ink font-medium">{review.ratings.music}%</span>
                          </div>
                          <div className="flex justify-between text-xs">
                            <span className="text-ash capitalize">vibe:</span>
                            <span className="text-ink font-medium">{review.ratings.vibe}%</span>
                          </div>
                          <div className="flex justify-between text-xs">
                            <span className="text-ash capitalize">price:</span>
                            <span className="text-ink font-medium">{review.ratings.crowd}%</span>
                          </div>
                          <div className="flex justify-between text-xs">
                            <span className="text-ash capitalize">friendliness:</span>
                            <span className="text-ink font-medium">{review.ratings.safety}%</span>
                          </div>
                        </div>
                        
                        {review.queueTime && (
                          <div className="mt-2 text-xs text-ash">
                            Wait time: {review.queueTime} minutes
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

export default BarDetail;