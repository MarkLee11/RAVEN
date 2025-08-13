import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, Users, Clock, MapPin, Heart, UserPlus } from 'lucide-react';
import { Plan, PlanMember } from '../contracts/types';
import { plansService } from '../services/plansService';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import Avatar from '../components/Avatar';

const PlanDetail: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [plan, setPlan] = useState<Plan | null>(null);
  const [members, setMembers] = useState<PlanMember[]>([]);
  const [loading, setLoading] = useState(true);
  const [isJoined, setIsJoined] = useState(false);
  const [isJoining, setIsJoining] = useState(false);

  useEffect(() => {
    if (id) {
      loadPlanData(id);
    }
  }, [id]);

  const loadPlanData = async (planId: string) => {
    setLoading(true);
    try {
      const [planData, membersData] = await Promise.all([
        plansService.getPlan(planId),
        plansService.getPlanMembers(planId)
      ]);

      setPlan(planData);
      setMembers(membersData);
    } catch (error) {
      console.error('Failed to load plan data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleJoinPlan = async () => {
    if (!plan) return;
    
    setIsJoining(true);
    try {
      const result = await plansService.joinPlan({
        planId: plan.id,
        memberName: 'You', // In real app, this would be the current user
        message: 'Looking forward to the night!'
      });

      if (result.success && result.member) {
        setMembers(prev => [...prev, result.member!]);
        setIsJoined(true);
        // Show success toast here
      }
    } catch (error) {
      console.error('Failed to join plan:', error);
      // Show error toast here
    } finally {
      setIsJoining(false);
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

  if (loading) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!plan) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="text-center">
          <p className="text-ash mb-4">Plan not found</p>
          <Button onClick={() => navigate('/plans')}>Back to Plans</Button>
        </div>
      </div>
    );
  }

  const isFull = members.length >= plan.maxMembers;

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
              <h1 className="font-space text-xl text-ink">{plan.title}</h1>
              {plan.isLGBTQFriendly && (
                <Heart size={16} className="text-raven" />
              )}
            </div>
            <div className="flex items-center space-x-2 text-sm text-ash">
              <Clock size={12} />
              <span>{plan.timeWindow}</span>
            </div>
          </div>
        </div>
      </div>

      <div className="px-4 pt-4 space-y-6">
        {/* Description */}
        <Card>
          <p className="text-ash text-sm leading-relaxed">{plan.description}</p>
        </Card>

        {/* Tags */}
        <div className="flex flex-wrap gap-2">
          {plan.tags.map(tag => (
            <Badge key={tag}>{tag}</Badge>
          ))}
        </div>

        {/* Location Info */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-3">Meetup Location</h3>
          <div className="space-y-3">
            <div className="flex items-center space-x-2">
              <MapPin size={16} className="text-ash" />
              <span className="text-sm text-ink">{plan.meetupHint}</span>
            </div>
            
            {(isJoined || members.length >= plan.maxMembers) && plan.preciseLocation && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: 'auto' }}
                className="bg-raven/10 p-3 rounded border border-raven/30"
              >
                <p className="text-xs text-raven mb-1 font-medium">PRECISE LOCATION</p>
                <p className="text-sm text-ink">{plan.preciseLocation}</p>
              </motion.div>
            )}
          </div>
        </Card>

        {/* Languages */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-3">Languages</h3>
          <div className="flex items-center space-x-3">
            {plan.languages.map(lang => (
              <div key={lang} className="flex items-center space-x-1">
                <span className="text-lg">{getLanguageFlag(lang)}</span>
                <span className="text-sm text-ash">{lang}</span>
              </div>
            ))}
          </div>
        </Card>

        {/* Members */}
        <Card>
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-space text-lg text-ink">
              Crew ({members.length}/{plan.maxMembers})
            </h3>
            <div className="flex items-center space-x-1 text-sm">
              <Users size={14} className="text-ash" />
              <span className={`${isFull ? 'text-blood' : 'text-raven'}`}>
                {isFull ? 'Full' : `${plan.maxMembers - members.length} spots left`}
              </span>
            </div>
          </div>

          <div className="space-y-3">
            {members.map(member => (
              <div key={member.id} className="flex items-center space-x-3">
                <Avatar name={member.name} />
                <div className="flex-1">
                  <p className="text-sm text-ink font-medium">{member.name}</p>
                  <p className="text-xs text-ash">
                    Joined {new Date(member.joinedAt).toLocaleDateString()}
                  </p>
                </div>
              </div>
            ))}

            {!isFull && !isJoined && (
              <div className="flex items-center space-x-3 opacity-50">
                <div className="w-10 h-10 rounded-full border-2 border-dashed border-ash/50 flex items-center justify-center">
                  <UserPlus size={14} className="text-ash" />
                </div>
                <span className="text-sm text-ash">Your spot here</span>
              </div>
            )}
          </div>
        </Card>

        {/* Join Button */}
        <div className="space-y-3">
          {!isJoined && !isFull && (
            <Button
              onClick={handleJoinPlan}
              isLoading={isJoining}
              className="w-full justify-center"
            >
              <UserPlus size={16} className="mr-2" />
              Join This Plan
            </Button>
          )}
          
          {isJoined && (
            <Card className="border-raven/30 bg-raven/5">
              <div className="text-center py-2">
                <p className="text-raven font-medium text-sm">
                  ✓ You're in! See you tonight.
                </p>
              </div>
            </Card>
          )}
          
          {isFull && !isJoined && (
            <Card className="border-blood/30 bg-blood/5">
              <div className="text-center py-2">
                <p className="text-blood font-medium text-sm">
                  This plan is full
                </p>
              </div>
            </Card>
          )}
        </div>
      </div>
    </motion.div>
  );
};

export default PlanDetail;