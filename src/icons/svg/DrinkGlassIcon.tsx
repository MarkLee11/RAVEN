import React from 'react';
import IconBase from './IconBase';

interface Props {
  size?: number;
  active?: boolean;
  ariaLabel?: string;
}

const DrinkGlassIcon: React.FC<Props> = ({ size, active, ariaLabel = 'Drink Glass' }) => (
  <IconBase size={size} active={active} ariaLabel={ariaLabel}>
    {/* 德国啤酒杯主体 */}
    <rect
      x="8"
      y="7"
      width="8"
      height="11"
      rx="0.5"
      fill={active ? '#CD853F' : '#999'}
      stroke="none"
    />
    {/* 啤酒杯把手 */}
    <path
      d="M16 10c1.5 0 2.5 1 2.5 2.5s-1 2.5-2.5 2.5"
      fill="none"
      stroke={active ? '#CD853F' : '#999'}
      strokeWidth="1.5"
    />
    {/* 啤酒杯底座 */}
    <rect
      x="7"
      y="18"
      width="10"
      height="2"
      rx="1"
      fill={active ? '#CD853F' : '#999'}
    />
    {/* 啤酒液体 */}
    <rect
      x="8.5"
      y="9"
      width="7"
      height="9"
      fill={active ? '#8B4513' : '#666'}
      opacity="0.7"
    />
    {/* 啤酒泡沫 */}
    <ellipse
      cx="12"
      cy="8.5"
      rx="3.5"
      ry="1.5"
      fill="#F5F5DC"
      opacity="0.9"
    />
  </IconBase>
);

export default DrinkGlassIcon;