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
  const hasRetryAction =
    primaryAction?.label === 'Try Again' || secondaryAction?.label === 'Try Again';
  const messageRole = hasRetryAction ? 'alert' : 'status';
  const messageAriaLive = hasRetryAction ? 'assertive' : 'polite';

  return (
    <div className="min-h-screen bg-berlin-black flex items-center justify-center px-4">
      <div className="text-center">
        {loading ? (
          <div role="status" aria-live="polite" aria-busy="true" aria-atomic="true">
            <div className="w-6 h-6 border-2 border-raven border-t-transparent rounded-full animate-spin mx-auto" />
            {loadingLabel && <p className="text-ash mt-2">{loadingLabel}</p>}
          </div>
        ) : (
          <div role={messageRole} aria-live={messageAriaLive} aria-atomic="true">
            {message && <p className="text-ash mb-4">{message}</p>}
            {(primaryAction || secondaryAction) && (
              <div className="flex justify-center gap-3">
                {primaryAction && (
                  <Button
                    onClick={primaryAction.onClick}
                    variant={primaryAction.variant}
                    className="min-h-11 px-4"
                  >
                    {primaryAction.label}
                  </Button>
                )}
                {secondaryAction && (
                  <Button
                    onClick={secondaryAction.onClick}
                    variant={secondaryAction.variant}
                    className="min-h-11 px-4"
                  >
                    {secondaryAction.label}
                  </Button>
                )}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default PageStateView;
