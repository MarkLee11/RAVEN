import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { MapPin, Filter, Clock, Star } from 'lucide-react';
import { Venue, District, VenueTag } from '../contracts/types';
import { venuesService } from '../services/venuesService';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import RatingBar from '../components/RatingBar';

const districts: District[] = ['Kreuzberg', 'Friedrichshain', 'Neukölln', 'Mitte', 'Prenzlauer Berg', 'Wedding', 'Charlottenburg'];
const tags: VenueTag[] = ['historic', 'traditional', 'beer-garden', 'cocktails', 'upscale', 'alternative', 'quirky', 'rooftop', 'city-view', 'family-friendly'];

const Plans: React.FC = () => {
  const [bars, setBars] = useState<Venue[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedDistrict, setSelectedDistrict] = useState<string>('');
  const [selectedTags, setSelectedTags] = useState<string[]>([]);
  const [showFilters, setShowFilters] = useState(false);

  useEffect(() => {
    loadBars();
  }, [selectedDistrict, selectedTags]);

  const loadBars = async () => {
    setLoading(true);
    try {
      const results = await venuesService.listBars(
        selectedDistrict || undefined,
        selectedTags.length > 0 ? selectedTags : undefined
      );
      setBars(results);
    } catch (error) {
      console.error('Failed to load bars:', error);
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

  // 获取营业时间显示
  const getOperatingHours = (barId: string): string => {
    const hours: Record<string, string> = {
      'zur-letzten-instanz': '11:00 AM - 12:00 AM',
      'prater-garten': '12:00 PM - 12:00 AM (Extended in summer)',
      'hackescher-hof': '17:00 - 02:00',
      'zur-wilden-renate': '20:00 - 06:00',
      'monkey-bar': '12:00 - 02:00',
    };
    return hours[barId] || 'Hours vary';
  };

  // 获取推荐饮品
  const getRecommendedDrinks = (barId: string): string[] => {
    const drinks: Record<string, string[]> = {
      'zur-letzten-instanz': ['Berlin Weissbier', 'Traditional Bratwurst'],
      'prater-garten': ['Prater Special Beer', 'Roasted Pork Knuckle'],
      'hackescher-hof': ['Classic Martini', 'Whiskey Tasting'],
      'zur-wilden-renate': ['Creative Cocktails', 'Late Night Specials'],
      'monkey-bar': ['Panoramic Cocktails', 'Premium Whiskey'],
    };
    return drinks[barId] || ['Signature Drinks'];
  };

  // 页面标题
  React.useEffect(() => {
    document.title = 'RAVEN - Bar Reviews';
  }, []);

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-berlin-black"
    >
      <div className="px-4 pt-4">
        {/* Header */}
        <div className="flex items-center justify-between mb-4">
          <h2 className="font-space text-xl text-ink">Bar Reviews</h2>
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
              <h4 className="text-sm font-medium text-ink mb-2">Style</h4>
              <div className="flex flex-wrap gap-2">
                {tags.map(tag => (
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

        {/* Bars List */}
        {loading ? (
          <div className="text-center py-12">
            <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
            <p className="text-ash mt-2">Loading bars...</p>
          </div>
        ) : bars.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-ash">No bars match your criteria.</p>
          </div>
        ) : (
          <div className="space-y-4">
            {bars.map((bar, index) => (
              <motion.div
                key={bar.id}
                initial={{ y: 20, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: index * 0.1 }}
              >
                <Link to={`/venues/${bar.id}`}>
                  <Card hover className="relative overflow-hidden">
                    {/* Header */}
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex-1">
                        <div className="flex items-center space-x-2 mb-1">
                          <h3 className="font-space text-lg text-ink">{bar.name}</h3>
                          {bar.hasLiveVibe && (
                            <Badge variant="raven" size="sm">Hot</Badge>
                          )}
                        </div>
                        <div className="flex items-center space-x-1 text-sm text-ash mb-2">
                          <MapPin size={12} />
                          <span>{bar.district}</span>
                        </div>
                      </div>
                    </div>

                    {/* Description */}
                    <p className="text-sm text-ash leading-relaxed mb-3">
                      {bar.description}
                    </p>

                    {/* Additional Info */}
                    <div className="space-y-2 mb-3">
                      <div className="flex items-center space-x-2 text-xs text-ash">
                        <Clock size={12} />
                        <span>{getOperatingHours(bar.id)}</span>
                      </div>
                      <div className="flex items-center space-x-2 text-xs text-ash">
                        <Star size={12} />
                        <span>Recommended: {getRecommendedDrinks(bar.id).join(', ')}</span>
                      </div>
                    </div>

                    {/* Tags */}
                    <div className="flex flex-wrap gap-1 mb-3">
                      {bar.tags.map(tag => (
                        <Badge key={tag} size="sm">
                          {tag}
                        </Badge>
                      ))}
                    </div>

                    {/* Ratings */}
                    <div className="grid grid-cols-2 gap-3">
                      <RatingBar label="Music" value={bar.ratings.music} />
                      <RatingBar label="Vibe" value={bar.ratings.vibe} />
                      <RatingBar label="Crowd" value={bar.ratings.crowd} />
                      <RatingBar label="Safety" value={bar.ratings.safety} />
                    </div>

                    {/* Decorative element */}
                    <div className="absolute top-2 right-2 w-2 h-2 bg-raven/20 rounded-full" />
                  </Card>
                </Link>
              </motion.div>
            ))}
          </div>
        )}
      </div>
    </motion.div>
  );
};

export default Plans;