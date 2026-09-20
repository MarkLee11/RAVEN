import { test, expect } from '@playwright/test';

const mockUser = {
  id: 'user-echo-1',
  email: 'echo.tester@example.com',
  created_at: '2026-01-15T10:00:00.000Z',
  aud: 'authenticated',
  role: 'authenticated',
};

test.describe('Profile Echo pagination', () => {
  test('shows echo pagination and supports next/previous navigation', async ({ page }) => {
    await page.route('**/auth/v1/token*', async (route) => {
      const nowInSeconds = Math.floor(Date.now() / 1000);
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({
          access_token: 'fake-access-token',
          token_type: 'bearer',
          expires_in: 3600,
          expires_at: nowInSeconds + 3600,
          refresh_token: 'fake-refresh-token',
          user: mockUser,
        }),
      });
    });

    await page.route('**/auth/v1/user', async (route) => {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify(mockUser),
      });
    });

    await page.route('**/rest/v1/clubs*', async (route) => {
      const method = route.request().method();
      if (method === 'HEAD') {
        await route.fulfill({
          status: 200,
          headers: {
            'content-range': '0-0/12',
          },
        });
        return;
      }

      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify([]),
      });
    });

    await page.route('**/rest/v1/bars*', async (route) => {
      const method = route.request().method();
      if (method === 'HEAD') {
        await route.fulfill({
          status: 200,
          headers: {
            'content-range': '0-0/9',
          },
        });
        return;
      }

      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify([]),
      });
    });

    await page.route('**/rest/v1/club_reviews*', async (route) => {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify([{ club_id: 100 }, { club_id: 101 }, { club_id: 100 }]),
      });
    });

    await page.route('**/rest/v1/bar_reviews*', async (route) => {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify([{ bar_id: 200 }, { bar_id: 201 }]),
      });
    });

    await page.route('**/rest/v1/rpc/get_user_review_history_paginated', async (route) => {
      const payload = route.request().postDataJSON() as { p_page?: number; p_limit?: number } | null;
      const pageNumber = payload?.p_page ?? 1;
      const pageSize = payload?.p_limit ?? 3;

      if (pageNumber === 1) {
        await route.fulfill({
          status: 200,
          contentType: 'application/json',
          body: JSON.stringify([
            {
              review_id: 'r1',
              venue_id: 'v1',
              venue_name: 'Venue Alpha',
              venue_type: 'club',
              music_rating: 92,
              vibe_rating: 88,
              crowd_rating: 84,
              safety_rating: 90,
              review_text: 'First page comment alpha',
              queue_time: null,
              created_at: '2026-09-20T12:00:00.000Z',
              total_count: 4,
            },
            {
              review_id: 'r2',
              venue_id: 'v2',
              venue_name: 'Venue Beta',
              venue_type: 'bar',
              music_rating: 78,
              vibe_rating: 82,
              crowd_rating: 80,
              safety_rating: 76,
              review_text: 'First page comment beta',
              queue_time: 10,
              created_at: '2026-09-19T12:00:00.000Z',
              total_count: 4,
            },
            {
              review_id: 'r3',
              venue_id: 'v3',
              venue_name: 'Venue Gamma',
              venue_type: 'club',
              music_rating: 70,
              vibe_rating: 72,
              crowd_rating: 68,
              safety_rating: 74,
              review_text: 'First page comment gamma',
              queue_time: null,
              created_at: '2026-09-18T12:00:00.000Z',
              total_count: 4,
            },
          ].slice(0, pageSize)),
        });
        return;
      }

      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify([
          {
            review_id: 'r4',
            venue_id: 'v4',
            venue_name: 'Venue Delta',
            venue_type: 'bar',
            music_rating: 66,
            vibe_rating: 64,
            crowd_rating: 62,
            safety_rating: 68,
            review_text: 'Second page comment delta',
            queue_time: 5,
            created_at: '2026-09-17T12:00:00.000Z',
            total_count: 4,
          },
        ]),
      });
    });

    await page.goto('/profile');

    await page.locator('input[type="email"]').fill('echo.tester@example.com');
    await page.locator('input[type="password"]').fill('123456');
    await page.locator('form').getByRole('button', { name: 'Enter' }).click();

    await expect(page.getByRole('heading', { name: 'Echo' })).toBeVisible();
    await expect(page.getByText('Page 1 / 2 · 4 total')).toBeVisible();
    await expect(page.getByText('Venue Alpha')).toBeVisible();
    await expect(page.getByText('First page comment alpha')).toBeVisible();

    await page.getByRole('button', { name: 'Next' }).click();
    await expect(page.getByText('Page 2 / 2 · 4 total')).toBeVisible();
    await expect(page.getByText('Venue Delta')).toBeVisible();
    await expect(page.getByText('Second page comment delta')).toBeVisible();
    await expect(page.getByText('Venue Alpha')).not.toBeVisible();

    await page.getByRole('button', { name: 'Previous' }).click();
    await expect(page.getByText('Page 1 / 2 · 4 total')).toBeVisible();
    await expect(page.getByText('Venue Alpha')).toBeVisible();
  });
});
