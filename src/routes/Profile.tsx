import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Mail, Lock, LogOut, Eye, EyeOff, MessageCircle } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { clubsService } from '../services/clubsService';
import { barsService } from '../services/barsService';
import { reviewsService } from '../services/reviewsService';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import { useAuth } from '../contexts/useAuth';

interface AuthRedirectState {
  returnTo?: string;
  returnState?: unknown;
  submitState?: {
    venueId: string;
    venueName?: string;
    venueType?: 'club' | 'bar';
  };
}

interface LatestReview {
  id: string;
  venueName: string;
  venueType: 'club' | 'bar';
  createdAt: Date;
  reviewText: string;
  ratings: {
    music: number;
    vibe: number;
    crowd: number;
    safety: number;
  };
}

interface LatestClubReviewRow {
  id: number | string;
  created_at: string;
  review_text: string | null;
  music_rating: number | null;
  crowd_rating: number | null;
  vibe_rating: number | null;
  safety_rating: number | null;
  clubs?: { name?: string } | Array<{ name?: string }>;
}

interface LatestBarReviewRow {
  id: number | string;
  created_at: string;
  review_text: string | null;
  quality_rating: number | null;
  price_rating: number | null;
  vibe_rating: number | null;
  friendliness_rating: number | null;
  bars?: { name?: string } | Array<{ name?: string }>;
}

const isAuthRedirectState = (state: unknown): state is AuthRedirectState => {
  if (!state || typeof state !== 'object') return false;
  const candidate = state as Record<string, unknown>;
  if (candidate.returnTo !== undefined && typeof candidate.returnTo !== 'string') return false;
  return true;
};

