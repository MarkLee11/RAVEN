import React from 'react';
import IconBase from './IconBase';

interface Props {
  size?: number;
  active?: boolean;
  ariaLabel?: string;
}

const PillEIcon: React.FC<Props> = ({ size, active, ariaLabel = 'Pill E' }) => (
  <IconBase size={size} active={active} ariaLabel={ariaLabel}>
    {/* 圆形药片 */}
    <circle
      cx="12"
      cy="12"
      r="9"
      fill={active ? '#4169E1' : '#999'}
      stroke="none"
    />
    {/* 字母 E */}
    <text
      x="12"
      y="16"
      textAnchor="middle"
      fontSize="10"
      fill="#fff"
      fontFamily="Arial, sans-serif"
      fontWeight="bold"
    >
      E
    </text>
  </IconBase>
);

export default PillEIcon;