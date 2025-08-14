import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { AnimatePresence } from 'framer-motion';
import Landing from './routes/Landing';
import Clubs from './routes/Clubs';
import ClubDetail from './routes/ClubDetail';
import Bars from './routes/Bars';
import BarDetail from './routes/BarDetail';
import Plans from './routes/Plans';
import PlanDetail from './routes/PlanDetail';
import SubmitReview from './routes/SubmitReview';
import Profile from './routes/Profile';
import RavenBottomNav from './components/RavenBottomNav';

function App() {
  return (
    <Router>
      <div className="bg-berlin-black min-h-screen font-inter relative">
        {/* Fixed Top Navigation Bar */}
        <div className="fixed top-0 left-0 right-0 bg-berlin-black border-b border-ash/10 z-50 h-16" style={{ position: 'fixed !important' }}>
          <div className="flex items-center justify-center h-full">
            <h1 className="font-space text-xl text-ink">
              RAVE<span className="text-raven">N</span>
            </h1>
          </div>
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
            <Route path="/plans" element={<Plans />} />
            <Route path="/plans/:id" element={<PlanDetail />} />
            <Route path="/submit" element={<SubmitReview />} />
            <Route path="/profile" element={<Profile />} />
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