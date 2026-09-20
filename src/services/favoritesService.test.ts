import { beforeEach, describe, expect, it, vi } from 'vitest';
import { favoritesService } from './favoritesService';
import { supabase } from '../lib/supabase';

vi.mock('../lib/supabase', () => ({
  supabase: {
    auth: {
      getUser: vi.fn(),
    },
    from: vi.fn(),
  },
}));

describe('favoritesService', () => {
  const getUserMock = supabase.auth.getUser as unknown as ReturnType<typeof vi.fn>;
  const fromMock = supabase.from as unknown as ReturnType<typeof vi.fn>;

  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('addFavorite inserts bar favorite for authenticated user', async () => {
    getUserMock.mockResolvedValue({
      data: { user: { id: 'user-1' } },
      error: null,
    });

    const insert = vi.fn().mockResolvedValue({ error: null });
    fromMock.mockReturnValue({ insert });

    const result = await favoritesService.addFavorite('12', 'bar');

    expect(result).toBe(true);
    expect(fromMock).toHaveBeenCalledWith('bar_favorites');
    expect(insert).toHaveBeenCalledWith({
      user_id: 'user-1',
      bar_id: 12,
    });
  });

  it('isFavorite returns false for unauthenticated user', async () => {
    getUserMock.mockResolvedValue({
      data: { user: null },
      error: null,
    });

    const result = await favoritesService.isFavorite('12', 'bar');

    expect(result).toBe(false);
    expect(fromMock).not.toHaveBeenCalled();
  });
});
