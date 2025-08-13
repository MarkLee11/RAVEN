import { VibeSummary } from '../contracts/types';
import { vibeSamples } from '../data/vibeSamples';

export const vibeService = {
  async getVibeSummary(venueId: string): Promise<VibeSummary | null> {
    await new Promise(resolve => setTimeout(resolve, 150));
    
    const latestSample = vibeSamples
      .filter(sample => sample.venueId === venueId)
      .sort((a, b) => b.timestamp.getTime() - a.timestamp.getTime())[0];
    
    if (!latestSample) return null;
    
    const summary: VibeSummary = {
      venueId,
      doorStrictness: latestSample.doorStrictness,
      queueEstimate: latestSample.queueEstimate,
      musicIntensity: latestSample.musicIntensity,
      crowdHeat: latestSample.crowdHeat,
      suggestion: latestSample.suggestion,
      lastUpdated: latestSample.timestamp,
      bestWindow: latestSample.crowdHeat > 85 ? '02:00-04:00' : undefined,
    };
    
    return summary;
  },
};