import { supabase } from '../lib/supabase';
import { Venue } from '../contracts/types';

// 获取所有区域
export const getDistricts = async (): Promise<string[]> => {
  try {
    const { data, error } = await supabase
      .from('districts')
      .select('name')
      .order('name');
    
    if (error) {
      console.error('Error fetching districts:', error);
      return [];
    }
    
    return data?.map(d => d.name) || [];
  } catch (error) {
    console.error('Failed to load districts:', error);
    return [];
  }
};

export const clubsService = {
  async listClubs(
    district?: string, 
    construction?: string[], 
    payment?: string[]
  ): Promise<Venue[]> {
    try {
      let query = supabase
        .from('clubs')
        .select(`
          id,
          name,
          description,
          outdoor_area,
          smoke_room,
          awareness_room,
          dark_room,
          cursing_area,
          cash_only,
          card_accepted,
          districts!clubs_district_id_fkey(name),
          club_ratings(music_rating, vibe_rating, crowd_rating, safety_rating),
          club_themes(themes(name)),
          club_tonight_vibe(
            door_strictness_pct,
            music_pct,
            crowd_pct,
            status
          )
        `);

      // Apply district filter
      if (district) {
        // Join with districts table and filter by district name
        const { data: districtData, error: districtError } = await supabase
          .from('districts')
          .select('id')
          .eq('name', district)
          .single();
        
        if (districtError || !districtData) {
          console.error('District not found:', district);
          return [];
        }
        
        query = query.eq('district_id', districtData.id);
      }

      // Apply construction filters
      if (construction && construction.length > 0) {
        construction.forEach(filter => {
          switch (filter) {
            case 'outdoor-area':
              query = query.eq('outdoor_area', true);
              break;
            case 'smoking-area':
              query = query.eq('smoke_room', true);
              break;
            case 'awareness-room':
              query = query.eq('awareness_room', true);
              break;
            case 'dark-room':
              query = query.eq('dark_room', true);
              break;
            case 'cursing-area':
              query = query.eq('cursing_area', true);
              break;
          }
        });
      }

      // Apply payment filters
      if (payment && payment.length > 0) {
        payment.forEach(filter => {
          switch (filter) {
            case 'cash-only':
              query = query.eq('cash_only', true);
              break;
            case 'card-accepted':
              query = query.eq('card_accepted', true);
              break;
          }
        });
      }

      const { data: clubsData, error } = await query;

      if (error) {
        console.error('Error fetching clubs:', error);
        return [];
      }

      if (!clubsData) return [];

      // Transform database data to Venue format
      const venues: Venue[] = clubsData.map(club => {
        const ratings = club.club_ratings?.[0] || {
          music_rating: 0,
          vibe_rating: 0,
          crowd_rating: 0,
          safety_rating: 0
        };

        const themes = club.club_themes?.map(ct => ct.themes?.name).filter(Boolean) || [];
        const hasLiveVibe = club.club_tonight_vibe?.some(vibe => vibe.status === 'live') || false;

        // Build tags array from database boolean fields and themes
        const tags = [
          ...themes,
          ...(club.outdoor_area ? ['outdoor-area'] : []),
          ...(club.smoke_room ? ['smoking-area'] : []),
          ...(club.awareness_room ? ['awareness-room'] : []),
          ...(club.dark_room ? ['dark-room'] : []),
          ...(club.cursing_area ? ['cursing-area'] : []),
          ...(club.cash_only ? ['cash-only'] : []),
          ...(club.card_accepted ? ['card-accepted'] : []),
        ];

        return {
          id: club.id.toString(),
          name: club.name,
          district: club.districts?.name || 'Unknown District',
          tags: tags as any[],
          ratings: {
            music: Math.round((ratings.music_rating || 0) * 20), // Convert 0-5 to 0-100
            vibe: Math.round((ratings.vibe_rating || 0) * 20),
            crowd: Math.round((ratings.crowd_rating || 0) * 20),
            safety: Math.round((ratings.safety_rating || 0) * 20),
          },
          hasLiveVibe,
          description: club.description,
        };
      });

      return venues;

    } catch (error) {
      console.error('Failed to load clubs:', error);
      return [];
    }
  },

  async getClub(id: string): Promise<Venue | null> {
    try {
      const { data: clubData, error } = await supabase
        .from('clubs')
        .select(`
          id,
          name,
          description,
          districts!clubs_district_id_fkey(name),
          club_ratings(music_rating, vibe_rating, crowd_rating, safety_rating),
          club_themes(themes(name)),
          club_tonight_vibe(
            door_strictness_pct,
            music_pct,
            crowd_pct,
            status
          ),
          club_locations(address_line)
        `)
        .eq('id', parseInt(id))
        .single();

      if (error || !clubData) {
        console.error('Error fetching club:', error);
        return null;
      }

      const ratings = clubData.club_ratings?.[0] || {
        music_rating: 0,
        vibe_rating: 0,
        crowd_rating: 0,
        safety_rating: 0
      };

      const themes = clubData.club_themes?.map(ct => ct.themes?.name).filter(Boolean) || [];
      const hasLiveVibe = clubData.club_tonight_vibe?.some(vibe => vibe.status === 'live') || false;

      return {
        id: clubData.id.toString(),
        name: clubData.name,
        district: clubData.districts?.name || 'Unknown District',
        tags: themes as any[],
        ratings: {
          music: Math.round((ratings.music_rating || 0) * 20),
          vibe: Math.round((ratings.vibe_rating || 0) * 20),
          crowd: Math.round((ratings.crowd_rating || 0) * 20),
          safety: Math.round((ratings.safety_rating || 0) * 20),
        },
        hasLiveVibe,
        description: clubData.description,
        address: clubData.club_locations?.[0]?.address_line,
      };

    } catch (error) {
      console.error('Failed to load club:', error);
      return null;
    }
  },
};