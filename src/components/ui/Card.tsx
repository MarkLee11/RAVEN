import React from 'react';
import { motion } from 'framer-motion';
import { cn } from '../../lib/utils';

interface CardProps {
  className?: string;
  hover?: boolean;
  children: React.ReactNode;
}

const Card: React.FC<CardProps> = ({ className, hover = false, children }) => {
  const CardComponent = hover ? motion.div : 'div';
  
  const hoverProps = hover ? {
    whileHover: { scale: 1.02 },
    transition: { type: "spring", stiffness: 300, damping: 20 }
  } : {};

  return (
    <CardComponent
      className={cn(
        'bg-carbon border border-carbon rounded-lg p-4',
        hover && 'cursor-pointer glow-raven-hover',
        className
      )}
      {...hoverProps}
    >
      {children}
    </CardComponent>
  );
};

export default Card;