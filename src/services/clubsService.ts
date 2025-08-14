import { Venue } from '../contracts/types';

export const clubsService = {
  async listClubs(district?: string, tags?: string[]): Promise<Venue[]> {
    // TODO: Replace with actual Supabase query
    // This is a placeholder structure showing how the data should be fetched
    
    // Example query structure:
    // const { data, error } = await supabase
    //   .from('clubs')
    //   .select(`
    //     id,
    //     name,
    //     description,
    //     districts(name),
    //     club_ratings(music_rating, vibe_rating, crowd_rating, safety_rating),
    //     club_themes(themes(name))
    //   `)
    //   .eq(district ? 'districts.name' : '', district)
    
    // For now, return mock data that matches database structure
    const mockClubs: Venue[] = [
      {
        id: '1',
        name: 'Berghain',
        district: 'Friedrichshain',
        tags: ['techno', 'late-night', 'tourist-free'],
        ratings: {
          music: 95,
          vibe: 88,
          crowd: 92,
          safety: 85,
        },
        hasLiveVibe: true,
        description: 'The cathedral of techno. Unforgiving door, transcendent experience.',
        address: 'Am Wriezener Bahnhof',
      },
      {
        id: '2',
        name: 'About Blank',
        district: 'Friedrichshain',
        tags: ['techno', 'outdoor', 'queer-friendly'],
        ratings: {
          music: 82,
          vibe: 90,
          crowd: 85,
          safety: 88,
        },
        hasLiveVibe: true,
        description: 'Raw space with garden. More welcoming door, diverse crowd.',
      },
      {
        id: '3',
        name: 'Watergate',
        district: 'Kreuzberg',
        tags: ['house', 'techno', 'tourist-free'],
        ratings: {
          music: 85,
          vibe: 80,
          crowd: 78,
          safety: 90,
        },
        hasLiveVibe: false,
        description: 'Panoramic Spree views. Sophisticated sound, mixed crowd.',
      },
      {
        id: '4',
        name: 'Ritter Butzke',
        district: 'Kreuzberg',
        tags: ['techno', 'house', 'cash-only', 'smoke-room'],
        ratings: {
          music: 88,
          vibe: 85,
          crowd: 82,
          safety: 80,
        },
        hasLiveVibe: true,
        description: 'Hidden gem in former newspaper printing house.',
      },
      {
        id: '5',
        name: 'Sisyphos',
        district: 'Lichtenberg',
        tags: ['techno', 'outdoor', 'late-night'],
        ratings: {
          music: 90,
          vibe: 92,
          crowd: 88,
          safety: 82,
        },
        hasLiveVibe: true,
        description: 'Endless party in industrial wasteland. Garden, multiple floors.',
      },
      {
        id: '6',
        name: 'Tresor',
        district: 'Mitte',
        tags: ['techno', 'underground', 'cash-only'],
        ratings: {
          music: 93,
          vibe: 87,
          crowd: 85,
          safety: 78,
        },
        hasLiveVibe: false,
        description: 'Legendary basement techno temple. Raw, uncompromising sound.',
      },
    ];

    // Apply filters
    let filtered = [...mockClubs];
    
    if (district) {
      filtered = filtered.filter(venue => venue.district === district);
    }
    
    if (tags && tags.length > 0) {
      filtered = filtered.filter(venue => 
        tags.some(tag => venue.tags.includes(tag as any))
      );
    }
    
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));
    
    return filtered;
  },

  async getClub(id: string): Promise<Venue | null> {
    // TODO: Replace with actual Supabase query
    // const { data, error } = await supabase
    //   .from('clubs')
    //   .select(`
    //     id,
    //     name,
    //     description,
    //     districts(name),
    //     club_ratings(music_rating, vibe_rating, crowd_rating, safety_rating),
    //     club_themes(themes(name)),
    //     club_locations(address_line)
    //   `)
    //   .eq('id', id)
    //   .single()
    
    await new Promise(resolve => setTimeout(resolve, 200));
    
    // For now, get from the mock data
    const clubs = await this.listClubs();
    return clubs.find(club => club.id === id) || null;
  },
};