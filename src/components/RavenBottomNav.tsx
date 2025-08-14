import React from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import '../styles/raven-bottom-nav.css';

const RavenBottomNav: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();

  const tabs = [
    { label: 'CORE', to: '/' },
    { label: 'CLUBS', to: '/clubs' },
    { label: 'BARS', to: '/bars' },
    { label: 'ID', to: '/profile' },
  ];

  // Compute activeIndex from current pathname
  const activeIndex = tabs.findIndex(tab => {
    if (tab.to === '/' && location.pathname === '/') return true;
    if (tab.to !== '/' && location.pathname.startsWith(tab.to)) return true;
    return false;
  });

  const currentIndex = activeIndex >= 0 ? activeIndex : 0;

  const handleTabClick = (index: number) => {
    navigate(tabs[index].to);
  };

  // Fast touch handler to prevent 300ms delay on mobile
  const handleTouchStart = (index: number) => {
    handleTabClick(index);
  };

  const handleKeyDown = (event: React.KeyboardEvent, index: number) => {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      handleTabClick(index);
    }
  };

  return (
    <div className="raven-nav" role="tablist" aria-label="Primary">
      <div 
        className="pane" 
        style={{ ['--i' as any]: currentIndex }}
      >
        {tabs.map((tab, index) => (
          <button
            key={tab.label}
            data-index={index}
            role="tab"
            aria-selected={currentIndex === index}
            onClick={() => handleTabClick(index)}
            onTouchStart={() => handleTouchStart(index)}
            onKeyDown={(e) => handleKeyDown(e, index)}
          >
            {tab.label}
          </button>
        ))}
        <span className="selection" aria-hidden="true" />
      </div>
    </div>
  );
};

export default RavenBottomNav;