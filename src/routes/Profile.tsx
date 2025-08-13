import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { User, Settings, Heart, MapPin, Calendar, Star, Edit3 } from 'lucide-react';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import Avatar from '../components/Avatar';
import SectionHeader from '../components/SectionHeader';

interface UserStats {
  reviewsCount: number;
  plansJoined: number;
  favoriteVenues: string[];
  memberSince: string;
}

interface UserProfile {
  name: string;
  bio: string;
  favoriteDistricts: string[];
  musicTastes: string[];
  languages: string[];
  isLGBTQFriendly: boolean;
}

const Profile: React.FC = () => {
  const [isEditing, setIsEditing] = useState(false);
  const [profile, setProfile] = useState<UserProfile>({
    name: 'Berlin Raver',
    bio: 'Techno enthusiast exploring Berlin\'s underground scene. Always down for a good night out.',
    favoriteDistricts: ['Kreuzberg', 'Friedrichshain'],
    musicTastes: ['techno', 'house', 'disco'],
    languages: ['EN', 'DE'],
    isLGBTQFriendly: true,
  });

  const [stats] = useState<UserStats>({
    reviewsCount: 12,
    plansJoined: 8,
    favoriteVenues: ['Berghain', 'About Blank', 'Ritter Butzke'],
    memberSince: 'December 2024',
  });

  const handleSaveProfile = () => {
    setIsEditing(false);
    // In real app, this would save to backend
    console.log('Profile saved:', profile);
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

      <div className="px-4 pt-4 space-y-6">
        {/* Profile Header */}
        <Card>
          <div className="flex items-start space-x-4">
            <Avatar name={profile.name} size="lg" />
            <div className="flex-1">
              <div className="flex items-center justify-between mb-2">
                <h2 className="font-space text-xl text-ink">{profile.name}</h2>
                <button
                  onClick={() => setIsEditing(!isEditing)}
                  className="text-ash hover:text-raven transition-colors"
                >
                  <Edit3 size={16} />
                </button>
              </div>
              
              {isEditing ? (
                <div className="space-y-3">
                  <input
                    type="text"
                    value={profile.name}
                    onChange={(e) => setProfile(prev => ({ ...prev, name: e.target.value }))}
                    className="w-full bg-berlin-black border border-ash/30 rounded px-2 py-1 text-ink text-sm focus:border-raven focus:outline-none"
                  />
                  <textarea
                    value={profile.bio}
                    onChange={(e) => setProfile(prev => ({ ...prev, bio: e.target.value }))}
                    rows={3}
                    className="w-full bg-berlin-black border border-ash/30 rounded px-2 py-1 text-ink text-sm focus:border-raven focus:outline-none resize-none"
                  />
                  <div className="flex space-x-2">
                    <Button size="sm" onClick={handleSaveProfile}>Save</Button>
                    <Button size="sm" variant="ghost" onClick={() => setIsEditing(false)}>Cancel</Button>
                  </div>
                </div>
              ) : (
                <p className="text-sm text-ash leading-relaxed">{profile.bio}</p>
              )}
            </div>
          </div>
        </Card>

        {/* Stats */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Your Stats</h3>
          <div className="grid grid-cols-2 gap-4">
            <div className="text-center">
              <div className="text-2xl font-bold text-raven mb-1">{stats.reviewsCount}</div>
              <div className="text-xs text-ash">Reviews</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-raven mb-1">{stats.plansJoined}</div>
              <div className="text-xs text-ash">Plans Joined</div>
            </div>
          </div>
          <div className="mt-4 pt-4 border-t border-ash/10">
            <div className="flex items-center space-x-2 text-sm text-ash">
              <Calendar size={14} />
              <span>Member since {stats.memberSince}</span>
            </div>
          </div>
        </Card>

        {/* Preferences */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Preferences</h3>
          
          <div className="space-y-4">
            {/* Favorite Districts */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2 flex items-center">
                <MapPin size={14} className="mr-1" />
                Favorite Districts
              </h4>
              <div className="flex flex-wrap gap-2">
                {profile.favoriteDistricts.map(district => (
                  <Badge key={district} variant="raven" size="sm">
                    {district}
                  </Badge>
                ))}
              </div>
            </div>

            {/* Music Tastes */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2 flex items-center">
                <Star size={14} className="mr-1" />
                Music Tastes
              </h4>
              <div className="flex flex-wrap gap-2">
                {profile.musicTastes.map(taste => (
                  <Badge key={taste} size="sm">
                    {taste}
                  </Badge>
                ))}
              </div>
            </div>

            {/* Languages */}
            <div>
              <h4 className="text-sm font-medium text-ink mb-2">Languages</h4>
              <div className="flex items-center space-x-3">
                {profile.languages.map(lang => (
                  <div key={lang} className="flex items-center space-x-1">
                    <span className="text-lg">{getLanguageFlag(lang)}</span>
                    <span className="text-sm text-ash">{lang}</span>
                  </div>
                ))}
              </div>
            </div>

            {/* LGBTQ+ Friendly */}
            {profile.isLGBTQFriendly && (
              <div className="flex items-center space-x-2">
                <Heart size={16} className="text-raven" />
                <span className="text-sm text-ink">LGBTQ+ Friendly</span>
              </div>
            )}
          </div>
        </Card>

        {/* Favorite Venues */}
        <Card>
          <h3 className="font-space text-lg text-ink mb-4">Favorite Venues</h3>
          <div className="space-y-2">
            {stats.favoriteVenues.map((venue, index) => (
              <div key={venue} className="flex items-center justify-between py-2">
                <span className="text-sm text-ink">{venue}</span>
                <div className="flex items-center space-x-1">
                  <Star size={12} className="text-raven" />
                  <span className="text-xs text-ash">#{index + 1}</span>
                </div>
              </div>
            ))}
          </div>
        </Card>

        {/* Settings */}
        <Card>
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <Settings size={20} className="text-ash" />
              <div>
                <h3 className="font-space text-lg text-ink">Settings</h3>
                <p className="text-sm text-ash">Privacy, notifications, and more</p>
              </div>
            </div>
            <Button variant="ghost" size="sm">
              Configure
            </Button>
          </div>
        </Card>

        {/* Account Actions */}
        <div className="space-y-3">
          <Button variant="ghost" className="w-full justify-center">
            Export My Data
          </Button>
          <Button variant="danger" className="w-full justify-center">
            Delete Account
          </Button>
        </div>
      </div>
    </motion.div>
  );
};

export default Profile;