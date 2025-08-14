import { Venue } from '../contracts/types';
import { bars } from '../data/bars';

export const barsService = {
  async listBars(district?: string, tags?: string[]): Promise<Venue[]> {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));
    
    let filtered = [...bars];
    
    if (district) {
      filtered = filtered.filter(venue => venue.district === district);
    }
    
    if (tags && tags.length > 0) {
      filtered = filtered.filter(venue => 
        tags.some(tag => venue.tags.includes(tag as any))
      );
    }
    
    return filtered;
  },

  async getBar(id: string): Promise<Venue | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    const bar = bars.find(v => v.id === id);
    return bar || null;
  },
};