import { Venue } from '../contracts/types';
import { venues } from '../data/venues';

export const venuesService = {
  async listVenues(district?: string, tags?: string[]): Promise<Venue[]> {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));
    
    let filtered = [...venues];
    
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

  async getVenue(id: string): Promise<Venue | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    const venue = venues.find(v => v.id === id);
    return venue || null;
  },
};