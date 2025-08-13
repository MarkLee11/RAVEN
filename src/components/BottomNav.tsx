import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { motion } from 'framer-motion';
import { CrowRightIcon, PillEIcon, DrinkGlassIcon, CrowLeftIcon } from '../icons/svg';

const BottomNav: React.FC = () => {
  const location = useLocation();
  
  const navItems = [
    { path: '/', icon: CrowRightIcon, label: '' },
    { path: '/venues', icon: PillEIcon, label: '' },
    { path: '/plans', icon: DrinkGlassIcon, label: '' },
    { path: '/profile', icon: CrowLeftIcon, label: '' },
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-berlin-black border-t border-ash/20 px-4 py-2 overflow-hidden z-50" style={{ position: 'fixed !important' }}>
      {/* Flowing green accent */}
      <div className="absolute inset-0 bg-gradient-to-r from-transparent via-raven/10 to-transparent animate-pulse opacity-30" />
      <div className="flex justify-around items-center max-w-sm mx-auto">
        {navItems.map(({ path, icon: Icon, label }) => {
          const isActive = location.pathname === path;
          
          return (
            <Link key={path} to={path} className="relative">
              <motion.div
                whileTap={{ scale: 0.85 }}
                whileHover={{ scale: 1.05 }}
                className="flex flex-col items-center space-y-1 p-2 min-w-0 transition-all duration-200"
              >
                <motion.div
                  animate={{ 
                    rotate: isActive ? [0, -5, 5, 0] : 0,
                  }}
                  transition={{ 
                    rotate: { duration: 0.5, ease: "easeInOut" },
                    scale: { duration: 0.2 }
                  }}
                >
                  <Icon
                    size={20} 
                    active={isActive}
                  />
                </motion.div>
                {label && (
                  <span className={`text-xs text-center ${isActive ? 'text-raven' : 'text-ash'}`}>
                    {label}
                  </span>
                )}
              </motion.div>
            </Link>
          );
        })}
      </div>
    </nav>
  );
};

export default BottomNav;