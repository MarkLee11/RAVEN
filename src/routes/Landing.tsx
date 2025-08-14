import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowRight, Zap } from 'lucide-react';
import Button from '../components/ui/Button';
import Card from '../components/ui/Card';
import WordStreamReviews from '../components/WordStreamReviews';

const Landing: React.FC = () => {
  const headerRef = React.useRef<HTMLDivElement>(null);
  const cardsRef = React.useRef<HTMLDivElement>(null);

  return (
    <div className="fixed inset-0 bg-berlin-black overflow-hidden">
    
      {/* Animated scanline */}
      <div className="scanline absolute inset-0 pointer-events-none" />
      
      <div className="relative z-10 px-4 h-full flex flex-col pt-16 pb-20">
        <div className="max-w-md mx-auto flex-1 flex flex-col -mt-80">
          {/* Upper half - Centered RAVEN and Berlin Nightlife */}
           {/* Upper half - Top bar image fill (RAVEN removed, keep only subtitle) */}
        
          <div className="flex-1 flex items-end justify-center pb-8">
          </div>

          {/* Word Stream Reviews */}
          <WordStreamReviews
            anchorTopRef={null}
            anchorBottomRef={cardsRef}
            density={48}
            laneHeight={96}
            colorsBase="#8ACE00"
            positiveRate={0.6}
          />

          {/* Lower half - Three stacked cards centered with rotations */}
          <div ref={cardsRef} className="flex-1 flex items-start justify-center pt-8">
            <div className="relative flex flex-col items-center space-y-4 w-full max-w-sm">
            {/* Vibe Teaser Card */}
            <motion.div
              initial={{ y: 30, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.4 }}
              className="transition-transform duration-300 w-full perspective-1000 hover:scale-105"
              style={{
                transform: 'rotateZ(6deg) rotateX(5deg) rotateY(-2deg)',
                boxShadow: '8px 12px 24px rgba(0, 0, 0, 0.4), 4px 6px 12px rgba(138, 206, 0, 0.1)'
              }}
            >
              <Card hover className="text-left relative overflow-hidden bg-black">
                {/* Dynamic green smoke background */}
                <div className="absolute inset-0 pointer-events-none">
                  <div className="absolute w-32 h-32 bg-raven/5 rounded-full blur-xl animate-pulse" 
                       style={{ 
                         top: '20%', 
                         left: '10%',
                         animation: 'float1 8s ease-in-out infinite'
                       }} />
                  <div className="absolute w-24 h-24 bg-raven/8 rounded-full blur-lg" 
                       style={{ 
                         top: '60%', 
                         right: '15%',
                         animation: 'float2 6s ease-in-out infinite 2s'
                       }} />
                  <div className="absolute w-20 h-20 bg-raven/4 rounded-full blur-2xl" 
                       style={{ 
                         bottom: '30%', 
                         left: '70%',
                         animation: 'float3 10s ease-in-out infinite 4s'
                       }} />
                </div>
                
                {/* Content with relative positioning to stay above smoke */}
                <div className="relative z-10">
                {/* Dynamic green smoke background */}
                <div className="absolute inset-0 pointer-events-none">
                  <div className="absolute w-32 h-32 bg-raven/5 rounded-full blur-xl animate-pulse" 
                       style={{ 
                         top: '20%', 
                         left: '10%',
                         animation: 'float1 8s ease-in-out infinite'
                       }} />
                  <div className="absolute w-24 h-24 bg-raven/8 rounded-full blur-lg" 
                       style={{ 
                         top: '60%', 
                         right: '15%',
                         animation: 'float2 6s ease-in-out infinite 2s'
                       }} />
                  <div className="absolute w-20 h-20 bg-raven/4 rounded-full blur-2xl" 
                       style={{ 
                         bottom: '30%', 
                         left: '70%',
                         animation: 'float3 10s ease-in-out infinite 4s'
                       }} />
                </div>
                
                {/* Content with relative positioning to stay above smoke */}
                <div className="relative z-10">
                <div className="flex items-center space-x-2 mb-2">
                  <Zap size={16} className="text-raven animate-pulse" />
                  <span className="text-xs text-raven font-medium">NO CARE, WE DARE, LAID BARE</span>
                </div>
                <h3 className="font-space text-lg text-ink mb-1">RAVEN</h3>
                <p className="text-sm text-ash mb-3">
                  We exist for only one thing: reviews of Berlin's clubs and bars for others. NO TICKETS, NO PROMOS—SAY WHATEVER YOU WANT.
                </p>
                <div className="flex justify-between text-xs text-ash">
                  <span>Clubs tracked: <span className="text-raven">128</span></span>
                  <span>Bars tracked: <span className="text-raven">342</span></span>
                </div>
                </div>
                </div>
              </Card>
            </motion.div>

            {/* Explore Venues Button */}
    {/* Explore Venues Button */}
<motion.div
  initial={{ y: 30, opacity: 0 }}
  animate={{ y: 0, opacity: 1 }}
  transition={{ delay: 0.6 }}
  className="transition-transform duration-300 w-full hover:scale-105"
  style={{
    transform: 'rotateZ(-20deg) rotateX(-8deg) rotateY(12deg)',
    boxShadow: '-6px 10px 20px rgba(0, 0, 0, 0.5), -3px 5px 10px rgba(138, 206, 0, 0.15)'
  }}
>
  <Link to="/clubs">
    <button 
      className="glitch-btn w-full justify-center items-center font-sora font-semibold pt-4"
      data-label="CLUBS"
    >
      CLUBS
    </button>
  </Link>
</motion.div>
            
            {/* Find Tonight's Crew Button */}
           <motion.div
  initial={{ y: 30, opacity: 0 }}
  animate={{ y: 0, opacity: 1 }}
  transition={{ delay: 0.8 }}
  className="transition-transform duration-300 w-full hover:scale-105"
  style={{
    transform: 'rotateZ(15deg) rotateX(8deg) rotateY(-6deg)',
    boxShadow: '10px 8px 28px rgba(0, 0, 0, 0.6), 5px 4px 14px rgba(138, 206, 0, 0.2)'
  }}
>
  <Link to="/bars">
    <Button variant="ghost" size="lg" className="w-full justify-center items-center font-sora font-semibold pt-4">
      BARS
    </Button>
  </Link>
</motion.div>
          </div>
          </div>

        </div>
      </div>
    </div>
  );
};

export default Landing;