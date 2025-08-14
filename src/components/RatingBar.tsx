import React from 'react';
import { cn } from '../lib/utils';

interface RatingBarProps {
  label: string;
  value: number; // 0-100
  className?: string;
}

const RatingBar: React.FC<RatingBarProps> = ({ label, value, className }) => {
  const getBarColor = (value: number) => {
    if (value >= 80) return 'bg-raven';
    if (value >= 60) return 'bg-yellow-500';
    if (value >= 40) return 'bg-orange-500';
    return 'bg-blood';
  };

  return (
    <div className={cn('space-y-1', className)}>
      <div className="flex justify-between items-center">
        <span className="text-sm text-ash font-medium">{label}</span>
        <span className="text-sm text-ink">{value}%</span>
      </div>
      <div className="w-full bg-ash/20 rounded-full h-2">
        <div
          className={cn(
            'h-2 rounded-full transition-all duration-500',
            getBarColor(value)
          )}
          style={{ width: `${value}%` }}
        />
      </div>
    </div>
  );
};

export default RatingBar;