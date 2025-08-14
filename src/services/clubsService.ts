import { supabase } from '../lib/supabase';
import { Venue } from '../contracts/types';

export const clubsService = {
  async listClubs(district?: string, tags?: string[]): Promise<Venue[]> {
    try {
      let query = supabase
        .from('clubs')
        .select(`
          id,
          name,
          description,
          districts!clubs_district_id_fkey(name),
          club_ratings(music_rating, vibe_rating, crowd_rating, safety_rating),
          club_themes(themes(name)),
          club_tonight_vibe!club_tonight_vibe_club_id_fkey(
            door_strictness_pct,
            music_pct,
            crowd_pct,
            status
          )
        `);

      // Apply district filter
      if (district) {
        query = query.eq('districts.name', district);
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

        return {
          id: club.id.toString(),
          name: club.name,
          district: club.districts?.name || 'Unknown',
          tags: themes as any[], // Map themes to tags
          ratings: {
            music: Math.round(ratings.music_rating || 0),
            vibe: Math.round(ratings.vibe_rating || 0),
            crowd: Math.round(ratings.crowd_rating || 0),
            safety: Math.round(ratings.safety_rating || 0),
          },
          hasLiveVibe,
          description: club.description,
        };
      });

      // Apply tag filter if specified
      let filteredVenues = venues;
      if (tags && tags.length > 0) {
        filteredVenues = venues.filter(venue =>
          tags.some(tag => venue.tags.includes(tag as any))
        );
      }

      return filteredVenues;

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
          club_tonight_vibe!club_tonight_vibe_club_id_fkey(
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
        district: clubData.districts?.name || 'Unknown',
        tags: themes as any[],
        ratings: {
          music: Math.round(ratings.music_rating || 0),
          vibe: Math.round(ratings.vibe_rating || 0),
          crowd: Math.round(ratings.crowd_rating || 0),
          safety: Math.round(ratings.safety_rating || 0),
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