const Profile: React.FC = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { user, loading: checkingAuth } = useAuth();
  const [activeTab, setActiveTab] = useState<'login' | 'signup'>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [clubsTotal, setClubsTotal] = useState<number>(0);
  const [barsTotal, setBarsTotal] = useState<number>(0);
  const [loadingCounts, setLoadingCounts] = useState(true);
  const [userClubsVisited, setUserClubsVisited] = useState<number>(0);
  const [userBarsVisited, setUserBarsVisited] = useState<number>(0);
  const [loadingUserCounts, setLoadingUserCounts] = useState(true);
  const [latestReview, setLatestReview] = useState<LatestReview | null>(null);
  const [loadingReviews, setLoadingReviews] = useState(false);

  useEffect(() => {
    loadCounts();
  }, []);

  useEffect(() => {
    if (user) {
      loadUserCounts(user.id);
      loadLatestReview(user.id);
    } else {
      setUserClubsVisited(0);
      setUserBarsVisited(0);
      setLoadingUserCounts(false);
      setLatestReview(null);
    }
  }, [user]);

  const loadCounts = async () => {
    setLoadingCounts(true);
    try {
      const [clubsCount, barsCount] = await Promise.all([
        clubsService.getTotalCount(),
        barsService.getTotalCount()
      ]);
      setClubsTotal(clubsCount);
      setBarsTotal(barsCount);
    } catch (error) {
      console.error('Failed to load venue counts:', error);
    } finally {
      setLoadingCounts(false);
    }
  };

  const loadUserCounts = async (userId: string) => {
    setLoadingUserCounts(true);
    try {
      const [userClubsCount, userBarsCount] = await Promise.all([
        reviewsService.getUserClubsVisited(userId),
        reviewsService.getUserBarsVisited(userId)
      ]);
      setUserClubsVisited(userClubsCount);
      setUserBarsVisited(userBarsCount);
    } catch (error) {
      console.error('Failed to load user visit counts:', error);
    } finally {
      setLoadingUserCounts(false);
    }
  };

  const loadLatestReview = async (userId: string) => {
    setLoadingReviews(true);
    try {
      // Query both club_reviews and bar_reviews for the latest review
      const { data: clubReviews, error: clubError } = await supabase
        .from('club_reviews')
        .select(`
          id,
          created_at,
          review_text,
          music_rating,
          crowd_rating,
          vibe_rating,
          safety_rating,
          clubs!inner(name)
        `)
        .eq('user_id', userId)
        .order('created_at', { ascending: false })
        .limit(1)
        .returns<LatestClubReviewRow[]>();

      const { data: barReviews, error: barError } = await supabase
        .from('bar_reviews')
        .select(`
          id,
          created_at,
          review_text,
          quality_rating,
          price_rating,
          vibe_rating,
          friendliness_rating,
          bars!inner(name)
        `)
        .eq('user_id', userId)
        .order('created_at', { ascending: false })
        .limit(1)
        .returns<LatestBarReviewRow[]>();

      if (clubError) console.error('Club reviews error:', clubError);
      if (barError) console.error('Bar reviews error:', barError);

      // Find the most recent review between clubs and bars
      let mostRecentReview: LatestReview | null = null;
      
      if (clubReviews && clubReviews.length > 0) {
        const row = clubReviews[0];
        const clubName = Array.isArray(row.clubs)
          ? row.clubs[0]?.name
          : row.clubs?.name;
        mostRecentReview = {
          id: String(row.id),
          venueName: clubName || 'Unknown Club',
          venueType: 'club' as const,
          createdAt: new Date(row.created_at),
          reviewText: row.review_text || '',
          ratings: {
            music: Math.round((row.music_rating || 0) * 20),
            crowd: Math.round((row.crowd_rating || 0) * 20),
            vibe: Math.round((row.vibe_rating || 0) * 20),
            safety: Math.round((row.safety_rating || 0) * 20),
          }
        };
      }
      
      if (barReviews && barReviews.length > 0) {
        const row = barReviews[0];
        const barName = Array.isArray(row.bars)
          ? row.bars[0]?.name
          : row.bars?.name;
        const barReview = {
          id: String(row.id),
          venueName: barName || 'Unknown Bar',
          venueType: 'bar' as const,
          createdAt: new Date(row.created_at),
          reviewText: row.review_text || '',
          ratings: {
            music: Math.round(row.quality_rating || 0),
            crowd: Math.round(row.price_rating || 0),
            vibe: Math.round(row.vibe_rating || 0),
            safety: Math.round(row.friendliness_rating || 0),
          }
        };
        
        if (!mostRecentReview || barReview.createdAt > mostRecentReview.createdAt) {
          mostRecentReview = barReview;
        }
      }
      
      setLatestReview(mostRecentReview);
    } catch (error) {
      console.error('Failed to load latest review:', error);
    } finally {
      setLoadingReviews(false);
    }
  };

  const redirectAfterAuth = () => {
    const redirectState = isAuthRedirectState(location.state) ? location.state : null;
    if (redirectState?.returnTo) {
      navigate(redirectState.returnTo, {
        state: redirectState.returnState ?? redirectState.submitState,
        replace: true,
      });
    }
  };

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        setError(error.message);
        return;
      }

      if (data.session) {
        setEmail('');
        setPassword('');
        redirectAfterAuth();
      } else if (data.user) {
        setError('Please confirm your email before logging in.');
      }
    } catch (error) {
      setError('An unexpected error occurred');
      console.error('Login error:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSignup = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
      });

      if (error) {
        setError(error.message);
        return;
      }

      if (data.session) {
        setEmail('');
        setPassword('');
        redirectAfterAuth();
      } else if (data.user) {
        setEmail('');
        setPassword('');
        setError('Account created. Please check your email to confirm, then log in.');
        setActiveTab('login');
      }
    } catch (error) {
      setError('An unexpected error occurred');
      console.error('Signup error:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = async () => {
    try {
      const { error } = await supabase.auth.signOut();
      if (error) {
        console.error('Logout error:', error);
        return;
      }

      setEmail('');
      setPassword('');
    } catch (error) {
      console.error('Logout error:', error);
    }
  };

  if (checkingAuth) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  // Show authenticated user profile
  if (user) {
    return (
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        className="min-h-screen bg-berlin-black"
      >
        <div className="px-4 pt-4 space-y-6">
          {/* Profile Header */}
          <Card>
            <div className="flex items-start justify-between">
              <div className="flex items-center space-x-4">
                <div>
                  <h2 className="font-space text-xl text-ink">
                    ID
                  </h2>
                  <p className="text-sm text-ash">{user.email}</p>
                  <p className="text-xs text-ash mt-1">
                    Member since {new Date(user.created_at).toLocaleDateString()}
                  </p>
                </div>
              </div>
            </div>
          </Card>

          {/* Stats Placeholder */}
          {/*<Card>
            <h3 className="font-space text-lg text-ink mb-4">Your Activity</h3>
            <div className="grid grid-cols-2 gap-4">
              <div className="text-center">
                <div className="text-2xl font-bold text-raven mb-1">0</div>
                <div className="text-xs text-ash">Reviews</div>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-raven mb-1">0</div>
                <div className="text-xs text-ash">Plans Joined</div>
              </div>
            </div>
          </Card>*/}

          {/* Deathmarch */}
          <Card>
            <div className="mb-4 text-left">
              <h3 className="font-space text-lg text-ink mb-1">Deathmarch</h3>
              <p className="text-xs text-ash">Every venue visited brings you closer to transcendence</p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="text-center">
                <div className="text-2xl font-bold text-raven mb-1">
                  {loadingCounts || loadingUserCounts ? '...' : `${userClubsVisited}/${clubsTotal}`}
                </div>
                <div className="text-xs text-ash">Clubs</div>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-raven mb-1">
                  {loadingCounts || loadingUserCounts ? '...' : `${userBarsVisited}/${barsTotal}`}
                </div>
                <div className="text-xs text-ash">Bars</div>
              </div>
            </div>
          </Card>

          {/* Graveyard */}
          <Card>
            <h3 className="font-space text-lg text-ink mb-3">Graveyard</h3>
            <div className="flex flex-col space-y-3">
              <button 
                className="graveyard-button"
                onClick={() => navigate('/favorites/clubs')}
              >
                Clubs
                <div className="arrow-wrapper">
                  <div className="arrow"></div>
                </div>
              </button>
              <button 
                className="graveyard-button"
                onClick={() => navigate('/favorites/bars')}
              >
                Bars
                <div className="arrow-wrapper">
                  <div className="arrow"></div>
                </div>
              </button>
            </div>
          </Card>

          {/* Echo */}
          {/* Echo Card with Custom Gradient Style */}
          <div className="echo-card-container">
            <style>{`
              .echo-card {
                --background: linear-gradient(to right, #74ebd5 0%, #acb6e5 100%);
                width: 100%;
                min-height: 280px;
                padding: 5px;
                border-radius: 1rem;
                overflow: visible;
                background: #74ebd5;
                background: var(--background);
                position: relative;
                z-index: 1;
              }
              
              .echo-card::before,
              .echo-card::after {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border-radius: 1rem;
                z-index: -1;
              }
              
              .echo-card::before {
                background: linear-gradient(to bottom right, #f6d365 0%, #fda085 100%);
                transform: rotate(2deg);
              }
              
              .echo-card::after {
                background: linear-gradient(to top right, #84fab0 0%, #8fd3f4 100%);
                transform: rotate(-2deg);
              }
              
              .echo-card-info {
                --color: #1a1a1a;
                background: var(--color);
                color: white;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                align-items: stretch;
                width: 100%;
                height: 100%;
                min-height: 270px;
                overflow: visible;
                border-radius: 0.7rem;
                position: relative;
                z-index: 2;
                padding: 1rem;
              }
              
              .echo-card .title {
                font-weight: bold;
                letter-spacing: 0.1em;
                color: #74ebd5;
                margin-bottom: 1rem;
                font-size: 1.125rem;
              }
              
              .echo-card:hover::before,
              .echo-card:hover::after {
                opacity: 0;
                transition: opacity 0.3s ease;
              }
              
              .echo-card:hover .echo-card-info {
                color: #74ebd5;
                transition: color 1s;
              }
              
              .progress-bar {
                width: 100%;
                height: 6px;
                background-color: rgba(116, 235, 213, 0.2);
                border-radius: 3px;
                overflow: hidden;
                margin-top: 4px;
              }
              
              .progress-fill {
                height: 100%;
                background: linear-gradient(to right, #74ebd5, #acb6e5);
                border-radius: 3px;
                transition: width 0.3s ease;
              }
            `}</style>
            
            <div className="echo-card">
              <div className="echo-card-info">
                <h3 className="title">Echo</h3>
                
                {loadingReviews ? (
                  <div className="text-center py-8 flex-1 flex flex-col justify-center">
                    <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
                    <p className="text-gray-300 mt-2 text-sm">Loading latest review...</p>
                  </div>
                ) : !latestReview ? (
                  <div className="text-center py-8 flex-1 flex flex-col justify-center">
                    <MessageCircle size={32} className="text-gray-400 mx-auto mb-3 opacity-50" />
                    <p className="text-gray-300 text-sm mb-2">No reviews yet</p>
                    <p className="text-gray-400 text-xs">Start exploring venues and share your experiences!</p>
                  </div>
                ) : (
                  <div className="space-y-4 flex-1">
                    {/* Venue Info */}
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <p className="font-medium text-white text-lg">{latestReview.venueName}</p>
                        <div className="flex items-center space-x-2 mt-1">
                          <span className="text-xs px-2 py-1 bg-gradient-to-r from-raven/20 to-raven/30 text-raven rounded">
                            {latestReview.venueType.toUpperCase()}
                          </span>
                          <span className="text-xs text-gray-300">
                            {latestReview.createdAt.toLocaleDateString()}
                          </span>
                        </div>
                      </div>
                      <MessageCircle size={16} className="text-gray-400 opacity-50" />
                    </div>
                    
                    {/* Review Text */}
                    {latestReview.reviewText && (
                      <div className="border-t border-gray-600 pt-3">
                        <p className="text-sm text-gray-200 leading-relaxed">
                          {latestReview.reviewText.length > 100 
                            ? `${latestReview.reviewText.substring(0, 100)}...` 
                            : latestReview.reviewText
                          }
                        </p>
                      </div>
                    )}
                    
                    {/* Ratings with Progress Bars */}
                    {latestReview.ratings && (
                      <div className="border-t border-gray-600 pt-3">
                        <div className="space-y-3">
                          {latestReview.venueType === 'club' ? (
                            <>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Music</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.music.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.music}%`}}></div>
                                </div>
                              </div>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Crowd</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.crowd.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.crowd}%`}}></div>
                                </div>
                              </div>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Vibe</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.vibe.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.vibe}%`}}></div>
                                </div>
                              </div>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Safety</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.safety.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.safety}%`}}></div>
                                </div>
                              </div>
                            </>
                          ) : (
                            <>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Quality</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.music.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.music}%`}}></div>
                                </div>
                              </div>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Price</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.crowd.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.crowd}%`}}></div>
                                </div>
                              </div>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Vibe</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.vibe.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.vibe}%`}}></div>
                                </div>
                              </div>
                              <div>
                                <div className="flex justify-between items-center mb-1">
                                  <span className="text-xs text-gray-300">Friendliness</span>
                                  <span className="text-xs text-raven font-medium">{latestReview.ratings.safety.toFixed(0)}%</span>
                                </div>
                                <div className="progress-bar">
                                  <div className="progress-fill" style={{width: `${latestReview.ratings.safety}%`}}></div>
                                </div>
                              </div>
                            </>
                          )}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            </div>
          </div>

          {/* Logout Button at Bottom */}
          <Button
            variant="ghost"
            size="lg"
            onClick={handleLogout}
            className="w-full justify-center flex items-center space-x-2"
          >
            <LogOut size={16} />
            <span>Logout</span>
          </Button>
        </div>
      </motion.div>
    );
  }

  // Show login/signup form
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-berlin-black"
    >
      <div className="px-4 pt-4 max-w-md mx-auto">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="font-space text-2xl text-ink mb-2">
            Welcome to RAVE<span className="text-raven">N</span>
          </h1>
          <p className="text-sm text-ash">
            Join Berlin's nightlife community
          </p>
        </div>

        {/* Tab Navigation */}
        <div className="flex mb-6">
          <button
            onClick={() => setActiveTab('login')}
            className={`flex-1 py-3 text-sm font-medium border-b-2 transition-colors ${
              activeTab === 'login'
                ? 'border-raven text-raven'
                : 'border-ash/20 text-ash hover:text-ink'
            }`}
          >
            Login
          </button>
          <button
            onClick={() => setActiveTab('signup')}
            className={`flex-1 py-3 text-sm font-medium border-b-2 transition-colors ${
              activeTab === 'signup'
                ? 'border-raven text-raven'
                : 'border-ash/20 text-ash hover:text-ink'
            }`}
          >
            Sign Up
          </button>
        </div>

        {/* Form */}
        <Card>
          <form onSubmit={activeTab === 'login' ? handleLogin : handleSignup}>
            <div className="space-y-4">
              {/* Email Input */}
              <div>
                <label className="block text-sm font-medium text-ink mb-2">
                  Email
                </label>
                <div className="relative">
                  <Mail size={16} className="absolute left-3 top-1/2 transform -translate-y-1/2 text-ash" />
                  <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                   pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                    className="w-full bg-berlin-black border border-ash/30 rounded-md pl-10 pr-3 py-2 text-ink placeholder-ash focus:border-raven focus:outline-none"
                    placeholder="your@email.com"
                  />
                </div>
              </div>

              {/* Password Input */}
              <div>
                <label className="block text-sm font-medium text-ink mb-2">
                  Password
                </label>
                <div className="relative">
                  <Lock size={16} className="absolute left-3 top-1/2 transform -translate-y-1/2 text-ash" />
                  <input
                    type={showPassword ? 'text' : 'password'}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    minLength={6}
                    className="w-full bg-berlin-black border border-ash/30 rounded-md pl-10 pr-10 py-2 text-ink placeholder-ash focus:border-raven focus:outline-none"
                    placeholder="••••••••"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 transform -translate-y-1/2 text-ash hover:text-ink"
                  >
                    {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                  </button>
                </div>
              </div>

              {/* Error Message */}
              {error && (
                <div className="bg-blood/10 border border-blood/30 rounded-md p-3">
                  <p className="text-sm text-blood">{error}</p>
                </div>
              )}

              {/* Submit Button */}
              <Button
                type="submit"
                className="w-full justify-center"
                isLoading={loading}
                disabled={!email || !password}
              >
                {activeTab === 'login' ? 'Login' : 'Sign Up'}
              </Button>
            </div>
          </form>

          {/* Additional Info */}
          <div className="mt-4 pt-4 border-t border-ash/10">
            <p className="text-xs text-ash text-center">
              {activeTab === 'login' ? (
                <>
                  Don't have an account?{' '}
                  <button
                    onClick={() => setActiveTab('signup')}
                    className="text-raven hover:underline"
                  >
                    Sign up
                  </button>
                </>
              ) : (
                <>
                  Already have an account?{' '}
                  <button
                    onClick={() => setActiveTab('login')}
                    className="text-raven hover:underline"
                  >
                    Login
                  </button>
                </>
              )}
            </p>
          </div>
        </Card>

        {/* Privacy Notice */}
        <div className="mt-6 text-center">
          <p className="text-xs text-ash">
            By signing up, you agree to our privacy policy.<br />
            Your data is secure and never shared.
          </p>
        </div>
      </div>
    </motion.div>
  );
};

export default Profile;