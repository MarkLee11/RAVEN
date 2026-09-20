import { test, expect } from '@playwright/test';

test.describe('Browse smoke flows', () => {
  test('clubs page renders filters section', async ({ page }) => {
    await page.goto('/clubs');
    await expect(page.getByRole('button', { name: /filters/i })).toBeVisible();
  });

  test('bars page renders filters section', async ({ page }) => {
    await page.goto('/bars');
    await expect(page.getByRole('button', { name: /filters/i })).toBeVisible();
  });
});
