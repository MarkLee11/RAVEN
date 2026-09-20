import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Mail, Lock, LogOut, Eye, EyeOff, MessageCircle, AlertCircle } from 'lucide-react';
import { supabase } from '../lib/supabase';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import { useAuth } from '../contexts/useAuth';
import { useProfileKernelData } from '../hooks/useProfileKernelData';

interface AuthRedirectState {
  returnTo?: string;
  returnState?: unknown;
  submitState?: {
    venueId: string;
    venueName?: string;
    venueType?: 'club' | 'bar';
  };
}

const isAuthRedirectState = (state: unknown): state is AuthRedirectState => {
  if (!state || typeof state !== 'object') return false;
  const candidate = state as Record<string, unknown>;
  if (candidate.returnTo !== undefined && typeof candidate.returnTo !== 'string') return false;
  return true;
};

const RATING_LABELS: Record<'club' | 'bar', readonly string[]> = {
  club: ['Music', 'Crowd', 'Vibe', 'Safety'],
  bar: ['Quality', 'Price', 'Vibe', 'Friendliness'],
};

const truncateReviewText = (text: string, maxLength: number = 140): string => {
  if (text.length <= maxLength) return text;
  return `${text.slice(0, maxLength)}...`;
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
  const profileKernel = useProfileKernelData({
    userId: user?.id ?? null,
  });

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
            {profileKernel.deathmarch.state === 'loading' ? (
              <div className="text-center py-6">
                <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
                <p className="text-xs text-ash mt-2">Loading progress...</p>
              </div>
            ) : profileKernel.deathmarch.state === 'error' ? (
              <div className="text-center py-4">
                <AlertCircle size={24} className="text-blood mx-auto mb-2" />
                <p className="text-xs text-ash mb-3">{profileKernel.deathmarch.error ?? 'Failed to load data.'}</p>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={profileKernel.deathmarch.retry}
                  className="mx-auto text-xs"
                >
                  Retry
                </Button>
              </div>
            ) : (
              <div className="grid grid-cols-2 gap-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-raven mb-1">
                    {`${profileKernel.deathmarch.data.userClubsVisited}/${profileKernel.deathmarch.data.clubsTotal}`}
                  </div>
                  <div className="text-xs text-ash">Clubs</div>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-raven mb-1">
                    {`${profileKernel.deathmarch.data.userBarsVisited}/${profileKernel.deathmarch.data.barsTotal}`}
                  </div>
                  <div className="text-xs text-ash">Bars</div>
                </div>
              </div>
            )}
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

                {profileKernel.echo.state === 'loading' ? (
                  <div className="text-center py-8 flex-1 flex flex-col justify-center">
                    <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
                    <p className="text-gray-300 mt-2 text-sm">Loading review history...</p>
                  </div>
                ) : profileKernel.echo.state === 'error' ? (
                  <div className="text-center py-8 flex-1 flex flex-col justify-center">
                    <AlertCircle size={32} className="text-blood mx-auto mb-3 opacity-80" />
                    <p className="text-gray-200 text-sm mb-2">{profileKernel.echo.error ?? 'Failed to load Echo history.'}</p>
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={profileKernel.echo.retry}
                      className="mx-auto"
                    >
                      Retry
                    </Button>
                  </div>
                ) : profileKernel.echo.state === 'empty' ? (
                  <div className="text-center py-8 flex-1 flex flex-col justify-center">
                    <MessageCircle size={32} className="text-gray-400 mx-auto mb-3 opacity-50" />
                    <p className="text-gray-300 text-sm mb-2">No reviews yet</p>
                    <p className="text-gray-400 text-xs">Start exploring venues and share your experiences!</p>
                  </div>
                ) : (
                  <div className="space-y-4 flex-1">
                    {profileKernel.echo.reviews.map((review) => {
                      const values = [
                        review.ratings.music,
                        review.ratings.crowd,
                        review.ratings.vibe,
                        review.ratings.safety,
                      ];
                      return (
                        <div key={review.id} className="border border-gray-700/70 rounded-lg p-3 bg-black/20 space-y-3">
                          <div className="flex items-center justify-between">
                            <div className="flex-1">
                              <p className="font-medium text-white text-base">{review.venueName}</p>
                              <div className="flex items-center space-x-2 mt-1">
                                <span className="text-xs px-2 py-1 bg-gradient-to-r from-raven/20 to-raven/30 text-raven rounded">
                                  {review.venueType.toUpperCase()}
                                </span>
                                <span className="text-xs text-gray-300">
                                  {review.createdAt.toLocaleDateString()}
                                </span>
                              </div>
                            </div>
                            <MessageCircle size={16} className="text-gray-400 opacity-50" />
                          </div>

                          {review.comment && (
                            <div className="border-t border-gray-600 pt-3">
                              <p className="text-sm text-gray-200 leading-relaxed">
                                {truncateReviewText(review.comment)}
                              </p>
                            </div>
                          )}

                          <div className="border-t border-gray-600 pt-3">
                            <div className="space-y-3">
                              {RATING_LABELS[review.venueType].map((label, index) => (
                                <div key={`${review.id}-${label}`}>
                                  <div className="flex justify-between items-center mb-1">
                                    <span className="text-xs text-gray-300">{label}</span>
                                    <span className="text-xs text-raven font-medium">{values[index].toFixed(0)}%</span>
                                  </div>
                                  <div className="progress-bar">
                                    <div className="progress-fill" style={{ width: `${values[index]}%` }}></div>
                                  </div>
                                </div>
                              ))}
                            </div>
                          </div>
                        </div>
                      );
                    })}

                    <div className="border-t border-gray-600 pt-3 flex items-center justify-between">
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={profileKernel.echo.goToPreviousPage}
                        disabled={!profileKernel.echo.hasPreviousPage}
                        className="text-xs"
                      >
                        Previous
                      </Button>
                      <p className="text-xs text-gray-300">
                        Page {profileKernel.echo.page} / {Math.max(profileKernel.echo.totalPages, 1)} · {profileKernel.echo.totalCount} total
                      </p>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={profileKernel.echo.goToNextPage}
                        disabled={!profileKernel.echo.hasNextPage}
                        className="text-xs"
                      >
                        Next
                      </Button>
                    </div>
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