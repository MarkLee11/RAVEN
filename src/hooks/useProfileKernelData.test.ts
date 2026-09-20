import { renderHook, waitFor, act } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { useProfileKernelData } from './useProfileKernelData';
import { barsService } from '../services/barsService';
import { clubsService } from '../services/clubsService';
import { reviewsService } from '../services/reviewsService';

vi.mock('../services/barsService', () => ({
  barsService: {
    getTotalCount: vi.fn(),
  },
}));

vi.mock('../services/clubsService', () => ({
  clubsService: {
    getTotalCount: vi.fn(),
  },
}));

vi.mock('../services/reviewsService', () => ({
  reviewsService: {
    getUserClubsVisited: vi.fn(),
    getUserBarsVisited: vi.fn(),
    getUserReviewHistory: vi.fn(),
  },
}));

const barsTotalMock = vi.mocked(barsService.getTotalCount);
const clubsTotalMock = vi.mocked(clubsService.getTotalCount);
const userClubsVisitedMock = vi.mocked(reviewsService.getUserClubsVisited);
const userBarsVisitedMock = vi.mocked(reviewsService.getUserBarsVisited);
const reviewHistoryMock = vi.mocked(reviewsService.getUserReviewHistory);

describe('useProfileKernelData', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    barsTotalMock.mockResolvedValue(300);
    clubsTotalMock.mockResolvedValue(120);
  });

  it('loads deathmarch data and empty echo when user is not authenticated', async () => {
    const { result } = renderHook(() => useProfileKernelData({ userId: null }));

    await waitFor(() => {
      expect(result.current.deathmarch.state).toBe('ready');
      expect(result.current.echo.state).toBe('empty');
    });

    expect(result.current.deathmarch.data).toMatchObject({
      clubsTotal: 120,
      barsTotal: 300,
      userClubsVisited: 0,
      userBarsVisited: 0,
    });
    expect(userClubsVisitedMock).not.toHaveBeenCalled();
    expect(userBarsVisitedMock).not.toHaveBeenCalled();
    expect(reviewHistoryMock).not.toHaveBeenCalled();
  });

  it('loads paginated echo history and supports page navigation', async () => {
    userClubsVisitedMock.mockResolvedValue(9);
    userBarsVisitedMock.mockResolvedValue(17);

    reviewHistoryMock
      .mockResolvedValueOnce({
        reviews: [
          {
            id: 'club_1',
            venueId: '1',
            venueName: 'Club One',
            venueType: 'club',
            ratings: { music: 80, crowd: 70, vibe: 90, safety: 60 },
            comment: 'Great night',
            createdAt: new Date('2026-09-20T00:00:00.000Z'),
          },
        ],
        totalCount: 4,
        totalPages: 2,
      })
      .mockResolvedValueOnce({
        reviews: [
          {
            id: 'bar_2',
            venueId: '2',
            venueName: 'Bar Two',
            venueType: 'bar',
            ratings: { music: 72, crowd: 63, vibe: 88, safety: 77 },
            comment: 'Chill vibe',
            createdAt: new Date('2026-09-19T00:00:00.000Z'),
          },
        ],
        totalCount: 4,
        totalPages: 2,
      });

    const { result } = renderHook(() => useProfileKernelData({ userId: 'user-1', pageSize: 2 }));

    await waitFor(() => {
      expect(result.current.deathmarch.state).toBe('ready');
      expect(result.current.echo.state).toBe('ready');
    });

    expect(result.current.deathmarch.data.userClubsVisited).toBe(9);
    expect(result.current.deathmarch.data.userBarsVisited).toBe(17);
    expect(result.current.echo.page).toBe(1);
    expect(result.current.echo.totalPages).toBe(2);
    expect(result.current.echo.hasNextPage).toBe(true);

    act(() => {
      result.current.echo.goToNextPage();
    });

    await waitFor(() => {
      expect(result.current.echo.page).toBe(2);
      expect(result.current.echo.reviews[0].venueName).toBe('Bar Two');
    });

    expect(reviewHistoryMock).toHaveBeenNthCalledWith(1, 'user-1', 1, 2);
    expect(reviewHistoryMock).toHaveBeenNthCalledWith(2, 'user-1', 2, 2);
  });
});
