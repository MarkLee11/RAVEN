import { useCallback, useEffect, useState } from 'react';
import { barsService } from '../services/barsService';
import { clubsService } from '../services/clubsService';
import { reviewsService, UserReviewHistoryItem } from '../services/reviewsService';

interface UseProfileKernelDataOptions {
  userId: string | null;
  pageSize?: number;
}

type LoadableState = 'loading' | 'error' | 'ready';
type EchoState = LoadableState | 'empty';

interface DeathmarchData {
  clubsTotal: number;
  barsTotal: number;
  userClubsVisited: number;
  userBarsVisited: number;
}

export interface UseProfileKernelDataResult {
  deathmarch: {
    data: DeathmarchData;
    state: LoadableState;
    error: string | null;
    retry: () => void;
  };
  echo: {
    reviews: UserReviewHistoryItem[];
    page: number;
    totalPages: number;
    totalCount: number;
    hasPreviousPage: boolean;
    hasNextPage: boolean;
    state: EchoState;
    error: string | null;
    setPage: (nextPage: number) => void;
    goToPreviousPage: () => void;
    goToNextPage: () => void;
    retry: () => void;
  };
}

const DEFAULT_DEATHMARCH_DATA: DeathmarchData = {
  clubsTotal: 0,
  barsTotal: 0,
  userClubsVisited: 0,
  userBarsVisited: 0,
};

export const useProfileKernelData = ({
  userId,
  pageSize = 3,
}: UseProfileKernelDataOptions): UseProfileKernelDataResult => {
  const [deathmarchData, setDeathmarchData] = useState<DeathmarchData>(DEFAULT_DEATHMARCH_DATA);
  const [deathmarchState, setDeathmarchState] = useState<LoadableState>('loading');
  const [deathmarchError, setDeathmarchError] = useState<string | null>(null);

  const [echoReviews, setEchoReviews] = useState<UserReviewHistoryItem[]>([]);
  const [echoPage, setEchoPage] = useState<number>(1);
  const [echoTotalPages, setEchoTotalPages] = useState<number>(0);
  const [echoTotalCount, setEchoTotalCount] = useState<number>(0);
  const [echoState, setEchoState] = useState<EchoState>('loading');
  const [echoError, setEchoError] = useState<string | null>(null);

  const loadDeathmarchData = useCallback(async () => {
    setDeathmarchState('loading');
    setDeathmarchError(null);
    try {
      const [clubsTotal, barsTotal, userClubsVisited, userBarsVisited] = await Promise.all([
        clubsService.getTotalCount(),
        barsService.getTotalCount(),
        userId ? reviewsService.getUserClubsVisited(userId) : Promise.resolve(0),
        userId ? reviewsService.getUserBarsVisited(userId) : Promise.resolve(0),
      ]);

      setDeathmarchData({
        clubsTotal,
        barsTotal,
        userClubsVisited,
        userBarsVisited,
      });
      setDeathmarchState('ready');
    } catch (error) {
      console.error('Failed to load profile stats:', error);
      setDeathmarchError('Failed to load Deathmarch stats.');
      setDeathmarchState('error');
    }
  }, [userId]);

  const loadEchoHistory = useCallback(
    async (page: number) => {
      if (!userId) {
        setEchoReviews([]);
        setEchoTotalPages(0);
        setEchoTotalCount(0);
        setEchoState('empty');
        setEchoError(null);
        return;
      }

      setEchoState('loading');
      setEchoError(null);

      try {
        const history = await reviewsService.getUserReviewHistory(userId, page, pageSize);
        setEchoReviews(history.reviews);
        setEchoTotalPages(history.totalPages);
        setEchoTotalCount(history.totalCount);
        setEchoState(history.reviews.length > 0 ? 'ready' : 'empty');
      } catch (error) {
        console.error('Failed to load review history:', error);
        setEchoError('Failed to load Echo history.');
        setEchoState('error');
      }
    },
    [pageSize, userId]
  );

  useEffect(() => {
    void loadDeathmarchData();
  }, [loadDeathmarchData]);

  useEffect(() => {
    if (!userId) {
      setEchoPage(1);
      void loadEchoHistory(1);
      return;
    }

    setEchoPage(1);
    void loadEchoHistory(1);
  }, [loadEchoHistory, userId]);

  const setPage = useCallback(
    (nextPage: number) => {
      if (echoTotalPages === 0) return;
      const clampedPage = Math.min(Math.max(nextPage, 1), echoTotalPages);
      if (clampedPage === echoPage) return;
      setEchoPage(clampedPage);
      void loadEchoHistory(clampedPage);
    },
    [echoPage, echoTotalPages, loadEchoHistory]
  );

  const goToPreviousPage = useCallback(() => {
    setPage(echoPage - 1);
  }, [echoPage, setPage]);

  const goToNextPage = useCallback(() => {
    setPage(echoPage + 1);
  }, [echoPage, setPage]);

  const retryEcho = useCallback(() => {
    void loadEchoHistory(echoPage);
  }, [echoPage, loadEchoHistory]);

  return {
    deathmarch: {
      data: deathmarchData,
      state: deathmarchState,
      error: deathmarchError,
      retry: () => {
        void loadDeathmarchData();
      },
    },
    echo: {
      reviews: echoReviews,
      page: echoPage,
      totalPages: echoTotalPages,
      totalCount: echoTotalCount,
      hasPreviousPage: echoPage > 1,
      hasNextPage: echoPage < echoTotalPages,
      state: echoState,
      error: echoError,
      setPage,
      goToPreviousPage,
      goToNextPage,
      retry: retryEcho,
    },
  };
};
