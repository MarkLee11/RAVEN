import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { MapPin, Filter } from 'lucide-react';
import { Venue } from '../contracts/types';
import { clubsService, getDistricts } from '../services/clubsService';
import { favoritesService } from '../services/favoritesService';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';

// Construction filters
const constructionFilters = [
  { key: 'outdoor-area', label: 'Outdoor Area' },
  { key: 'smoking-area', label: 'Smoking Area' },
  { key: 'awareness-room', label: 'Awareness Room' },
  { key: 'dark-room', label: 'Dark Room' },
  { key: 'cursing-area', label: 'Cursing Area' },
];

// Payment filters
const paymentFilters = [
  { key: 'cash-only', label: 'Cash Only' },
  { key: 'card-accepted', label: 'Card Accepted' },
];

const Clubs: React.FC = () => {
  const navigate = useNavigate();
  const [clubs, setClubs] = useState<Venue[]>([]);
  const [districts, setDistricts] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedDistrict, setSelectedDistrict] = useState<string>('');
  const [selectedConstruction, setSelectedConstruction] = useState<string[]>([]);
  const [selectedPayment, setSelectedPayment] = useState<string[]>([]);
  const [showFilters, setShowFilters] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [favoriteClubIds, setFavoriteClubIds] = useState<Record<string, boolean>>({});

  useEffect(() => {
    loadDistricts();
    loadClubs();
  }, [selectedDistrict, selectedConstruction, selectedPayment]);

  // Refresh favorite statuses when page becomes visible
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (!document.hidden && clubs.length > 0) {
        const clubIds = clubs.map(club => club.id);
        favoritesService.getFavoriteStatuses(clubIds, 'club').then(favoriteStatuses => {
          setFavoriteClubIds(favoriteStatuses);
        });
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange);
    };
  }, [clubs]);

  const loadDistricts = async () => {
    try {
      const districtList = await getDistricts();
      setDistricts(districtList);
    } catch (error) {
      console.error('Failed to load districts:', error);
    }
  };

  const loadClubs = async () => {
    setLoading(true);
    setError(null);
    try {
      const results = await clubsService.listClubs(
        selectedDistrict || undefined,
        selectedConstruction.length > 0 ? selectedConstruction : undefined,
        selectedPayment.length > 0 ? selectedPayment : undefined
      );
      setClubs(results);
      
      // Load favorite statuses for all clubs
      if (results.length > 0) {
        const clubIds = results.map(club => club.id);
        const favoriteStatuses = await favoritesService.getFavoriteStatuses(clubIds, 'club');
        setFavoriteClubIds(favoriteStatuses);
      }
    } catch (error) {
      console.error('Failed to load clubs:', error);
      setError('Failed to load clubs. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const toggleConstruction = (filter: string) => {
    setSelectedConstruction(prev =>
      prev.includes(filter)
        ? prev.filter(f => f !== filter)
        : [...prev, filter]
    );
  };

  const togglePayment = (filter: string) => {
    setSelectedPayment(prev => (prev.includes(filter) ? [] : [filter]));
  };

  const clearAllFilters = () => {
    setSelectedDistrict('');
    setSelectedConstruction([]);
    setSelectedPayment([]);
  };

  const toggleFavorite = async (clubId: string) => {
    const success = await favoritesService.toggleFavorite(clubId, 'club');
    if (success) {
      setFavoriteClubIds(prev => ({
        ...prev,
        [clubId]: !prev[clubId]
      }));
    }
  };

  const getTotalFilters = () => {
    return (selectedDistrict ? 1 : 0) + selectedConstruction.length + selectedPayment.length;
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0, transition: { duration: 0.05 } }}
      className="min-h-screen bg-berlin-black"
    >
      <div className="px-4 pt-4">
        {/* Filters Toggle */}
        <div className="flex items-center justify-between mb-4">
          <button
            onPointerDown={(e) => { e.preventDefault(); setShowFilters(prev => !prev); }}
            aria-expanded={showFilters}
            aria-controls="filters-panel"
            className={`group flex items-center transition-colors filters-touch ${showFilters ? 'text-raven' : 'text-ash filters-hover'}`}
          >
            <span className="-mx-3 px-3 py-2 flex items-center">
              <Filter size={16} />
              <span className="text-sm ml-2">Filters</span>
            </span>
            {getTotalFilters() > 0 && (
              <Badge variant="raven" size="sm">
                {getTotalFilters()}
              </Badge>
            )}
          </button>
        </div>

        {/* Filters Panel */}
        {showFilters && (
          <motion.div
            id="filters-panel"
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: 'auto', opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            className="mb-6 space-y-4 overflow-hidden"
          >
            {/* Districts */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2">District</h4>
              <div className="flex flex-wrap gap-2">
                <Badge
                  variant={selectedDistrict === '' ? 'raven' : 'default'}
                  onClick={() => setSelectedDistrict('')}
                >
                  All
                </Badge>
                {districts.map(district => (
                  <Badge
                    key={district}
                    variant={selectedDistrict === district ? 'raven' : 'default'}
                    onClick={() => setSelectedDistrict(
                      selectedDistrict === district ? '' : district
                    )}
                  >
                    {district}
                  </Badge>
                ))}
              </div>
            </div>

            {/* Construction */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2">Construction</h4>
              <div className="flex flex-wrap gap-2">
                {constructionFilters.map(filter => (
                  <Badge
                    key={filter.key}
                    variant={selectedConstruction.includes(filter.key) ? 'raven' : 'default'}
                    onClick={() => toggleConstruction(filter.key)}
                  >
                    {filter.label}
                  </Badge>
                ))}
              </div>
            </div>

            {/* Payment */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2">Payment</h4>
              <div className="flex flex-wrap gap-2">
                {paymentFilters.map(filter => (
                  <Badge
                    key={filter.key}
                    variant={selectedPayment.includes(filter.key) ? 'raven' : 'default'}
                    onClick={() => togglePayment(filter.key)}
                  >
                    {filter.label}
                  </Badge>
                ))}
              </div>
            </div>

            <div className="flex justify-end pt-2">
              <button
                onClick={clearAllFilters}
                className="px-3 py-1 text-xs bg-raven text-berlin-black rounded-md"
              >
                clear all filters
              </button>
            </div>
          </motion.div>
        )}

        {/* Clubs List */}
        <div className="space-y-4">
          {loading ? (
            <div className="text-center py-12">
              <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
              <p className="text-ash mt-2">Loading clubs...</p>
            </div>
          ) : error ? (
            <div className="text-center py-12">
              <p className="text-blood mb-4">{error}</p>
              <button 
                onClick={loadClubs}
                className="text-raven hover:text-ink transition-colors"
              >
                Try Again
              </button>
            </div>
          ) : clubs.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-ash">No clubs match your filters.</p>
            </div>
          ) : (
            clubs.map((club, index) => (
              <motion.div
                key={club.id}
                initial={{ y: 20, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: index * 0.1 }}
              >
                <Card hover>
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex-1">
                        <div className="flex items-center space-x-2 mb-1">
                          <h3 className="font-space text-lg text-ink">{club.name}</h3>
                        </div>
                        <div className="flex items-center space-x-1 text-sm text-ash mb-2">
                          <MapPin size={12} />
                          <span>{club.district}</span>
                        </div>
                      </div>
                      <div className="ml-3 flex flex-col items-end">
                        <button
                          onPointerDown={(e) => { e.preventDefault(); navigate(`/clubs/${club.id}`); }}
                          className="px-4 py-2 text-sm bg-raven/10 text-raven border border-raven/30 rounded-md hover:bg-raven hover:text-berlin-black transition-colors whitespace-nowrap"
                        >
                          Last Words Echohall
                        </button>
                        <button
                          aria-label="Toggle favorite"
                          onClick={() => toggleFavorite(club.id)}
                          className="mt-2 p-1.5"
                        >
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 24 24"
                            fill={favoriteClubIds[club.id] ? '#8ACE00' : 'transparent'}
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
                    {club.description && (
                      <p className="text-sm text-ash mb-3 leading-relaxed line-clamp-2">
                        {club.description}
                      </p>
                    )}

                    <div className="flex flex-wrap gap-1 mb-3">
                      {club.tags.map(tag => (
                        <Badge key={tag} size="sm">
                          {tag}
                        </Badge>
                      ))}
                    </div>

                    <div className="grid grid-cols-2 gap-3">
                      <RatingBar label="Music" value={club.ratings.music} />
                      <RatingBar label="Vibe" value={club.ratings.vibe} />
                      <RatingBar label="Crowd" value={club.ratings.crowd} />
                      <RatingBar label="Safety" value={club.ratings.safety} />
                    </div>
                </Card>
              </motion.div>
            ))
          )}
        </div>
      </div>
    </motion.div>
  );
};

export default Clubs;