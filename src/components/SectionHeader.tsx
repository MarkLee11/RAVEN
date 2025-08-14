import React from 'react';
import { cn } from '../lib/utils';

interface SectionHeaderProps {
  title: string;
  subtitle?: string;
  className?: string;
}

const SectionHeader: React.FC<SectionHeaderProps> = ({ title, subtitle, className }) => {
  return (
    <div className={cn('sticky top-0 bg-berlin-black/95 backdrop-blur-sm py-4 border-b border-ash/10 scanline text-center', className)}>
      <h2 className="font-space text-xl text-ink mb-1">{title}</h2>
      {subtitle && <p className="text-sm text-ash">{subtitle}</p>}
    </div>
  );
};

export default SectionHeader;