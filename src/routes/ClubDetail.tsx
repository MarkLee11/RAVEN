import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, MapPin } from 'lucide-react';
import { Venue, Review, VibeSummary } from '../contracts/types';
import { clubsService } from '../services/clubsService';
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

const ClubDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [club, setClub] = useState<Venue | null>(null);
  const [reviews, setReviews] = useState<Review[]>([]);
  const [vibeSummary, setVibeSummary] = useState<VibeSummary | null>(null);
  const [currentReviewPage, setCurrentReviewPage] = useState<number>(1);
  const REVIEWS_PER_PAGE = 5;
  const [loading, setLoading] = useState(true);
  const [isFavorite, setIsFavorite] = useState(false);

  useEffect(() => {
    if (id) {
      loadClubData(id);
    }
  }, [id]);

  useEffect(() => {
    // 页面加载时滚动到顶部
    window.scrollTo(0, 0);
  }, []);

  // Reset pagination when reviews change or club changes
  useEffect(() => {
    setCurrentReviewPage(1);
  }, [id, reviews.length]);

  const loadClubData = async (clubId: string) => {
    setLoading(true);
    try {
      const [clubData, reviewsData, vibeData, favoriteStatus] = await Promise.all([
        clubsService.getClub(clubId),
        reviewsService.listReviews(clubId),
        vibeService.getVibeSummary(clubId),
        favoritesService.isFavorite(clubId, 'club')
      ]);

      setClub(clubData);
      setReviews(reviewsData);
      setVibeSummary(vibeData);
      setIsFavorite(favoriteStatus);
    } catch (error) {
      console.error('Failed to load club data:', error);
    } finally {
      setLoading(false);
    }
  };

  // Optimistically prepend new review when coming back from submit
  useEffect(() => {
    const state = (window.history.state && (window.history.state as any).usr) || {};
    if (state && state.optimisticReview && id) {
      setReviews(prev => [state.optimisticReview as Review, ...prev]);
      // Clean it so it won't duplicate on re-entry
      window.history.replaceState({ ...window.history.state, usr: { ...state, optimisticReview: undefined } }, '');
    }
  }, [id]);

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
            onPointerDown={(e) => { e.preventDefault(); navigate(-1); }}
            aria-label="Go back"
            className="text-ash hover:text-ink transition-colors -m-2 p-3 tap-fast"
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
          <button
            aria-label="Toggle favorite"
            onClick={async () => {
              if (!club) return;
              const success = await favoritesService.toggleFavorite(club.id, 'club');
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

        {/* Add Review Button (Replaced with skewed arrow button) */}
        <Link to="/submit" state={{ venueId: club.id, venueName: club.name }} className="flex justify-center">
          <button className="cta">
            <span className="span">Spill</span>
            <span className="second">
              <svg
                width="50px"
                height="20px"
                viewBox="0 0 66 43"
                version="1.1"
                xmlns="http://www.w3.org/2000/svg"
                xmlnsXlink="http://www.w3.org/1999/xlink"
              >
                <g
                  id="arrow"
                  stroke="none"
                  strokeWidth="1"
                  fill="none"
                  fillRule="evenodd"
                >
                  <path
                    className="one"
                    d="M40.1543933,3.89485454 L43.9763149,0.139296592 C44.1708311,-0.0518420739 44.4826329,-0.0518571125 44.6771675,0.139262789 L65.6916134,20.7848311 C66.0855801,21.1718824 66.0911863,21.8050225 65.704135,22.1989893 C65.7000188,22.2031791 65.6958657,22.2073326 65.6916762,22.2114492 L44.677098,42.8607841 C44.4825957,43.0519059 44.1708242,43.0519358 43.9762853,42.8608513 L40.1545186,39.1069479 C39.9575152,38.9134427 39.9546793,38.5968729 40.1481845,38.3998695 C40.1502893,38.3977268 40.1524132,38.395603 40.1545562,38.3934985 L56.9937789,21.8567812 C57.1908028,21.6632968 57.193672,21.3467273 57.0001876,21.1497035 C56.9980647,21.1475418 56.9959223,21.1453995 56.9937605,21.1432767 L40.1545208,4.60825197 C39.9574869,4.41477773 39.9546013,4.09820839 40.1480756,3.90117456 C40.1501626,3.89904911 40.1522686,3.89694235 40.1543933,3.89485454 Z"
                    fill="#FFFFFF"
                  />
                  <path
                    className="two"
                    d="M20.1543933,3.89485454 L23.9763149,0.139296592 C24.1708311,-0.0518420739 24.4826329,-0.0518571125 24.6771675,0.139262789 L45.6916134,20.7848311 C46.0855801,21.1718824 46.0911863,21.8050225 45.704135,22.1989893 C45.7000188,22.2031791 45.6958657,22.2073326 45.6916762,22.2114492 L24.677098,42.8607841 C24.4825957,43.0519059 24.1708242,43.0519358 23.9762853,42.8608513 L20.1545186,39.1069479 C19.9575152,38.9134427 19.9546793,38.5968729 20.1481845,38.3998695 C20.1502893,38.3977268 20.1524132,38.395603 20.1545562,38.3934985 L36.9937789,21.8567812 C37.1908028,21.6632968 37.193672,21.3467273 37.0001876,21.1497035 C36.9980647,21.1475418 36.9959223,21.1453995 36.9937605,21.1432767 L20.1545208,4.60825197 C19.9574869,4.41477773 19.9546013,4.09820839 20.1480756,3.90117456 C20.1501626,3.89904911 20.1522686,3.89694235 20.1543933,3.89485454 Z"
                    fill="#FFFFFF"
                  />
                  <path
                    className="three"
                    d="M0.154393339,3.89485454 L3.97631488,0.139296592 C4.17083111,-0.0518420739 4.48263286,-0.0518571125 4.67716753,0.139262789 L25.6916134,20.7848311 C26.0855801,21.1718824 26.0911863,21.8050225 25.704135,22.1989893 C25.7000188,22.2031791 25.6958657,22.2073326 25.6916762,22.2114492 L4.67709797,42.8607841 C4.48259567,43.0519059 4.17082418,43.0519358 3.97628526,42.8608513 L0.154518591,39.1069479 C-0.0424848215,38.9134427 -0.0453206733,38.5968729 0.148184538,38.3998695 C0.150289256,38.3977268 0.152413239,38.395603 0.154556228,38.3934985 L16.9937789,21.8567812 C17.1908028,21.6632968 17.193672,21.3467273 17.0001876,21.1497035 C16.9980647,21.1475418 16.9959223,21.1453995 16.9937605,21.1432767 L0.15452076,4.60825197 C-0.0425130651,4.41477773 -0.0453986756,4.09820839 0.148075568,3.90117456 C0.150162624,3.89904911 0.152268631,3.89694235 0.154393339,3.89485454 Z"
                    fill="#FFFFFF"
                  />
                </g>
              </svg>
            </span>
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
              {reviews
                .slice((currentReviewPage - 1) * REVIEWS_PER_PAGE, currentReviewPage * REVIEWS_PER_PAGE)
                .map((review, index) => (
                <motion.div
                  key={review.id}
                  initial={{ y: 20, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  transition={{ delay: index * 0.05 }}
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
              {/* Pagination Controls */}
              {reviews.length > REVIEWS_PER_PAGE && (
                <div className="flex items-center justify-between pt-2">
                  <button
                    onPointerDown={(e) => { e.preventDefault(); setCurrentReviewPage(p => Math.max(1, p - 1)); }}
                    disabled={currentReviewPage === 1}
                    className="px-3 py-1 text-xs bg-raven text-berlin-black rounded-md disabled:opacity-40 tap-fast"
                  >
                    Previous
                  </button>
                  <span className="text-xs text-ash">
                    <span className="text-raven">{currentReviewPage}</span>
                    <span> / </span>
                    <span className="text-raven">{Math.ceil(reviews.length / REVIEWS_PER_PAGE)}</span>
                  </span>
                  <button
                    onPointerDown={(e) => { e.preventDefault(); setCurrentReviewPage(p => Math.min(Math.ceil(reviews.length / REVIEWS_PER_PAGE), p + 1)); }}
                    disabled={currentReviewPage >= Math.ceil(reviews.length / REVIEWS_PER_PAGE)}
                    className="px-3 py-1 text-xs bg-raven text-berlin-black rounded-md disabled:opacity-40 tap-fast"
                  >
                    Next
                  </button>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </motion.div>
  );
};

export default ClubDetail;