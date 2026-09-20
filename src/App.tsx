import React, { Suspense, lazy } from 'react';
import { BrowserRouter as Router, Routes, Route, useNavigate } from 'react-router-dom';
import { AnimatePresence } from 'framer-motion';
import RavenBottomNav from './components/RavenBottomNav';
import { AuthProvider } from './contexts/AuthContext';
import RequireAuth from './components/RequireAuth';

const Landing = lazy(() => import('./routes/Landing'));
const Clubs = lazy(() => import('./routes/Clubs'));
const ClubDetail = lazy(() => import('./routes/ClubDetail'));
const Bars = lazy(() => import('./routes/Bars'));
const BarDetail = lazy(() => import('./routes/BarDetail'));
const SubmitReview = lazy(() => import('./routes/SubmitReview'));
const Profile = lazy(() => import('./routes/Profile'));
const FavoriteBars = lazy(() => import('./routes/FavoriteBars'));
const FavoriteClubs = lazy(() => import('./routes/FavoriteClubs'));

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
    <AuthProvider>
    <Router>
      <div className="bg-berlin-black min-h-screen font-inter relative">
        {/* Fixed Top Navigation Bar */}
        <div className="fixed top-0 left-0 right-0 bg-berlin-black border-b border-ash/10 z-[9999] h-16 pointer-events-auto">
          <HeaderLogo />
        </div>
        
        {/* Main Content with top and bottom padding to account for fixed bars */}
        <div className="pt-16 pb-20">
        <Suspense
          fallback={
            <div className="min-h-[60vh] bg-berlin-black flex items-center justify-center">
              <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
            </div>
          }
        >
          <AnimatePresence mode="wait">
            <Routes>
              <Route path="/" element={<Landing />} />
              <Route path="/clubs" element={<Clubs />} />
              <Route path="/clubs/:id" element={<ClubDetail />} />
              <Route path="/bars" element={<Bars />} />
              <Route path="/bars/:id" element={<BarDetail />} />
              <Route path="/submit" element={<RequireAuth><SubmitReview /></RequireAuth>} />
              <Route path="/profile" element={<Profile />} />
              <Route path="/favorites/bars" element={<RequireAuth><FavoriteBars /></RequireAuth>} />
              <Route path="/favorites/clubs" element={<RequireAuth><FavoriteClubs /></RequireAuth>} />
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
        </Suspense>
        </div>
        
        {/* Fixed Bottom Navigation */}
        <RavenBottomNav />
      </div>
    </Router>
    </AuthProvider>
  );
}

export default App;