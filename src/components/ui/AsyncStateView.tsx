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
      <div
        className="text-center py-12"
        role="status"
        aria-live="polite"
        aria-busy="true"
        aria-atomic="true"
      >
        <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
        <p className="text-ash mt-2">{loadingText}</p>
      </div>
    );
  }

  if (errorMessage) {
    return (
      <div
        className="text-center py-12"
        role="alert"
        aria-live="assertive"
        aria-atomic="true"
      >
        <p className="text-blood mb-4">{errorMessage}</p>
        <button
          onClick={onRetry}
          className="inline-flex min-h-11 items-center justify-center px-4 py-2 text-raven hover:text-ink transition-colors"
        >
          {retryLabel}
        </button>
      </div>
    );
  }

  if (empty) {
    return (
      <div className="text-center py-12" role="status" aria-live="polite" aria-atomic="true">
        <p className="text-ash">{emptyText}</p>
      </div>
    );
  }

  return null;
};

export default AsyncStateView;
