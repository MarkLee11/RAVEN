import { describe, expect, it, vi } from 'vitest';
import { fireEvent, render, screen } from '@testing-library/react';
import AsyncStateView from './AsyncStateView';

describe('AsyncStateView accessibility semantics', () => {
  it('exposes loading with status semantics', () => {
    render(
      <AsyncStateView
        loading
        loadingText="Loading bars..."
        emptyText="No bars match your filters."
        onRetry={vi.fn()}
      />
    );

    const statusRegion = screen.getByRole('status');
    expect(statusRegion).toHaveAttribute('aria-live', 'polite');
    expect(statusRegion).toHaveAttribute('aria-busy', 'true');
    expect(screen.getByText('Loading bars...')).toBeInTheDocument();
  });

  it('exposes error as alert and allows retry', () => {
    const onRetry = vi.fn();

    render(
      <AsyncStateView
        errorMessage="Failed to load bars. Please try again."
        loadingText="Loading bars..."
        emptyText="No bars match your filters."
        onRetry={onRetry}
      />
    );

    const alertRegion = screen.getByRole('alert');
    expect(alertRegion).toHaveAttribute('aria-live', 'assertive');

    fireEvent.click(screen.getByRole('button', { name: 'Try Again' }));
    expect(onRetry).toHaveBeenCalledTimes(1);
  });
});
