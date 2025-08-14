import { supabase } from '../lib/supabase';
import { Venue } from '../contracts/types';

// 获取所有区域 (与clubs共用)
export const getBarDistricts = async (): Promise<string[]> => {
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

// 获取bars的主题分类 (用于过滤器)
export const getBarThemesByCategory = async (): Promise<Record<string, string[]>> => {
  try {
    const { data, error } = await supabase
      .from('themes')
      .select('name, category')
      .in('category', ['drinks', 'style', 'architecture', 'vibe', 'music'])
      .order('category, name');
    
    if (error) {
      console.error('Error fetching bar themes:', error);
      return {};
    }
    
    const themesByCategory: Record<string, string[]> = {};
    data?.forEach(theme => {
      if (!themesByCategory[theme.category]) {
        themesByCategory[theme.category] = [];
      }
      themesByCategory[theme.category].push(theme.name);
    });
    
    return themesByCategory;
  } catch (error) {
    console.error('Failed to load bar themes:', error);
    return {};
  }
};

export const barsService = {
  async listBars(
    district?: string, 
    themes?: string[]
  ): Promise<Venue[]> {
    try {
      let query = supabase
        .from('bars')
        .select(`
          id,
          name,
          description,
          cash_only,
          card_accepted,
          districts!bars_district_id_fkey(name),
          bar_ratings!bar_ratings_bar_id_fkey(quality_rating, price_rating, vibe_rating, friendliness_rating),
          bar_themes(themes(name, category)),
          bar_locations(address_line)
        `);

      // Apply district filter
      if (district) {
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

      const { data: barsData, error } = await query;

      if (error) {
        console.error('Error fetching bars:', error);
        return [];
      }

      if (!barsData) return [];

      // Apply theme filtering if provided
      let filteredBars = barsData;
      if (themes && themes.length > 0) {
        filteredBars = barsData.filter(bar => 
          bar.bar_themes?.some(bt => 
            themes.includes(bt.themes?.name)
          )
        );
      }

      // Compute review-averaged ratings for each bar (0-100 scale)
      const barIds: number[] = filteredBars.map((b: any) => b.id).filter((v: any) => typeof v === 'number');
      let averagesByBarId: Record<number, { quality: number; price: number; vibe: number; friendliness: number }> = {};
      
      try {
        if (barIds.length > 0) {
          const { data: avgRows, error: avgError } = await supabase
            .from('bar_reviews')
            .select('bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating')
            .in('bar_id', barIds);
            
          if (!avgError && Array.isArray(avgRows)) {
            const agg: Record<number, { q: number; p: number; v: number; f: number; n: number }> = {};
            for (const row of avgRows as any[]) {
              const idNum = Number(row.bar_id);
              if (!agg[idNum]) agg[idNum] = { q: 0, p: 0, v: 0, f: 0, n: 0 };
              agg[idNum].q += Number(row.quality_rating || 0);
              agg[idNum].p += Number(row.price_rating || 0);
              agg[idNum].v += Number(row.vibe_rating || 0);
              agg[idNum].f += Number(row.friendliness_rating || 0);
              agg[idNum].n += 1;
            }
            for (const [idStr, val] of Object.entries(agg)) {
              const idNum = Number(idStr);
              if (val.n > 0) {
                averagesByBarId[idNum] = {
                  quality: Math.round(val.q / val.n),
                  price: Math.round(val.p / val.n),
                  vibe: Math.round(val.v / val.n),
                  friendliness: Math.round(val.f / val.n),
                };
              }
            }
          }
        }
      } catch (avgErr) {
        console.warn('Average review ratings aggregation failed; falling back to bar_ratings.', avgErr);
      }

      // Transform database data to Venue format
      const venues: Venue[] = filteredBars.map(bar => {
        const ratings = bar.bar_ratings || {
          quality_rating: 0,
          price_rating: 0,
          vibe_rating: 0,
          friendliness_rating: 0
        };

        const themes = bar.bar_themes?.map(bt => bt.themes?.name).filter(Boolean) || [];
        
        // Build tags array from themes and payment info
        const tags = [
          ...themes,
          ...(bar.cash_only ? ['cash-only'] : []),
          ...(bar.card_accepted ? ['card-accepted'] : []),
        ];

        const averaged = averagesByBarId[Number(bar.id)];

        return {
          id: bar.id.toString(),
          name: bar.name,
          district: bar.districts?.name || 'Unknown District',
          tags: tags as any[],
          ratings: {
            // Map new rating dimensions to old structure for compatibility
            // quality -> music, price -> crowd, vibe -> vibe, friendliness -> safety
            music: averaged ? averaged.quality : Math.round(ratings?.quality_rating || 0),
            vibe: averaged ? averaged.vibe : Math.round(ratings?.vibe_rating || 0),
            crowd: averaged ? averaged.price : Math.round(ratings?.price_rating || 0),
            safety: averaged ? averaged.friendliness : Math.round(ratings?.friendliness_rating || 0),
          },
          hasLiveVibe: false, // Bars don't have live vibe feature
          description: bar.description,
          address: bar.bar_locations?.[0]?.address_line,
        };
      });

      // Sort by total rating score (descending)
      return venues.sort((a, b) => {
        const totalA = a.ratings.music + a.ratings.vibe + a.ratings.crowd + a.ratings.safety;
        const totalB = b.ratings.music + b.ratings.vibe + b.ratings.crowd + b.ratings.safety;
        return totalB - totalA;
      });

    } catch (error) {
      console.error('Failed to load bars:', error);
      return [];
    }
  },

  async getBar(id: string): Promise<Venue | null> {
    try {
      const { data: barData, error } = await supabase
        .from('bars')
        .select(`
          id,
          name,
          description,
          cash_only,
          card_accepted,
          districts!bars_district_id_fkey(name),
          bar_ratings!bar_ratings_bar_id_fkey(quality_rating, price_rating, vibe_rating, friendliness_rating),
          bar_themes(themes(name, category)),
          bar_locations(address_line)
        `)
        .eq('id', parseInt(id))
        .single();

      if (error || !barData) {
        console.error('Error fetching bar:', error);
        return null;
      }

      const ratings = barData.bar_ratings || {
        quality_rating: 0,
        price_rating: 0,
        vibe_rating: 0,
        friendliness_rating: 0
      };

      const themes = barData.bar_themes?.map(bt => bt.themes?.name).filter(Boolean) || [];
      
      const tags = [
        ...themes,
        ...(barData.cash_only ? ['cash-only'] : []),
        ...(barData.card_accepted ? ['card-accepted'] : []),
      ];

      return {
        id: barData.id.toString(),
        name: barData.name,
        district: barData.districts?.name || 'Unknown District',
        tags: tags as any[],
        ratings: {
          // Map new rating dimensions for compatibility
          music: Math.round(ratings?.quality_rating || 0),
          vibe: Math.round(ratings?.vibe_rating || 0), 
          crowd: Math.round(ratings?.price_rating || 0),
          safety: Math.round(ratings?.friendliness_rating || 0),
        },
        hasLiveVibe: false,
        description: barData.description,
        address: barData.bar_locations?.[0]?.address_line,
      };

    } catch (error) {
      console.error('Failed to load bar:', error);
      return null;
    }
  },

  async getTotalCount(): Promise<number> {
    try {
      const { count, error } = await supabase
        .from('bars')
        .select('*', { count: 'exact', head: true });

      if (error) {
        throw error;
      }

      return count || 0;
    } catch (error) {
      console.error('Failed to get bars count:', error);
      return 0;
    }
  },
};