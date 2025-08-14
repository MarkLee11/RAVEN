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
      'zur-letzten-instanz': '11:00 - 24:00',
      'prater-garten': '12:00 - 24:00 (夏季延长)',
      'hackescher-hof': '17:00 - 02:00',
      'zur-wilden-renate': '20:00 - 06:00',
      'monkey-bar': '12:00 - 02:00',
    };
    return hours[barId] || '营业时间详询';
  };

  // 获取推荐饮品
  const getRecommendedDrinks = (barId: string): string[] => {
    const drinks: Record<string, string[]> = {
      'zur-letzten-instanz': ['柏林白啤', '传统德式香肠'],
      'prater-garten': ['Prater特制啤酒', '烤猪肘'],
      'hackescher-hof': ['经典马天尼', '威士忌品鉴'],
      'zur-wilden-renate': ['创意鸡尾酒', '深夜特调'],
      'monkey-bar': ['景观鸡尾酒', '精品威士忌'],
    };
    return drinks[barId] || ['招牌饮品'];
  };

  // 页面标题
  React.useEffect(() => {
    document.title = 'RAVEN - 酒吧评价';
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
          <h2 className="font-space text-xl text-ink">酒吧评价</h2>
          <button
            onClick={() => setShowFilters(!showFilters)}
            className="flex items-center space-x-2 text-ash hover:text-ink transition-colors"
          >
            <Filter size={16} />
            <span className="text-sm">筛选</span>
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
              <h4 className="text-sm font-medium text-ink mb-2">区域</h4>
              <div className="flex flex-wrap gap-2">
                <Badge
                  variant={selectedDistrict === '' ? 'raven' : 'default'}
                  className="cursor-pointer"
                  onClick={() => setSelectedDistrict('')}
                >
                  全部
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
              <h4 className="text-sm font-medium text-ink mb-2">风格</h4>
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
            <p className="text-ash mt-2">加载酒吧信息中...</p>
          </div>
        ) : bars.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-ash">没有符合条件的酒吧。</p>
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
                            <Badge variant="raven" size="sm">热门</Badge>
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
                        <span>推荐: {getRecommendedDrinks(bar.id).join(', ')}</span>
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
                      <RatingBar label="音乐" value={bar.ratings.music} />
                      <RatingBar label="氛围" value={bar.ratings.vibe} />
                      <RatingBar label="人群" value={bar.ratings.crowd} />
                      <RatingBar label="安全" value={bar.ratings.safety} />
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