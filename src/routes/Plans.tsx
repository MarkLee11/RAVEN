import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Users, Clock, MapPin, Heart } from 'lucide-react';
import { Plan } from '../contracts/types';
import { plansService } from '../services/plansService';
import SectionHeader from '../components/SectionHeader';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';

const Plans: React.FC = () => {
  const [plans, setPlans] = useState<Plan[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadPlans();
  }, []);

  const loadPlans = async () => {
    setLoading(true);
    try {
      const results = await plansService.listPlans();
      setPlans(results);
    } catch (error) {
      console.error('Failed to load plans:', error);
    } finally {
      setLoading(false);
    }
  };

  const getLanguageFlag = (lang: string): string => {
    const flags: Record<string, string> = {
      'DE': '🇩🇪',
      'EN': '🇬🇧',
      'ES': '🇪🇸',
      'FR': '🇫🇷',
      'IT': '🇮🇹',
    };
    return flags[lang] || '🌍';
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-berlin-black"
    >

      <div className="px-4 pt-4">
        {loading ? (
          <div className="text-center py-12">
            <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
            <p className="text-ash mt-2">Loading plans...</p>
          </div>
        ) : plans.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-ash">No plans for tonight yet.</p>
          </div>
        ) : (
          <div className="space-y-4">
            {plans.map((plan, index) => (
              <motion.div
                key={plan.id}
                initial={{ y: 20, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ delay: index * 0.1 }}
              >
                <Link to={`/plans/${plan.id}`}>
                  <Card hover>
                    <div className="space-y-3">
                      {/* Header */}
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <h3 className="font-space text-lg text-ink mb-1">
                            {plan.title}
                          </h3>
                          <div className="flex items-center space-x-2 text-sm text-ash">
                            <Clock size={12} />
                            <span>{plan.timeWindow}</span>
                          </div>
                        </div>
                        {plan.isLGBTQFriendly && (
                          <Heart size={16} className="text-raven" />
                        )}
                      </div>

                      {/* Description */}
                      <p className="text-sm text-ash leading-relaxed">
                        {plan.description}
                      </p>

                      {/* Tags */}
                      <div className="flex flex-wrap gap-1">
                        {plan.tags.map(tag => (
                          <Badge key={tag} size="sm">
                            {tag}
                          </Badge>
                        ))}
                      </div>

                      {/* Meta Info */}
                      <div className="flex items-center justify-between">
                        <div className="flex items-center space-x-4 text-sm">
                          <div className="flex items-center space-x-1 text-ash">
                            <Users size={12} />
                            <span>{plan.currentMembers}/{plan.maxMembers}</span>
                          </div>
                          
                          <div className="flex items-center space-x-1 text-ash">
                            <MapPin size={12} />
                            <span className="truncate max-w-32">
                              {plan.meetupHint}
                            </span>
                          </div>
                        </div>

                        <div className="flex items-center space-x-1">
                          {plan.languages.slice(0, 3).map(lang => (
                            <span key={lang} className="text-sm">
                              {getLanguageFlag(lang)}
                            </span>
                          ))}
                          {plan.languages.length > 3 && (
                            <span className="text-xs text-ash">
                              +{plan.languages.length - 3}
                            </span>
                          )}
                        </div>
                      </div>
                    </div>
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