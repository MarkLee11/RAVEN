import React from 'react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { fireEvent, render, screen } from '@testing-library/react';
import { MemoryRouter, Route, Routes, useLocation } from 'react-router-dom';
import SubmitReview from './SubmitReview';
import { useAuth } from '../contexts/useAuth';

vi.mock('../contexts/useAuth', () => ({
  useAuth: vi.fn(),
}));

const useAuthMock = vi.mocked(useAuth);

const LocationProbe: React.FC = () => {
  const location = useLocation();
  return (
    <div>
      <div data-testid="path">{location.pathname}</div>
      <pre data-testid="state">{JSON.stringify(location.state)}</pre>
    </div>
  );
};

describe('SubmitReview auth and venue guard flow', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('shows login required and redirects to profile with submit return state', () => {
    useAuthMock.mockReturnValue({
      user: null,
      session: null,
      loading: false,
    });

    render(
      <MemoryRouter
        initialEntries={[
          {
            pathname: '/submit',
            state: {
              venueId: 'club-1',
              venueName: 'Club One',
              venueType: 'club',
            },
          },
        ]}
      >
        <Routes>
          <Route path="/submit" element={<SubmitReview />} />
          <Route path="/profile" element={<LocationProbe />} />
        </Routes>
      </MemoryRouter>
    );

    expect(screen.getByText('Login Required')).toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Login / Sign Up' }));

    expect(screen.getByTestId('path')).toHaveTextContent('/profile');
    expect(screen.getByTestId('state')).toHaveTextContent('"returnTo":"/submit"');
    expect(screen.getByTestId('state')).toHaveTextContent('"venueId":"club-1"');
    expect(screen.getByTestId('state')).toHaveTextContent('"venueName":"Club One"');
    expect(screen.getByTestId('state')).toHaveTextContent('"venueType":"club"');
  });

  it('shows no venue state and can go back to venue list', () => {
    useAuthMock.mockReturnValue({
      user: null,
      session: null,
      loading: false,
    });

    render(
      <MemoryRouter initialEntries={[{ pathname: '/submit', state: { venueType: 'bar' } }]}>
        <Routes>
          <Route path="/submit" element={<SubmitReview />} />
          <Route path="/bars" element={<LocationProbe />} />
        </Routes>
      </MemoryRouter>
    );

    expect(screen.getByText('No venue selected')).toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Back to Bars' }));

    expect(screen.getByTestId('path')).toHaveTextContent('/bars');
  });
});
