import { Venue } from '../contracts/types';
import { nightclubs, bars } from '../data/venues';

export const venuesService = {
  // 获取夜店列表 - 用于 CLUBS 页面
  async listVenues(district?: string, tags?: string[]): Promise<Venue[]> {
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

  // 获取酒吧列表 - 用于 BARS 页面
  async listBars(district?: string, tags?: string[]): Promise<Venue[]> {
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

  // 获取单个场所详情 - 支持夜店和酒吧
  async getVenue(id: string): Promise<Venue | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    // 先在夜店中查找
    let venue = nightclubs.find(v => v.id === id);
    if (venue) return venue;
    
    // 再在酒吧中查找
    venue = bars.find(v => v.id === id);
    return venue || null;
  },

  // 保持向后兼容的方法
  async listNightclubs(district?: string, tags?: string[]): Promise<Venue[]> {
    return this.listVenues(district, tags);
  },

  async getNightclub(id: string): Promise<Venue | null> {
    return this.getVenue(id);
  },

  async getBar(id: string): Promise<Venue | null> {
    return this.getVenue(id);
  },
};