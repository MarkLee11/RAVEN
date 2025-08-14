import { Venue } from '../contracts/types';
import { clubs } from '../data/clubs';

export const clubsService = {
  async listClubs(district?: string, tags?: string[]): Promise<Venue[]> {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));
    
    let filtered = [...clubs];
    
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

  async getClub(id: string): Promise<Venue | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    const club = clubs.find(v => v.id === id);
    return club || null;
  },
};