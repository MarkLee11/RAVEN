import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { MapPin, Filter } from 'lucide-react';
import { Venue, District, VenueTag } from '../contracts/types';
import { clubsService } from '../services/clubsService';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';

const districts: District[] = ['Kreuzberg', 'Friedrichshain', 'Neukölln', 'Mitte', 'Prenzlauer Berg', 'Wedding'];
const clubTags: VenueTag[] = ['techno', 'house', 'underground', 'queer-friendly', 'outdoor', 'cash-only', 'smoke-room', 'late-night', 'tourist-free'];

const Clubs: React.FC = () => {
  const [clubs, setClubs] = useState<Venue[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedDistrict, setSelectedDistrict] = useState<string>('');
  const [selectedTags, setSelectedTags] = useState<string[]>([]);
  const [showFilters, setShowFilters] = useState(false);

  useEffect(() => {
    loadClubs();
  }, [selectedDistrict, selectedTags]);

  const loadClubs = async () => {
    setLoading(true);
    try {
      const results = await clubsService.listClubs(
        selectedDistrict || undefined,
        selectedTags.length > 0 ? selectedTags : undefined
      );
      setClubs(results);
    } catch (error) {
      console.error('Failed to load clubs:', error);
    } finally {
      setLoading(false);
    }
  };

  const toggleTag = (tag: string) => {
    setSelectedTags(prev =>
      prev.includes(tag)
        ? prev.filter(t => t !== tag)
        : [...prev, tag]
    );
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-berlin-black"
    >
      <div className="px-4 pt-4">
        {/* Filters Toggle */}
        <div className="flex items-center justify-between mb-4">
          <button
            onClick={() => setShowFilters(!showFilters)}
            className="flex items-center space-x-2 text-ash hover:text-ink transition-colors"
          >
            <Filter size={16} />
            <span className="text-sm">Filters</span>
            {(selectedDistrict || selectedTags.length > 0) && (
              <Badge variant="raven" size="sm">
                {(selectedDistrict ? 1 : 0) + selectedTags.length}
              </Badge>
            )}
          </button>
        </div>

        {/* Filters Panel */}
        {showFilters && (
          <motion.div
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
                  className="cursor-pointer"
                  onClick={() => setSelectedDistrict('')}
                >
                  All
                </Badge>
                {districts.map(district => (
                  <Badge
                    key={district}
                    variant={selectedDistrict === district ? 'raven' : 'default'}
                    className="cursor-pointer"
                    onClick={() => setSelectedDistrict(
                      selectedDistrict === district ? '' : district
                    )}
                  >
                    {district}
                  </Badge>
                ))}
              </div>
            </div>

            {/* Tags */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2">Vibe</h4>
              <div className="flex flex-wrap gap-2">
                {clubTags.map(tag => (
                  <Badge
                    key={tag}
                    variant={selectedTags.includes(tag) ? 'raven' : 'default'}
                    className="cursor-pointer"
                    onClick={() => toggleTag(tag)}
                  >
                    {tag}
                  </Badge>
                ))}
              </div>
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
                <Link to={`/clubs/${club.id}`}>
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
                    </div>

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
                </Link>
              </motion.div>
            ))
          )}
        </div>
      </div>
    </motion.div>
  );
};

export default Clubs;