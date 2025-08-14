import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { User, Mail, Lock, LogOut, Eye, EyeOff } from 'lucide-react';
import { supabase } from '../lib/supabase';
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
  const [activeTab, setActiveTab] = useState<'login' | 'signup'>('login');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [user, setUser] = useState<any>(null);
  const [checkingAuth, setCheckingAuth] = useState(true);

  useEffect(() => {
    checkUser();
  }, []);

  const checkUser = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        setUser(user);
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
            <div className="text-center mb-4">
              <h3 className="font-space text-lg text-ink mb-1">Deathmarch</h3>
              <p className="text-xs text-ash">Every venue visited brings you closer to transcendence.</p>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="text-center">
                <div className="text-2xl font-bold text-raven mb-1">0/128</div>
                <div className="text-xs text-ash">Clubs</div>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-raven mb-1">0/342</div>
                <div className="text-xs text-ash">Bars</div>
              </div>
            </div>
          </Card>

          {/* Graveyard */}
          <Card>
            <h3 className="font-space text-lg text-ink mb-3">Graveyard</h3>
            <div className="space-y-2">
              <div className="flex items-center space-x-2">
                <Badge size="sm">Closed Venues</Badge>
                <span className="text-xs text-ash">Venues that are no longer open</span>
              </div>
              <div className="flex items-center space-x-2">
                <Badge size="sm">Lost Reviews</Badge>
                <span className="text-xs text-ash">Reviews from venues that closed</span>
              </div>
              <div className="flex items-center space-x-2">
                <Badge size="sm">Memory Lane</Badge>
                <span className="text-xs text-ash">Archived nightlife memories</span>
              </div>
            </div>
          </Card>

          {/* Echo */}
          <Card>
            <h3 className="font-space text-lg text-ink mb-3">Echo</h3>
            <div className="space-y-2">
              <div className="flex items-center space-x-2">
                <Badge size="sm">Sound Waves</Badge>
                <span className="text-xs text-ash">Track your music journey</span>
              </div>
              <div className="flex items-center space-x-2">
                <Badge size="sm">Reverb</Badge>
                <span className="text-xs text-ash">Echoes of past nights</span>
              </div>
              <div className="flex items-center space-x-2">
                <Badge size="sm">Frequency</Badge>
                <span className="text-xs text-ash">Your nightlife patterns</span>
              </div>
            </div>
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