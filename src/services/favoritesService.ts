import { supabase } from '../lib/supabase';
import { Venue } from '../contracts/types';

export interface FavoriteVenue extends Venue {
  favoriteId: string;
  favoriteCreatedAt: Date;
}

export const favoritesService = {
  // Check if a venue is favorited by the current user
  async isFavorite(venueId: string, venueType: 'bar' | 'club'): Promise<boolean> {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) return false;

      const tableName = venueType === 'bar' ? 'bar_favorites' : 'club_favorites';
      const columnName = venueType === 'bar' ? 'bar_id' : 'club_id';

      const { data, error } = await supabase
        .from(tableName)
        .select('id')
        .eq('user_id', user.id)
        .eq(columnName, parseInt(venueId))
        .single();

      if (error && error.code !== 'PGRST116') {
        console.error('Error checking favorite status:', error);
        return false;
      }

      return !!data;
    } catch (error) {
      console.error('Failed to check favorite status:', error);
      return false;
    }
  },

  // Add a venue to favorites
  async addFavorite(venueId: string, venueType: 'bar' | 'club'): Promise<boolean> {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) {
        console.error('User not authenticated');
        return false;
      }

      const tableName = venueType === 'bar' ? 'bar_favorites' : 'club_favorites';
      const columnName = venueType === 'bar' ? 'bar_id' : 'club_id';

      const { error } = await supabase
        .from(tableName)
        .insert({
          user_id: user.id,
          [columnName]: parseInt(venueId)
        });

      if (error) {
        console.error('Error adding favorite:', error);
        return false;
      }

      return true;
    } catch (error) {
      console.error('Failed to add favorite:', error);
      return false;
    }
  },

  // Remove a venue from favorites
  async removeFavorite(venueId: string, venueType: 'bar' | 'club'): Promise<boolean> {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) {
        console.error('User not authenticated');
        return false;
      }

      const tableName = venueType === 'bar' ? 'bar_favorites' : 'club_favorites';
      const columnName = venueType === 'bar' ? 'bar_id' : 'club_id';

      const { error } = await supabase
        .from(tableName)
        .delete()
        .eq('user_id', user.id)
        .eq(columnName, parseInt(venueId));

      if (error) {
        console.error('Error removing favorite:', error);
        return false;
      }

      return true;
    } catch (error) {
      console.error('Failed to remove favorite:', error);
      return false;
    }
  },

  // Toggle favorite status
  async toggleFavorite(venueId: string, venueType: 'bar' | 'club'): Promise<boolean> {
    const isFav = await this.isFavorite(venueId, venueType);
    if (isFav) {
      return await this.removeFavorite(venueId, venueType);
    } else {
      return await this.addFavorite(venueId, venueType);
    }
  },

  // Get multiple favorite statuses at once
  async getFavoriteStatuses(venueIds: string[], venueType: 'bar' | 'club'): Promise<Record<string, boolean>> {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) return {};

      const tableName = venueType === 'bar' ? 'bar_favorites' : 'club_favorites';
      const columnName = venueType === 'bar' ? 'bar_id' : 'club_id';

      const { data, error } = await supabase
        .from(tableName)
        .select(`${columnName}`)
        .eq('user_id', user.id)
        .in(columnName, venueIds.map(id => parseInt(id)));

      if (error) {
        console.error('Error checking favorite statuses:', error);
        return {};
      }

      const favoriteIds = data?.map(item => item[columnName].toString()) || [];
      const result: Record<string, boolean> = {};
      
      venueIds.forEach(id => {
        result[id] = favoriteIds.includes(id);
      });

      return result;
    } catch (error) {
      console.error('Failed to check favorite statuses:', error);
      return {};
    }
  },

  // Get user's favorite bars
  async getFavoriteBars(): Promise<FavoriteVenue[]> {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) return [];

      const { data, error } = await supabase
        .from('bar_favorites')
        .select(`
          id,
          created_at,
          bars!bar_favorites_bar_id_fkey (
            id,
            name,
            description,
            districts!bars_district_id_fkey(name),
            bar_ratings!bar_ratings_bar_id_fkey(quality_rating, price_rating, vibe_rating, friendliness_rating),
            bar_themes(themes(name))
          )
        `)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching favorite bars:', error);
        return [];
      }

      return data?.map(fav => {
        const bar = fav.bars;
        if (!bar) return null;

        const ratings = bar.bar_ratings || {
          quality_rating: 0,
          price_rating: 0,
          vibe_rating: 0,
          friendliness_rating: 0
        };

        const themes = bar.bar_themes?.map(bt => bt.themes?.name).filter(Boolean) || [];

        return {
          id: bar.id.toString(),
          name: bar.name,
          district: bar.districts?.name || 'Unknown District',
          tags: themes as any[],
          ratings: {
            music: Math.round(ratings?.quality_rating || 0),
            vibe: Math.round(ratings?.vibe_rating || 0),
            crowd: Math.round(ratings?.price_rating || 0),
            safety: Math.round(ratings?.friendliness_rating || 0),
          },
          hasLiveVibe: false,
          description: bar.description,
          favoriteId: fav.id.toString(),
          favoriteCreatedAt: new Date(fav.created_at),
        };
      }).filter(Boolean) as FavoriteVenue[] || [];

    } catch (error) {
      console.error('Failed to load favorite bars:', error);
      return [];
    }
  },

  // Get user's favorite clubs
  async getFavoriteClubs(): Promise<FavoriteVenue[]> {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser();
      if (userError || !user) return [];

      const { data, error } = await supabase
        .from('club_favorites')
        .select(`
          id,
          created_at,
          clubs!club_favorites_club_id_fkey (
            id,
            name,
            description,
            districts!fk_clubs_district(name),
            club_ratings!club_ratings_club_id_fkey(music_rating, vibe_rating, crowd_rating, safety_rating),
            club_themes(themes(name)),
            club_tonight_vibe(status)
          )
        `)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching favorite clubs:', error);
        return [];
      }

      return data?.map(fav => {
        const club = fav.clubs;
        if (!club) return null;

        const ratings = club.club_ratings || {
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
          district: club.districts?.name || 'Unknown District',
          tags: themes as any[],
          ratings: {
            music: Math.round(ratings?.music_rating || 0),
            vibe: Math.round(ratings?.vibe_rating || 0),
            crowd: Math.round(ratings?.crowd_rating || 0),
            safety: Math.round(ratings?.safety_rating || 0),
          },
          hasLiveVibe,
          description: club.description,
          favoriteId: fav.id.toString(),
          favoriteCreatedAt: new Date(fav.created_at),
        };
      }).filter(Boolean) as FavoriteVenue[] || [];

    } catch (error) {
      console.error('Failed to load favorite clubs:', error);
      return [];
    }
  },
};
