import { beforeEach, describe, expect, it, vi } from 'vitest';
import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import Bars from './Bars';
import Clubs from './Clubs';
import { barsService, getBarDistricts, getBarThemesByCategory } from '../services/barsService';
import { clubsService, getDistricts } from '../services/clubsService';
import { favoritesService } from '../services/favoritesService';
import type { Venue } from '../contracts/types';

vi.mock('../services/barsService', () => ({
  barsService: {
    listBars: vi.fn(),
  },
  getBarDistricts: vi.fn(),
  getBarThemesByCategory: vi.fn(),
}));

vi.mock('../services/clubsService', () => ({
  clubsService: {
    listClubs: vi.fn(),
  },
  getDistricts: vi.fn(),
}));

vi.mock('../services/favoritesService', () => ({
  favoritesService: {
    getFavoriteStatuses: vi.fn(),
    toggleFavorite: vi.fn(),
  },
}));

const listBarsMock = vi.mocked(barsService.listBars);
const getBarDistrictsMock = vi.mocked(getBarDistricts);
const getBarThemesByCategoryMock = vi.mocked(getBarThemesByCategory);
const listClubsMock = vi.mocked(clubsService.listClubs);
const getDistrictsMock = vi.mocked(getDistricts);
const getFavoriteStatusesMock = vi.mocked(favoritesService.getFavoriteStatuses);

const barFixture: Venue = {
  id: 'bar-1',
  name: 'Test Bar',
  district: 'Mitte',
  tags: ['techno'],
  ratings: { music: 88, vibe: 77, crowd: 66, safety: 55 },
  hasLiveVibe: false,
  description: 'A stable test bar',
};

const clubFixture: Venue = {
  id: 'club-1',
  name: 'Test Club',
  district: 'Kreuzberg',
  tags: ['outdoor-area'],
  ratings: { music: 90, vibe: 80, crowd: 70, safety: 60 },
  hasLiveVibe: true,
  description: 'A stable test club',
};

describe('venue list loading and retry flows', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    getBarDistrictsMock.mockResolvedValue(['Mitte']);
    getBarThemesByCategoryMock.mockResolvedValue({});
    getDistrictsMock.mockResolvedValue(['Kreuzberg']);
    getFavoriteStatusesMock.mockResolvedValue({});
  });

  it('loads bars list successfully', async () => {
    listBarsMock.mockResolvedValue([barFixture]);

    render(
      <MemoryRouter>
        <Bars />
      </MemoryRouter>
    );

    expect(screen.getByText('Loading bars...')).toBeInTheDocument();
    expect(await screen.findByText('Test Bar')).toBeInTheDocument();
    expect(listBarsMock).toHaveBeenCalled();
  });

  it('retries bars list after initial failure', async () => {
    listBarsMock
      .mockRejectedValueOnce(new Error('network'))
      .mockResolvedValueOnce([{ ...barFixture, name: 'Recovered Bar' }]);

    render(
      <MemoryRouter>
        <Bars />
      </MemoryRouter>
    );

    expect(await screen.findByText('Failed to load bars. Please try again.')).toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Try Again' }));

    await waitFor(() => {
      expect(screen.getByText('Recovered Bar')).toBeInTheDocument();
    });
    expect(listBarsMock).toHaveBeenCalledTimes(2);
  });

  it('loads clubs list successfully', async () => {
    listClubsMock.mockResolvedValue([clubFixture]);

    render(
      <MemoryRouter>
        <Clubs />
      </MemoryRouter>
    );

    expect(screen.getByText('Loading clubs...')).toBeInTheDocument();
    expect(await screen.findByText('Test Club')).toBeInTheDocument();
    expect(listClubsMock).toHaveBeenCalled();
  });

  it('retries clubs list after initial failure', async () => {
    listClubsMock
      .mockRejectedValueOnce(new Error('network'))
      .mockResolvedValueOnce([{ ...clubFixture, name: 'Recovered Club' }]);

    render(
      <MemoryRouter>
        <Clubs />
      </MemoryRouter>
    );

    expect(await screen.findByText('Failed to load clubs. Please try again.')).toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Try Again' }));

    await waitFor(() => {
      expect(screen.getByText('Recovered Club')).toBeInTheDocument();
    });
    expect(listClubsMock).toHaveBeenCalledTimes(2);
  });
});
