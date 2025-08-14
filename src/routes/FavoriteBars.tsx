import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, MapPin, Heart } from 'lucide-react';
import { favoritesService, FavoriteVenue } from '../services/favoritesService';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';

const FavoriteBars: React.FC = () => {
  const navigate = useNavigate();
  const [favoriteBars, setFavoriteBars] = useState<FavoriteVenue[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    loadFavoriteBars();
  }, []);

  const loadFavoriteBars = async () => {
    setLoading(true);
    setError(null);
    try {
      const favorites = await favoritesService.getFavoriteBars();
      setFavoriteBars(favorites);
    } catch (error) {
      console.error('Failed to load favorite bars:', error);
      setError('Failed to load favorite bars. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const removeFavorite = async (barId: string) => {
    const success = await favoritesService.removeFavorite(barId, 'bar');
    if (success) {
      setFavoriteBars(prev => prev.filter(bar => bar.id !== barId));
    }
  };

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
            <h1 className="font-space text-xl text-ink">Favorite Bars</h1>
            <p className="text-sm text-ash">{favoriteBars.length} saved</p>
          </div>
        </div>
      </div>

      <div className="px-4 pt-4">
        {loading ? (
          <div className="text-center py-12">
            <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
            <p className="text-ash mt-2">Loading favorite bars...</p>
          </div>
        ) : error ? (
          <div className="text-center py-12">
            <p className="text-blood mb-4">{error}</p>
            <button 
              onClick={loadFavoriteBars}
              className="text-raven hover:text-ink transition-colors"
            >
              Try Again
            </button>
          </div>
        ) : favoriteBars.length === 0 ? (
          <div className="text-center py-12">
            <Heart size={48} className="text-ash mx-auto mb-4 opacity-50" />
            <p className="text-ash mb-2">No favorite bars yet</p>
            <p className="text-ash/60 text-sm">Start exploring bars and save your favorites!</p>
            <button
              onClick={() => navigate('/bars')}
              className="mt-4 px-4 py-2 bg-raven text-berlin-black rounded-md hover:bg-raven/80 transition-colors"
            >
              Browse Bars
            </button>
          </div>
        ) : (
          <div className="space-y-4">
            {favoriteBars.map((bar, index) => (
              <motion.div
                key={bar.id}
                initial={{ y: 20, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: index * 0.1 }}
              >
                <Card hover>
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex-1">
                      <div className="flex items-center space-x-2 mb-1">
                        <h3 className="font-space text-lg text-ink">{bar.name}</h3>
                      </div>
                      <div className="flex items-center space-x-1 text-sm text-ash mb-2">
                        <MapPin size={12} />
                        <span>{bar.district}</span>
                      </div>
                    </div>
                    <div className="ml-3 flex flex-col items-end">
                      <button
                        onClick={() => navigate(`/bars/${bar.id}`)}
                        className="px-4 py-2 text-sm bg-raven/10 text-raven border border-raven/30 rounded-md hover:bg-raven hover:text-berlin-black transition-colors whitespace-nowrap"
                      >
                        Final Sip
                      </button>
                      <button
                        aria-label="Remove from favorites"
                        onClick={() => removeFavorite(bar.id)}
                        className="mt-2 p-1.5"
                      >
                        <svg
                          width="20"
                          height="20"
                          viewBox="0 0 24 24"
                          fill="#8ACE00"
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

                  {/* Description */}
                  {bar.description && (
                    <p className="text-sm text-ash mb-3 leading-relaxed line-clamp-2">
                      {bar.description}
                    </p>
                  )}

                  <div className="flex flex-wrap gap-1 mb-3">
                    {bar.tags.map(tag => (
                      <Badge key={tag} size="sm">
                        {tag}
                      </Badge>
                    ))}
                  </div>

                  <div className="grid grid-cols-2 gap-3">
                    <RatingBar label="Quality" value={bar.ratings.music} />
                    <RatingBar label="Vibe" value={bar.ratings.vibe} />
                    <RatingBar label="Price" value={bar.ratings.crowd} />
                    <RatingBar label="Friendliness" value={bar.ratings.safety} />
                  </div>
                </Card>
              </motion.div>
            ))}
          </div>
        )}
      </div>
    </motion.div>
  );
};

export default FavoriteBars;
