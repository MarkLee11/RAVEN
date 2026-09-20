import { test, expect } from '@playwright/test';

test.describe('Auth guard protected routes', () => {
  test('redirects /submit to /profile when unauthenticated', async ({ page }) => {
    await page.goto('/submit');
    await expect(page).toHaveURL(/\/profile$/);
    await expect(page.getByRole('heading', { name: /welcome to raven/i })).toBeVisible();
  });

  test('redirects /favorites/bars to /profile when unauthenticated', async ({ page }) => {
    await page.goto('/favorites/bars');
    await expect(page).toHaveURL(/\/profile$/);
  });

  test('redirects /favorites/clubs to /profile when unauthenticated', async ({ page }) => {
    await page.goto('/favorites/clubs');
    await expect(page).toHaveURL(/\/profile$/);
  });
});
