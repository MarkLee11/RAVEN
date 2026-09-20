import React from 'react';
import { describe, expect, it, vi, beforeEach } from 'vitest';
import { MemoryRouter, Route, Routes, useLocation } from 'react-router-dom';
import { render, screen } from '@testing-library/react';
import RequireAuth from './RequireAuth';
import { useAuth } from '../contexts/useAuth';

vi.mock('../contexts/useAuth', () => ({
  useAuth: vi.fn(),
}));

const useAuthMock = vi.mocked(useAuth);

const ProfileProbe: React.FC = () => {
  const location = useLocation();
  return (
    <div>
      <div data-testid="profile-path">{location.pathname}</div>
      <pre data-testid="profile-state">{JSON.stringify(location.state)}</pre>
    </div>
  );
};

describe('RequireAuth', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('renders children for authenticated users', () => {
    useAuthMock.mockReturnValue({
      user: { id: 'user-1' } as never,
      session: null,
      loading: false,
    });

    render(
      <MemoryRouter initialEntries={['/favorites/bars']}>
        <Routes>
          <Route
            path="/favorites/bars"
            element={
              <RequireAuth>
                <div>Protected Favorites</div>
              </RequireAuth>
            }
          />
          <Route path="/profile" element={<ProfileProbe />} />
        </Routes>
      </MemoryRouter>
    );

    expect(screen.getByText('Protected Favorites')).toBeInTheDocument();
  });

  it('redirects unauthenticated user to profile with return state', () => {
    useAuthMock.mockReturnValue({
      user: null,
      session: null,
      loading: false,
    });

    render(
      <MemoryRouter initialEntries={[{ pathname: '/favorites/bars', search: '?tab=all', state: { from: 'guard' } }]}>
        <Routes>
          <Route
            path="/favorites/bars"
            element={
              <RequireAuth>
                <div>Protected Favorites</div>
              </RequireAuth>
            }
          />
          <Route path="/profile" element={<ProfileProbe />} />
        </Routes>
      </MemoryRouter>
    );

    expect(screen.getByTestId('profile-path')).toHaveTextContent('/profile');
    expect(screen.getByTestId('profile-state')).toHaveTextContent('/favorites/bars?tab=all');
    expect(screen.getByTestId('profile-state')).toHaveTextContent('"from":"guard"');
  });

  it('shows loading state while auth is checking', () => {
    useAuthMock.mockReturnValue({
      user: null,
      session: null,
      loading: true,
    });

    const { container } = render(
      <MemoryRouter initialEntries={['/favorites/bars']}>
        <Routes>
          <Route
            path="/favorites/bars"
            element={
              <RequireAuth>
                <div>Protected Favorites</div>
              </RequireAuth>
            }
          />
          <Route path="/profile" element={<ProfileProbe />} />
        </Routes>
      </MemoryRouter>
    );

    expect(screen.queryByText('Protected Favorites')).not.toBeInTheDocument();
    expect(screen.queryByTestId('profile-path')).not.toBeInTheDocument();
    expect(container.querySelector('.animate-spin')).toBeInTheDocument();
  });
});
