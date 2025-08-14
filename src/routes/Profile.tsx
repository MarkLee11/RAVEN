import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { User, Mail, Lock, LogOut, Eye, EyeOff, MessageCircle, ChevronLeft, ChevronRight } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { clubsService } from '../services/clubsService';
import { barsService } from '../services/barsService';
import { reviewsService } from '../services/reviewsService';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';

interface UserProfile {
  id: string;
  email: string;
  created_at: string;
}

interface AuthError {
  message: string;
}

const Profile: React.FC = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState<'login' | 'signup'>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [user, setUser] = useState<any>(null);
  const [checkingAuth, setCheckingAuth] = useState(true);
  const [clubsTotal, setClubsTotal] = useState<number>(0);
  const [barsTotal, setBarsTotal] = useState<number>(0);
  const [loadingCounts, setLoadingCounts] = useState(true);
  const [userClubsVisited, setUserClubsVisited] = useState<number>(0);
  const [userBarsVisited, setUserBarsVisited] = useState<number>(0);
  const [loadingUserCounts, setLoadingUserCounts] = useState(true);
  const [reviewHistory, setReviewHistory] = useState<{
    reviews: Array<{
      id: string;
      venueId: string;
      venueName: string;
      venueType: 'club' | 'bar';
      ratings: {
        music: number;
        vibe: number;
        crowd: number;
        safety: number;
      };
      comment: string;
      queueTime?: number;
      createdAt: Date;
    }>;
    totalCount: number;
    totalPages: number;
  }>({ reviews: [], totalCount: 0, totalPages: 0 });
  const [currentReviewPage, setCurrentReviewPage] = useState(1);
  const [loadingReviews, setLoadingReviews] = useState(false);

  useEffect(() => {
    checkUser();
    loadCounts();
  }, []);

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

  const loadReviewHistory = async (userId: string, page: number = 1) => {
    setLoadingReviews(true);
    try {
      const history = await reviewsService.getUserReviewHistory(userId, page, 3); // 3 reviews per page
      setReviewHistory(history);
      setCurrentReviewPage(page);
    } catch (error) {
      console.error('Failed to load review history:', error);
    } finally {
      setLoadingReviews(false);
    }
  };

  const checkUser = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        setUser(user);
        // Load user visit counts and review history when user is authenticated
        await Promise.all([
          loadUserCounts(user.id),
          loadReviewHistory(user.id, 1)
        ]);
      } else {
        // Reset user counts when no user
        setUserClubsVisited(0);
        setUserBarsVisited(0);
        setLoadingUserCounts(false);
        setReviewHistory({ reviews: [], totalCount: 0, totalPages: 0 });
      }
    } catch (error) {
      console.error('Error checking user:', error);
    } finally {
      setCheckingAuth(false);
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

      if (data.user) {
        setUser(data.user);
        // Load user visit counts and review history
        await Promise.all([
          loadUserCounts(data.user.id),
          loadReviewHistory(data.user.id, 1)
        ]);
        // Clear form
        setEmail('');
        setPassword('');
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

      if (data.user) {
        setUser(data.user);
        // Load user visit counts and review history
        await Promise.all([
          loadUserCounts(data.user.id),
          loadReviewHistory(data.user.id, 1)
        ]);
        // Clear form
        setEmail('');
        setPassword('');
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
      
      setUser(null);
      setEmail('');
      setPassword('');
      // Reset user counts
      setUserClubsVisited(0);
      setUserBarsVisited(0);
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
          <Card>
            <h3 className="font-space text-lg text-ink mb-4">Echo</h3>
            
            {/* Debug info - remove after testing */}
            <div className="mb-2 p-2 bg-ash/10 rounded text-xs text-ash">
              <div>Debug: Reviews: {reviewHistory.reviews.length}, Total: {reviewHistory.totalCount}, Pages: {reviewHistory.totalPages}, Current: {currentReviewPage}</div>
            </div>
            
            {loadingReviews ? (
              <div className="text-center py-8">
                <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
                <p className="text-ash mt-2 text-sm">Loading review history...</p>
              </div>
            ) : reviewHistory.reviews.length === 0 ? (
              <div className="text-center py-8">
                <MessageCircle size={32} className="text-ash mx-auto mb-3 opacity-50" />
                <p className="text-ash text-sm mb-2">No reviews yet</p>
                <p className="text-ash/60 text-xs">Start exploring venues and share your experiences!</p>
              </div>
            ) : (
              <div className="space-y-4">
                {reviewHistory.reviews.map((review, index) => (
                  <motion.div
                    key={review.id}
                    initial={{ y: 10, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{ delay: index * 0.1 }}
                    className="border border-ash/20 rounded-lg p-3"
                  >
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex-1">
                        <button
                          onClick={() => navigate(`/${review.venueType}s/${review.venueId}`)}
                          className="font-medium text-ink hover:text-raven transition-colors text-left"
                        >
                          {review.venueName}
                        </button>
                        <div className="flex items-center space-x-2 mt-1">
                          <Badge size="sm" variant={review.venueType === 'club' ? 'raven' : 'default'}>
                            {review.venueType.toUpperCase()}
                          </Badge>
                          <span className="text-xs text-ash">
                            {review.createdAt.toLocaleDateString()}
                          </span>
                        </div>
                      </div>
                    </div>

                    {review.comment && (
                      <p className="text-sm text-ash mb-3 leading-relaxed line-clamp-2">
                        {review.comment}
                      </p>
                    )}

                    <div className="grid grid-cols-2 gap-2 text-xs">
                      <div className="flex justify-between">
                        <span className="text-ash">
                          {review.venueType === 'bar' ? 'Quality:' : 'Music:'}
                        </span>
                        <span className="text-ink font-medium">{review.ratings.music}%</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-ash">Vibe:</span>
                        <span className="text-ink font-medium">{review.ratings.vibe}%</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-ash">
                          {review.venueType === 'bar' ? 'Price:' : 'Crowd:'}
                        </span>
                        <span className="text-ink font-medium">{review.ratings.crowd}%</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-ash">
                          {review.venueType === 'bar' ? 'Friendliness:' : 'Safety:'}
                        </span>
                        <span className="text-ink font-medium">{review.ratings.safety}%</span>
                      </div>
                    </div>

                    {review.queueTime && (
                      <div className="mt-2 text-xs text-ash">
                        Queue time: {review.queueTime} minutes
                      </div>
                    )}
                  </motion.div>
                ))}

                {/* Pagination - temporarily always show for testing */}
                {reviewHistory.reviews.length > 0 && (
                  <div className="flex items-center justify-between pt-3 border-t border-ash/10">
                    <button
                      onClick={() => user && loadReviewHistory(user.id, currentReviewPage - 1)}
                      disabled={currentReviewPage === 1 || loadingReviews}
                      className="flex items-center space-x-1 px-3 py-1 text-xs bg-raven/10 text-raven border border-raven/30 rounded-md hover:bg-raven hover:text-berlin-black transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                    >
                      <ChevronLeft size={12} />
                      <span>Previous</span>
                    </button>
                    
                    <span className="text-xs text-ash">
                      <span className="text-raven">{currentReviewPage}</span>
                      <span> / </span>
                      <span className="text-raven">{reviewHistory.totalPages}</span>
                    </span>
                    
                    <button
                      onClick={() => user && loadReviewHistory(user.id, currentReviewPage + 1)}
                      disabled={currentReviewPage >= reviewHistory.totalPages || loadingReviews}
                      className="flex items-center space-x-1 px-3 py-1 text-xs bg-raven/10 text-raven border border-raven/30 rounded-md hover:bg-raven hover:text-berlin-black transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                    >
                      <span>Next</span>
                      <ChevronRight size={12} />
                    </button>
                  </div>
                )}
              </div>
            )}
          </Card>

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