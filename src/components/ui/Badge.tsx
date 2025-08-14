import React from 'react';
import { cn } from '../../lib/utils';

interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement> {
  variant?: 'default' | 'raven' | 'blood';
  size?: 'sm' | 'md';
  className?: string;
  children: React.ReactNode;
}

const Badge: React.FC<BadgeProps> = ({ 
  variant = 'default', 
  size = 'sm',
  className, 
  children,
  onClick,
  ...props
}) => {
  const baseClasses = 'inline-flex items-center rounded-full font-medium';
  
  const variantClasses = {
    default: 'bg-ash/20 text-ash border border-ash/30',
    raven: 'bg-raven/20 text-raven border border-raven/30',
    blood: 'bg-blood/20 text-blood border border-blood/30',
  };
  
  const sizeClasses = {
    sm: 'px-2 py-1 text-xs',
    md: 'px-3 py-1.5 text-sm',
  };

  const clickableClasses = onClick ? 'cursor-pointer hover:opacity-80 transition-opacity' : '';

  return (
    <span
      className={cn(
        baseClasses,
        variantClasses[variant],
        sizeClasses[size],
        clickableClasses,
        className
      )}
      onClick={onClick}
      {...props}
    >
      {children}
    </span>
  );
};

export default Badge;