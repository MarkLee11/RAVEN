import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { MapPin, Filter } from 'lucide-react';
import { Venue } from '../contracts/types';
import { barsService, getBarDistricts, getBarThemesByCategory } from '../services/barsService';
import { favoritesService } from '../services/favoritesService';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';
import AsyncStateView from '../components/ui/AsyncStateView';

const Bars: React.FC = () => {
  const navigate = useNavigate();
  const [bars, setBars] = useState<Venue[]>([]);
  const [districts, setDistricts] = useState<string[]>([]);
  const [themesByCategory, setThemesByCategory] = useState<Record<string, string[]>>({});
  const [loading, setLoading] = useState(true);
  const [selectedDistrict, setSelectedDistrict] = useState<string>('');
  const [selectedThemes, setSelectedThemes] = useState<string[]>([]);
  const [showFilters, setShowFilters] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [favoriteBarIds, setFavoriteBarIds] = useState<Record<string, boolean>>({});

  useEffect(() => {
    loadInitialData();
  }, []);

  const loadInitialData = async () => {
    try {
      const [districtsList, themesData] = await Promise.all([
        getBarDistricts(),
        getBarThemesByCategory()
      ]);
      setDistricts(districtsList);
      setThemesByCategory(themesData);
    } catch (error) {
      console.error('Failed to load initial data:', error);
    }
  };

  const loadBars = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const results = await barsService.listBars(
        selectedDistrict || undefined,
        selectedThemes.length > 0 ? selectedThemes : undefined
      );
      setBars(results);
      
      // Load favorite statuses for all bars
      if (results.length > 0) {
        const barIds = results.map(bar => bar.id);
        const favoriteStatuses = await favoritesService.getFavoriteStatuses(barIds, 'bar');
        setFavoriteBarIds(favoriteStatuses);
      }
    } catch (error) {
      console.error('Failed to load bars:', error);
      setError('Failed to load bars. Please try again.');
    } finally {
      setLoading(false);
    }
  }, [selectedDistrict, selectedThemes]);

  useEffect(() => {
    loadBars();
  }, [loadBars]);

  // Refresh favorite statuses when page becomes visible
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (!document.hidden && bars.length > 0) {
        const barIds = bars.map(bar => bar.id);
        favoritesService.getFavoriteStatuses(barIds, 'bar').then(favoriteStatuses => {
          setFavoriteBarIds(favoriteStatuses);
        });
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => {
      document.removeEventListener('visibilitychange', handleVisibilityChange);
    };
  }, [bars]);

  const toggleTheme = (theme: string) => {
    setSelectedThemes(prev =>
      prev.includes(theme)
        ? prev.filter(t => t !== theme)
        : [...prev, theme]
    );
  };

  const clearAllFilters = () => {
    setSelectedDistrict('');
    setSelectedThemes([]);
  };

  const toggleFavorite = async (barId: string) => {
    const success = await favoritesService.toggleFavorite(barId, 'bar');
    if (success) {
      setFavoriteBarIds(prev => ({
        ...prev,
        [barId]: !prev[barId]
      }));
    }
  };

  const getTotalFilters = () => {
    return (selectedDistrict ? 1 : 0) + selectedThemes.length;
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
            onClick={() => setShowFilters(prev => !prev)}
            aria-expanded={showFilters}
            aria-controls="filters-panel"
            aria-label="Toggle filters"
            className={`group -m-2 p-3 tap-fast flex items-center transition-colors filters-touch ${showFilters ? 'text-raven' : 'text-ash filters-hover'}`}
          >
            <span className="flex items-center">
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
             className="mb-6 max-h-96 overflow-y-auto overscroll-contain space-y-4"
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

            {/* Themes by Category */}
            {Object.entries(themesByCategory).map(([category, themes]) => (
              <div key={category}>
                <h4 className="text-sm font-medium text-ink mb-2 capitalize">{category}</h4>
                <div className="flex flex-wrap gap-2">
                  {themes.map(theme => (
                    <Badge
                      key={theme}
                      variant={selectedThemes.includes(theme) ? 'raven' : 'default'}
                      onClick={() => toggleTheme(theme)}
                    >
                      {theme}
                    </Badge>
                  ))}
                </div>
              </div>
            ))}

                         <div className="flex justify-between items-center pt-2">
               <button
                 onClick={() => setShowFilters(false)}
                 className="min-h-11 px-2 flex items-center space-x-2 text-raven hover:text-raven/80 transition-colors tap-fast"
                 aria-label="Close filters"
               >
                 <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                   <path d="m18 15-6-6-6 6"/>
                 </svg>
                 <span className="text-sm font-medium">Close</span>
               </button>
              <button
                onClick={clearAllFilters}
                className="min-h-11 px-4 py-2 text-sm bg-raven text-berlin-black rounded-md tap-fast"
              >
                clear all filters
              </button>
            </div>
          </motion.div>
        )}

        {/* Bars List */}
        <div className="space-y-4">
          {loading ? (
            <AsyncStateView
              loading
              loadingText="Loading bars..."
              emptyText="No bars match your filters."
              onRetry={loadBars}
            />
          ) : error ? (
            <AsyncStateView
              errorMessage={error}
              loadingText="Loading bars..."
              emptyText="No bars match your filters."
              onRetry={loadBars}
            />
          ) : bars.length === 0 ? (
            <AsyncStateView
              empty
              loadingText="Loading bars..."
              emptyText="No bars match your filters."
              onRetry={loadBars}
            />
          ) : (
            bars.map((bar, index) => (
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
                           className="min-h-11 px-4 py-2 text-sm bg-raven/10 text-raven border border-raven/30 rounded-md hover:bg-raven hover:text-berlin-black transition-colors whitespace-nowrap tap-fast"
                         >
                           Final Sip
                         </button>
                        <button
                          aria-label="Toggle favorite"
                          aria-pressed={!!favoriteBarIds[bar.id]}
                          onClick={() => toggleFavorite(bar.id)}
                          className="mt-1 -m-2 p-3 tap-fast"
                        >
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 24 24"
                            fill={favoriteBarIds[bar.id] ? '#8ACE00' : 'transparent'}
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
            ))
          )}
        </div>
      </div>
    </motion.div>
  );
};

export default Bars;