import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link, useNavigate } from 'react-router-dom';
import { AnimatePresence } from 'framer-motion';
import Landing from './routes/Landing';
import Clubs from './routes/Clubs';
import ClubDetail from './routes/ClubDetail';
import Bars from './routes/Bars';
import BarDetail from './routes/BarDetail';
import SubmitReview from './routes/SubmitReview';
import Profile from './routes/Profile';
import FavoriteBars from './routes/FavoriteBars';
import FavoriteClubs from './routes/FavoriteClubs';
import RavenBottomNav from './components/RavenBottomNav';

function App() {
  const HeaderLogo: React.FC = () => {
    const navigate = useNavigate();
    const handlePointerDown: React.PointerEventHandler<HTMLButtonElement> = (e) => {
      e.preventDefault();
      navigate('/');
    };
    return (
      <button
        type="button"
        onPointerDown={handlePointerDown}
        className="flex items-center justify-center h-full w-full cursor-pointer select-none header-logo"
        aria-label="Go to CORE"
      >
        <h1 className="font-space text-xl text-ink transition-transform duration-0 will-change-transform active:-translate-y-1">
          RAVE<span className="text-raven">N</span>
        </h1>
      </button>
    );
  };
  return (
    <Router>
      <div className="bg-berlin-black min-h-screen font-inter relative">
        {/* Fixed Top Navigation Bar */}
        <div className="fixed top-0 left-0 right-0 bg-berlin-black border-b border-ash/10 z-[9999] h-16 pointer-events-auto" style={{ position: 'fixed !important' }}>
          <HeaderLogo />
        </div>
        
        {/* Main Content with top and bottom padding to account for fixed bars */}
        <div className="pt-16 pb-20">
        <AnimatePresence mode="wait">
          <Routes>
            <Route path="/" element={<Landing />} />
            <Route path="/clubs" element={<Clubs />} />
            <Route path="/clubs/:id" element={<ClubDetail />} />
            <Route path="/bars" element={<Bars />} />
            <Route path="/bars/:id" element={<BarDetail />} />
            <Route path="/submit" element={<SubmitReview />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="/favorites/bars" element={<FavoriteBars />} />
            <Route path="/favorites/clubs" element={<FavoriteClubs />} />
            <Route path="*" element={
              <div className="min-h-screen bg-berlin-black flex items-center justify-center pb-20 md:pb-8">
                <div className="text-center scanline">
                  <h2 className="font-space text-3xl text-blood mb-4">404</h2>
                  <p className="text-ash mb-6">Page lost in the night</p>
                  <a href="/" className="text-brat hover:underline">
                    Return to RAVEN
                  </a>
                </div>
              </div>
            } />
          </Routes>
        </AnimatePresence>
        </div>
        
        {/* Fixed Bottom Navigation */}
        <RavenBottomNav />
      </div>
    </Router>
  );
}

export default App;