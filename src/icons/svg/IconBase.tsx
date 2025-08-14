import React from 'react';

interface Props {
  size?: number;
  active?: boolean;
  ariaLabel?: string;
  children: React.ReactNode;
}

const IconBase: React.FC<Props> = ({ 
  size = 24, 
  active = false, 
  ariaLabel, 
  children 
}) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
    aria-label={ariaLabel}
    className={`transition-all duration-200 ${active ? 'scale-110' : ''}`}
  >
    {children}
  </svg>
);

export default IconBase;