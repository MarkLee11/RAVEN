import { beforeEach, describe, expect, it, vi } from 'vitest';
import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import BarDetail from './BarDetail';
import ClubDetail from './ClubDetail';
import { barsService } from '../services/barsService';
import { clubsService } from '../services/clubsService';
import { reviewsService } from '../services/reviewsService';
import { vibeService } from '../services/vibeService';
import { favoritesService } from '../services/favoritesService';
import type { Venue } from '../contracts/types';

vi.mock('../services/barsService', () => ({
  barsService: {
    getBar: vi.fn(),
  },
}));

vi.mock('../services/clubsService', () => ({
  clubsService: {
    getClub: vi.fn(),
  },
}));

vi.mock('../services/reviewsService', () => ({
  reviewsService: {
    listBarReviews: vi.fn(),
    listReviews: vi.fn(),
  },
}));

vi.mock('../services/vibeService', () => ({
  vibeService: {
    getVibeSummary: vi.fn(),
  },
}));

vi.mock('../services/favoritesService', () => ({
  favoritesService: {
    isFavorite: vi.fn(),
    toggleFavorite: vi.fn(),
  },
}));

const getBarMock = vi.mocked(barsService.getBar);
const getClubMock = vi.mocked(clubsService.getClub);
const listBarReviewsMock = vi.mocked(reviewsService.listBarReviews);
const listReviewsMock = vi.mocked(reviewsService.listReviews);
const getVibeSummaryMock = vi.mocked(vibeService.getVibeSummary);
const isFavoriteMock = vi.mocked(favoritesService.isFavorite);

const barFixture: Venue = {
  id: '1',
  name: 'Recovered Bar Detail',
  district: 'Mitte',
  tags: ['tag'],
  ratings: { music: 90, vibe: 80, crowd: 70, safety: 60 },
  hasLiveVibe: false,
};

const clubFixture: Venue = {
  id: '2',
  name: 'Recovered Club Detail',
  district: 'Kreuzberg',
  tags: ['tag'],
  ratings: { music: 92, vibe: 82, crowd: 72, safety: 62 },
  hasLiveVibe: false,
};

describe('venue detail retry behavior', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    listBarReviewsMock.mockResolvedValue([]);
    listReviewsMock.mockResolvedValue([]);
    getVibeSummaryMock.mockResolvedValue(null);
    isFavoriteMock.mockResolvedValue(false);
  });

  it('retries bar detail loading after failure', async () => {
    getBarMock
      .mockRejectedValueOnce(new Error('boom'))
      .mockResolvedValueOnce(barFixture);

    render(
      <MemoryRouter initialEntries={['/bars/1']}>
        <Routes>
          <Route path="/bars/:id" element={<BarDetail />} />
        </Routes>
      </MemoryRouter>
    );

    expect(await screen.findByText('Failed to load bar details. Please try again.')).toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Try Again' }));

    await waitFor(() => {
      expect(screen.getByText('Recovered Bar Detail')).toBeInTheDocument();
    });
    expect(getBarMock).toHaveBeenCalledTimes(2);
  });

  it('retries club detail loading after failure', async () => {
    getClubMock
      .mockRejectedValueOnce(new Error('boom'))
      .mockResolvedValueOnce(clubFixture);

    render(
      <MemoryRouter initialEntries={['/clubs/2']}>
        <Routes>
          <Route path="/clubs/:id" element={<ClubDetail />} />
        </Routes>
      </MemoryRouter>
    );

    expect(await screen.findByText('Failed to load club details. Please try again.')).toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Try Again' }));

    await waitFor(() => {
      expect(screen.getByText('Recovered Club Detail')).toBeInTheDocument();
    });
    expect(getClubMock).toHaveBeenCalledTimes(2);
  });
});
