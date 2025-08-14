import React from 'react';
import IconBase from './IconBase';

interface Props {
  size?: number;
  active?: boolean;
  ariaLabel?: string;
}

const CrowRightIcon: React.FC<Props> = ({ size, active, ariaLabel = 'Crow Right' }) => (
  <IconBase size={size} active={active} ariaLabel={ariaLabel}>
    {/* 乌鸦头部轮廓 - 向右 */}
    <path
      d="M6 8c0-3 2-5 5-5s5 2 5 5v8c0 2-2 4-5 4s-5-2-5-4V8z"
      fill="#666"
      stroke="none"
    />
    {/* 乌鸦嘴巴 - 向右 */}
    <path
      d="M16 11l4 1-4 1z"
      fill="#444"
    />
    {/* 大眼睛 */}
    <circle
      cx="13"
      cy="10"
      r="2"
      fill={active ? '#4CAF50' : '#333'}
      style={{
        filter: active ? 'drop-shadow(0 0 8px #4CAF50)' : 'none'
      }}
    />
    {/* 眼睛高光 */}
    <circle
      cx="13.5"
      cy="9.5"
      r="0.5"
      fill="#fff"
    />
  </IconBase>
);

export default CrowRightIcon;