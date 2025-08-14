import React from 'react';
import { User } from 'lucide-react';
import { cn } from '../lib/utils';
import { getInitials } from '../lib/utils';

// Avatar component for user profile display and identification

interface AvatarProps {
  name?: string;
  avatarUrl?: string;
  isAnonymous?: boolean;
  size?: 'sm' | 'md' | 'lg';
  className?: string;
}

const Avatar: React.FC<AvatarProps> = ({
  name = 'Anonymous',
  avatarUrl,
  isAnonymous = false,
  size = 'md',
  className,
}) => {
  const sizeClasses = {
    sm: 'w-6 h-6 text-xs',
    md: 'w-10 h-10 text-sm',
    lg: 'w-16 h-16 text-lg',
  };

  const iconSizes = {
    sm: 12,
    md: 16,
    lg: 24,
  };

  if (avatarUrl) {
    return (
      <img
        src={avatarUrl}
        alt={name}
        className={cn(
          'rounded-full object-cover border border-ash/30',
          sizeClasses[size],
          className
        )}
      />
    );
  }

  return (
    <div
      className={cn(
        'rounded-full bg-carbon border border-ash/30 flex items-center justify-center text-ink font-medium',
        sizeClasses[size],
        className
      )}
    >
      {isAnonymous ? (
        <User size={iconSizes[size]} className="text-ash" />
      ) : (
        getInitials(name)
      )}
    </div>
  );
};

export default Avatar;