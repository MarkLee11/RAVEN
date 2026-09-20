import React from 'react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { fireEvent, render, screen, waitFor, within } from '@testing-library/react';
import { MemoryRouter, Route, Routes, useLocation } from 'react-router-dom';
import Profile from './Profile';
import { useAuth } from '../contexts/useAuth';
import { supabase } from '../lib/supabase';
import { clubsService } from '../services/clubsService';
import { barsService } from '../services/barsService';
import { reviewsService } from '../services/reviewsService';

vi.mock('../contexts/useAuth', () => ({
  useAuth: vi.fn(),
}));

vi.mock('../lib/supabase', () => ({
  supabase: {
    auth: {
      signInWithPassword: vi.fn(),
      signUp: vi.fn(),
      signOut: vi.fn(),
    },
    from: vi.fn(),
  },
}));

vi.mock('../services/clubsService', () => ({
  clubsService: {
    getTotalCount: vi.fn(),
  },
}));

vi.mock('../services/barsService', () => ({
  barsService: {
    getTotalCount: vi.fn(),
  },
}));

vi.mock('../services/reviewsService', () => ({
  reviewsService: {
    getUserClubsVisited: vi.fn(),
    getUserBarsVisited: vi.fn(),
  },
}));

const useAuthMock = vi.mocked(useAuth);
const signInWithPasswordMock = vi.mocked(supabase.auth.signInWithPassword);
const signUpMock = vi.mocked(supabase.auth.signUp);
const getClubsCountMock = vi.mocked(clubsService.getTotalCount);
const getBarsCountMock = vi.mocked(barsService.getTotalCount);
const getUserClubsVisitedMock = vi.mocked(reviewsService.getUserClubsVisited);
const getUserBarsVisitedMock = vi.mocked(reviewsService.getUserBarsVisited);

const TargetProbe: React.FC = () => {
  const location = useLocation();
  return (
    <div>
      <div>Favorites Target</div>
      <pre data-testid="target-state">{JSON.stringify(location.state)}</pre>
    </div>
  );
};

describe('Profile login redirect flow', () => {
  beforeEach(() => {
    vi.clearAllMocks();

    useAuthMock.mockReturnValue({
      user: null,
      session: null,
      loading: false,
    });

    getClubsCountMock.mockResolvedValue(120);
    getBarsCountMock.mockResolvedValue(260);
    getUserClubsVisitedMock.mockResolvedValue(0);
    getUserBarsVisitedMock.mockResolvedValue(0);
  });

  it('redirects to returnTo route after successful login', async () => {
    signInWithPasswordMock.mockResolvedValue({
      data: { session: { access_token: 'token' }, user: { id: 'user-1' } },
      error: null,
    } as never);

    render(
      <MemoryRouter
        initialEntries={[
          {
            pathname: '/profile',
            state: {
              returnTo: '/favorites/bars',
              returnState: { source: 'guard' },
            },
          },
        ]}
      >
        <Routes>
          <Route path="/profile" element={<Profile />} />
          <Route path="/favorites/bars" element={<TargetProbe />} />
        </Routes>
      </MemoryRouter>
    );

    fireEvent.change(screen.getByPlaceholderText('your@email.com'), {
      target: { value: 'user@example.com' },
    });
    fireEvent.change(screen.getByPlaceholderText('••••••••'), {
      target: { value: 'pass1234' },
    });
    const submitButton = within(screen.getByPlaceholderText('••••••••').closest('form') as HTMLFormElement).getByRole(
      'button',
      { name: 'Enter' }
    );
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(screen.getByText('Favorites Target')).toBeInTheDocument();
    });

    expect(signInWithPasswordMock).toHaveBeenCalledWith({
      email: 'user@example.com',
      password: 'pass1234',
    });
    expect(screen.getByTestId('target-state')).toHaveTextContent('"source":"guard"');
  });

  it('submits signup with uppercase email without pattern blocking', async () => {
    signUpMock.mockResolvedValue({
      data: { session: null, user: { id: 'user-2' } },
      error: null,
    } as never);

    render(
      <MemoryRouter initialEntries={['/profile']}>
        <Routes>
          <Route path="/profile" element={<Profile />} />
        </Routes>
      </MemoryRouter>
    );

    fireEvent.click(screen.getAllByRole('button', { name: 'Enlist' })[0]);

    const emailInput = screen.getByPlaceholderText('your@email.com') as HTMLInputElement;
    const passwordInput = screen.getByPlaceholderText('••••••••') as HTMLInputElement;

    fireEvent.change(emailInput, {
      target: { value: 'User+test@Example.com' },
    });
    fireEvent.change(passwordInput, {
      target: { value: 'pass1234' },
    });

    expect(emailInput.checkValidity()).toBe(true);

    const submitButton = within(passwordInput.closest('form') as HTMLFormElement).getByRole('button', {
      name: 'Enlist',
    });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(signUpMock).toHaveBeenCalledWith({
        email: 'User+test@Example.com',
        password: 'pass1234',
      });
    });
  });
});
