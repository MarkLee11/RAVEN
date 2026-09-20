import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '../contexts/useAuth';

interface RequireAuthProps {
  children: React.ReactElement;
}

const RequireAuth: React.FC<RequireAuthProps> = ({ children }) => {
  const location = useLocation();
  const { user, loading } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen bg-berlin-black flex items-center justify-center">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!user) {
    return (
      <Navigate
        to="/profile"
        replace
        state={{
          returnTo: `${location.pathname}${location.search}`,
          returnState: location.state ?? null,
        }}
      />
    );
  }

  return children;
};

export default RequireAuth;
