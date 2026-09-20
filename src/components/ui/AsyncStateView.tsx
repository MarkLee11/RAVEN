import React from 'react';

interface AsyncStateViewProps {
  loading?: boolean;
  errorMessage?: string | null;
  empty?: boolean;
  loadingText: string;
  emptyText: string;
  onRetry: () => void;
  retryLabel?: string;
}

const AsyncStateView: React.FC<AsyncStateViewProps> = ({
  loading = false,
  errorMessage = null,
  empty = false,
  loadingText,
  emptyText,
  onRetry,
  retryLabel = 'Try Again',
}) => {
  if (loading) {
    return (
      <div className="text-center py-12">
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
        <p className="text-ash mt-2">{loadingText}</p>
      </div>
    );
  }

  if (errorMessage) {
    return (
      <div className="text-center py-12">
        <p className="text-blood mb-4">{errorMessage}</p>
        <button
          onClick={onRetry}
          className="text-raven hover:text-ink transition-colors"
        >
          {retryLabel}
        </button>
      </div>
    );
  }

  if (empty) {
    return (
      <div className="text-center py-12">
        <p className="text-ash">{emptyText}</p>
      </div>
    );
  }

  return null;
};

export default AsyncStateView;
