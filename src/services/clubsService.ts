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
          crusing_area,
          cash_only,
          card_accepted,
          districts!fk_clubs_district(name),
          club_ratings!club_ratings_club_id_fkey(music_rating, vibe_rating, crowd_rating, safety_rating),
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
              query = query.eq('crusing_area', true);
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

      // Compute review-averaged ratings for each club (0-5 -> 0-100)
      const clubIds: number[] = clubsData.map((c: any) => c.id).filter((v: any) => typeof v === 'number');
      let averagesByClubId: Record<number, { music: number; vibe: number; crowd: number; safety: number }> = {};
      try {
        if (clubIds.length > 0) {
          const { data: avgRows, error: avgError } = await supabase
            .from('club_reviews')
            .select('club_id, music_rating, vibe_rating, crowd_rating, safety_rating')
            .in('club_id', clubIds);
          if (!avgError && Array.isArray(avgRows)) {
            const agg: Record<number, { m: number; v: number; c: number; s: number; n: number }> = {};
            for (const row of avgRows as any[]) {
              const idNum = Number(row.club_id);
              if (!agg[idNum]) agg[idNum] = { m: 0, v: 0, c: 0, s: 0, n: 0 };
              agg[idNum].m += Number(row.music_rating || 0);
              agg[idNum].v += Number(row.vibe_rating || 0);
              agg[idNum].c += Number(row.crowd_rating || 0);
              agg[idNum].s += Number(row.safety_rating || 0);
              agg[idNum].n += 1;
            }
            for (const [idStr, val] of Object.entries(agg)) {
              const idNum = Number(idStr);
              if (val.n > 0) {
                averagesByClubId[idNum] = {
                  music: Math.round((val.m / val.n) * 20),
                  vibe: Math.round((val.v / val.n) * 20),
                  crowd: Math.round((val.c / val.n) * 20),
                  safety: Math.round((val.s / val.n) * 20),
                };
              }
            }
          }
        }
      } catch (avgErr) {
        console.warn('Average review ratings aggregation failed; falling back to club_ratings.', avgErr);
      }

      // Transform database data to Venue format
      const venues: Venue[] = clubsData.map(club => {
        const ratings = club.club_ratings || {
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
          ...(club.crusing_area ? ['cursing-area'] : []),
          ...(club.cash_only ? ['cash-only'] : []),
          ...(club.card_accepted ? ['card-accepted'] : []),
        ];

        const averaged = averagesByClubId[Number(club.id)];

        return {
          id: club.id.toString(),
          name: club.name,
          district: club.districts?.name || 'Unknown District',
          tags: tags as any[],
          ratings: {
            // Prefer arithmetic mean from reviews if available, else fall back to club_ratings
            music: averaged ? averaged.music : Math.round(ratings?.music_rating || 0),
            vibe: averaged ? averaged.vibe : Math.round(ratings?.vibe_rating || 0),
            crowd: averaged ? averaged.crowd : Math.round(ratings?.crowd_rating || 0),
            safety: averaged ? averaged.safety : Math.round(ratings?.safety_rating || 0),
          },
          hasLiveVibe,
          description: club.description,
        };
      });

      // Sort by total rating score (descending)
      return venues.sort((a, b) => {
        const totalA = a.ratings.music + a.ratings.vibe + a.ratings.crowd + a.ratings.safety;
        const totalB = b.ratings.music + b.ratings.vibe + b.ratings.crowd + b.ratings.safety;
        return totalB - totalA;
      });

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
          districts!fk_clubs_district(name),
          club_ratings!club_ratings_club_id_fkey(music_rating, vibe_rating, crowd_rating, safety_rating),
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

      const ratings = clubData.club_ratings || {
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
          music: Math.round(ratings?.music_rating || 0),
          vibe: Math.round(ratings?.vibe_rating || 0),
          crowd: Math.round(ratings?.crowd_rating || 0),
          safety: Math.round(ratings?.safety_rating || 0),
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

  async getTotalCount(): Promise<number> {
    try {
      const { count, error } = await supabase
        .from('clubs')
        .select('*', { count: 'exact', head: true });

      if (error) {
        throw error;
      }

      return count || 0;
    } catch (error) {
      console.error('Failed to get clubs count:', error);
      return 0;
    }
  },
};