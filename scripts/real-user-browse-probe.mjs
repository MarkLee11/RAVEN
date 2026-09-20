import { chromium } from 'playwright';

const origin = process.env.PROBE_ORIGIN || 'https://raven-berlin1.netlify.app';
const browser = await chromium.launch({ headless: true });
const page = await (await browser.newContext({
  viewport: { width: 390, height: 844 },
})).newPage();

const requests = [];
page.on('requestfailed', (req) => {
  requests.push({ type: 'failed', url: req.url(), failure: req.failure()?.errorText });
});
page.on('response', (res) => {
  if (res.url().includes('supabase.co')) {
    requests.push({ type: 'response', status: res.status(), url: res.url() });
  }
});

await page.goto(`${origin}/clubs?t=${Date.now()}`, { waitUntil: 'networkidle', timeout: 60000 });
await page.waitForTimeout(2500);
const clubsText = await page.locator('body').innerText();

await page.goto(`${origin}/bars?t=${Date.now()}`, { waitUntil: 'networkidle', timeout: 60000 });
await page.waitForTimeout(2500);
const barsText = await page.locator('body').innerText();

console.log(JSON.stringify({
  clubsHasCrackBellmer: clubsText.includes('Crack Bellmer') || /berghain|kitkat|sisyphos|about blank/i.test(clubsText),
  clubsSnippet: clubsText.slice(0, 800),
  barsSnippet: barsText.slice(0, 800),
  requests,
}, null, 2));

await browser.close();
