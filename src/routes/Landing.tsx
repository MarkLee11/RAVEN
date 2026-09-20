import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Zap } from 'lucide-react';
import Card from '../components/ui/Card';
import WordStreamReviews from '../components/WordStreamReviews';
import { supabase } from '../lib/supabase';

const Landing: React.FC = () => {
  const cardsRef = React.useRef<HTMLDivElement>(null);
  const [clubsCount, setClubsCount] = useState<number | null>(null);
  const [barsCount, setBarsCount] = useState<number | null>(null);

  useEffect(() => {
    const fetchVenueCounts = async () => {
      try {
        const [clubsResult, barsResult] = await Promise.all([
          supabase.from('clubs').select('id', { count: 'exact', head: true }),
          supabase.from('bars').select('id', { count: 'exact', head: true }),
        ]);
        if (clubsResult.error) {
          console.error('Error fetching clubs count:', clubsResult.error);
        } else {
          setClubsCount(clubsResult.count ?? 0);
        }
        if (barsResult.error) {
          console.error('Error fetching bars count:', barsResult.error);
        } else {
          setBarsCount(barsResult.count ?? 0);
        }
      } catch (err) {
        console.error('Failed to fetch venue counts:', err);
      }
    };
    fetchVenueCounts();
  }, []);

  return (
    <div className="fixed inset-0 bg-berlin-black overflow-hidden">
      <div className="scanline absolute inset-0 pointer-events-none" />

      <div className="relative z-10 px-4 h-full flex flex-col pt-16 pb-[calc(5rem+env(safe-area-inset-bottom))]">
        <div className="landing-wordmark relative z-40 text-center pt-3 pb-2">
          <h1 className="font-space text-6xl font-bold tracking-tight text-ink leading-none">
            RAVE<span className="text-raven">N</span>
          </h1>
          <p className="mt-3 text-sm text-ash tracking-wide">
            Unfiltered Berlin. Lived, not listed.
          </p>
        </div>

        <WordStreamReviews
          anchorBottomRef={cardsRef}
          density={48}
          laneHeight={96}
          colorsBase="#8ACE00"
          positiveRate={0.6}
        />

        <div ref={cardsRef} className="relative z-20 mt-auto flex justify-center pb-2">
          <div className="relative flex flex-col items-center w-full max-w-sm">
            <motion.div
              initial={{ y: 24, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.25 }}
              className="w-[78vw] md:w-[88%] mb-5"
              style={{
                transform: 'rotateZ(3deg)',
                boxShadow: '6px 8px 18px rgba(0, 0, 0, 0.35), 2px 4px 10px rgba(138, 206, 0, 0.08)',
              }}
            >
              <Card hover className="text-left relative overflow-hidden bg-black py-1">
                <div className="absolute inset-0 pointer-events-none">
                  <div
                    className="absolute w-28 h-28 bg-raven/5 rounded-full blur-xl"
                    style={{ top: '18%', left: '8%', animation: 'float1 8s ease-in-out infinite' }}
                  />
                  <div
                    className="absolute w-20 h-20 bg-raven/8 rounded-full blur-lg"
                    style={{ top: '58%', right: '12%', animation: 'float2 6s ease-in-out infinite 2s' }}
                  />
                </div>

                <div className="relative z-10">
                  <div className="flex items-center mb-4">
                    <Zap size={14} className="text-raven animate-pulse" />
                    <div className="flex-1 flex items-center justify-between px-2 text-[11px] text-raven font-medium tracking-wide">
                      <span>NO CARE</span>
                      <span>WE DARE</span>
                      <span>LAID BARE</span>
                    </div>
                    <Zap size={14} className="text-raven animate-pulse" />
                  </div>
                  <div className="flex justify-between text-xs text-ash">
                    <span>
                      <span className="text-raven">Clubs</span> tracked:{' '}
                      <span className="text-raven">{clubsCount ?? '—'}</span>
                    </span>
                    <span>
                      <span className="text-raven">Bars</span> tracked:{' '}
                      <span className="text-raven">{barsCount ?? '—'}</span>
                    </span>
                  </div>
                </div>
              </Card>
            </motion.div>

            <motion.div
              initial={{ y: 24, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.4 }}
              className="w-full mb-3"
            >
              <Link
                to="/clubs"
                className="glitch-btn landing-descend tap-fast"
                data-label="DESCEND"
                aria-label="Descend into clubs"
              >
                <span className="flex flex-col items-center leading-none">
                  <span>DESCEND</span>
                  <span className="landing-door-sub">clubs</span>
                </span>
              </Link>
            </motion.div>

            <motion.div
              initial={{ y: 24, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.55 }}
              className="w-[78%] self-end"
              style={{ transform: 'rotateZ(6deg)' }}
            >
              <Link
                to="/bars"
                className="bars-btn landing-linger tap-fast"
                aria-label="Linger in bars"
              >
                <span className="flex flex-col items-center leading-none">
                  <span>LINGER</span>
                  <span className="landing-door-sub">bars</span>
                </span>
              </Link>
            </motion.div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Landing;
