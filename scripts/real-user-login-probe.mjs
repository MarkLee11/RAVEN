import { chromium } from 'playwright';

const target = process.env.PROBE_URL || 'https://raven-berlin1.netlify.app/profile';
const browser = await chromium.launch({ headless: true });
const page = await (await browser.newContext({
  viewport: { width: 390, height: 844 },
})).newPage();

const authCalls = [];
page.on('response', async (res) => {
  if (res.url().includes('/auth/v1/')) {
    authCalls.push({
      status: res.status(),
      url: res.url(),
      body: (await res.text().catch(() => '')).slice(0, 300),
    });
  }
});

await page.goto(`${target}?t=${Date.now()}`, { waitUntil: 'networkidle', timeout: 60000 });
await page.getByPlaceholder('your@email.com').fill('existing.user@gmail.com');
await page.getByPlaceholder('••••••••').fill('WrongPass123!');
await page.locator('form').getByRole('button', { name: 'Login' }).click();
await page.waitForTimeout(4000);

const uiError = await page.locator('.text-blood').first().textContent().catch(() => null);
const clubRes = await page.goto('https://raven-berlin1.netlify.app/clubs', { waitUntil: 'networkidle' });
await page.waitForTimeout(1500);
const firstVenue = await page.locator('h3, h2, .font-space').nth(1).textContent().catch(() => null);
const detailButton = page.getByRole('button', { name: /Last Words Echohall|Final Sip/i }).first();
if (await detailButton.count()) {
  await detailButton.click();
  await page.waitForTimeout(2500);
}

console.log(JSON.stringify({
  loginUiError: uiError,
  authCalls,
  clubsStatus: clubRes?.status() ?? null,
  firstVenue,
  detailUrl: page.url(),
  detailSnippet: (await page.locator('body').innerText()).slice(0, 500),
}, null, 2));

await browser.close();
