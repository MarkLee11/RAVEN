import React from 'react';
import { cn } from '../../lib/utils';

interface CardProps {
  className?: string;
  hover?: boolean;
  children: React.ReactNode;
}

const Card: React.FC<CardProps> = ({ className, hover = false, children }) => {
  return (
    <div
      className={cn(
        'bg-carbon border border-carbon rounded-lg p-4',
        hover && 'cursor-pointer glow-raven-hover',
        className
      )}
    >
      {children}
    </div>
  );
};

export default Card;