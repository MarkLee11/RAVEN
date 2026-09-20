import React from 'react';
import Button from './Button';

interface PageStateAction {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'ghost' | 'danger';
}

interface PageStateViewProps {
  loading?: boolean;
  loadingLabel?: string;
  message?: string;
  primaryAction?: PageStateAction;
  secondaryAction?: PageStateAction;
}

const PageStateView: React.FC<PageStateViewProps> = ({
  loading = false,
  loadingLabel,
  message,
  primaryAction,
  secondaryAction,
}) => {
  return (
    <div className="min-h-screen bg-berlin-black flex items-center justify-center px-4">
      <div className="text-center">
        {loading ? (
          <>
            <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
            {loadingLabel && <p className="text-ash mt-2">{loadingLabel}</p>}
          </>
        ) : (
          <>
            {message && <p className="text-ash mb-4">{message}</p>}
            {(primaryAction || secondaryAction) && (
              <div className="flex justify-center gap-3">
                {primaryAction && (
                  <Button onClick={primaryAction.onClick} variant={primaryAction.variant}>
                    {primaryAction.label}
                  </Button>
                )}
                {secondaryAction && (
                  <Button onClick={secondaryAction.onClick} variant={secondaryAction.variant}>
                    {secondaryAction.label}
                  </Button>
                )}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
};

export default PageStateView;
