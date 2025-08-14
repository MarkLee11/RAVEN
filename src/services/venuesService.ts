import { Venue } from '../contracts/types';
import { nightclubs, bars } from '../data/venues';

export const venuesService = {
  async listNightclubs(district?: string, tags?: string[]): Promise<Venue[]> {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));
    
    let filtered = [...nightclubs];
    
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

  async getNightclub(id: string): Promise<Venue | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    const venue = nightclubs.find(v => v.id === id);
    return venue || null;
  },

  async getBar(id: string): Promise<Venue | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    const venue = bars.find(v => v.id === id);
    return venue || null;
  },
};