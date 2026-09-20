import { supabase } from '../lib/supabase';
import { Venue } from '../contracts/types';

export interface FavoriteVenue extends Venue {
  favoriteId: string;
  favoriteCreatedAt: Date;
}

interface DistrictRef {
  name?: string;
}

interface ThemeRef {
  name?: string;
}

interface BarRatingsRef {
  quality_rating?: number;
  price_rating?: number;
  vibe_rating?: number;
  friendliness_rating?: number;
}

interface ClubRatingsRef {
  music_rating?: number;
  vibe_rating?: number;
  crowd_rating?: number;
  safety_rating?: number;
}

interface BarRelation {
  id: number;
  name: string;
  description?: string;
  districts?: DistrictRef | DistrictRef[] | null;
  bar_ratings?: BarRatingsRef | BarRatingsRef[] | null;
  bar_themes?: Array<{ themes?: ThemeRef | ThemeRef[] | null }> | null;
}

interface ClubRelation {
  id: number;
  name: string;
  description?: string;
  districts?: DistrictRef | DistrictRef[] | null;
  club_ratings?: ClubRatingsRef | ClubRatingsRef[] | null;
  club_themes?: Array<{ themes?: ThemeRef | ThemeRef[] | null }> | null;
  club_tonight_vibe?: Array<{ status?: string }> | null;
}

const firstItem = <T>(value: T | T[] | null | undefined): T | null => {
  if (!value) return null;
  return Array.isArray(value) ? (value[0] ?? null) : value;
};

const isPresent = <T>(value: T | null): value is T => value !== null;

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

      const favoriteIds = (data || [])
        .map((item: Record<string, unknown>) => item[columnName])
        .filter((value): value is number => typeof value === 'number')
        .map((value) => value.toString());
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

      return data?.map<FavoriteVenue | null>((fav) => {
        const bar = firstItem(fav.bars as BarRelation | BarRelation[] | null);
        if (!bar) return null;

        const ratings = firstItem(bar.bar_ratings) || {
          quality_rating: 0,
          price_rating: 0,
          vibe_rating: 0,
          friendliness_rating: 0
        };

        const themes = (bar.bar_themes || [])
          .map((bt) => firstItem(bt.themes)?.name)
          .filter((name): name is string => Boolean(name));

        return {
          id: bar.id.toString(),
          name: bar.name,
          district: firstItem(bar.districts)?.name || 'Unknown District',
          tags: themes,
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
      }).filter(isPresent) ?? [];

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

      return data?.map<FavoriteVenue | null>((fav) => {
        const club = firstItem(fav.clubs as ClubRelation | ClubRelation[] | null);
        if (!club) return null;

        const ratings = firstItem(club.club_ratings) || {
          music_rating: 0,
          vibe_rating: 0,
          crowd_rating: 0,
          safety_rating: 0
        };

        const themes = (club.club_themes || [])
          .map((ct) => firstItem(ct.themes)?.name)
          .filter((name): name is string => Boolean(name));
        const hasLiveVibe = club.club_tonight_vibe?.some(vibe => vibe.status === 'live') || false;

        return {
          id: club.id.toString(),
          name: club.name,
          district: firstItem(club.districts)?.name || 'Unknown District',
          tags: themes,
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
      }).filter(isPresent) ?? [];

    } catch (error) {
      console.error('Failed to load favorite clubs:', error);
      return [];
    }
  },
};
