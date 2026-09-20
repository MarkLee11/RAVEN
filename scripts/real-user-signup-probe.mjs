import { chromium } from 'playwright';
import { writeFileSync } from 'node:fs';

const target = process.env.PROBE_URL || 'https://raven-berlin1.netlify.app/profile';
const email = process.env.PROBE_EMAIL || `raven.e2e.${Date.now()}@gmail.com`;
const password = process.env.PROBE_PASSWORD || 'Pass1234!';

const browser = await chromium.launch({ headless: true });
const context = await browser.newContext({
  viewport: { width: 390, height: 844 },
  userAgent:
    'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
});
const page = await context.newPage();

const requests = [];
page.on('request', (req) => {
  if (/supabase|auth|signup|profile/i.test(req.url())) {
    requests.push({
      type: 'request',
      method: req.method(),
      url: req.url(),
      resourceType: req.resourceType(),
    });
  }
});
page.on('response', async (res) => {
  if (/supabase|auth|signup/i.test(res.url())) {
    let body = '';
    try {
      body = (await res.text()).slice(0, 800);
    } catch {
      body = '<unreadable>';
    }
    requests.push({
      type: 'response',
      status: res.status(),
      url: res.url(),
      headers: {
        'access-control-allow-origin': res.headers()['access-control-allow-origin'] || null,
        'content-type': res.headers()['content-type'] || null,
      },
      body,
    });
  }
});
page.on('requestfailed', (req) => {
  requests.push({
    type: 'failed',
    method: req.method(),
    url: req.url(),
    failure: req.failure()?.errorText || 'unknown',
    resourceType: req.resourceType(),
  });
});

const consoleLogs = [];
page.on('console', (msg) => {
  consoleLogs.push({ type: msg.type(), text: msg.text() });
});
page.on('pageerror', (err) => {
  consoleLogs.push({ type: 'pageerror', text: err.message });
});

await page.goto(target, { waitUntil: 'networkidle', timeout: 60000 });

const signupTab = page.getByRole('button', { name: 'Sign Up' }).first();
await signupTab.click();

const emailInput = page.getByPlaceholder('your@email.com');
const passwordInput = page.getByPlaceholder('••••••••');
await emailInput.fill(email);
await passwordInput.fill(password);

const submit = page.locator('form').getByRole('button', { name: 'Sign Up' });
await submit.click();

await page.waitForTimeout(4000);

const uiError = await page.locator('.bg-blood\\/10, .text-blood').first().textContent().catch(() => null);
const pageText = await page.locator('body').innerText();
const bakedUrls = await page.evaluate(() => {
  const html = document.documentElement.outerHTML;
  const scripts = [...document.querySelectorAll('script[src]')].map((s) => s.getAttribute('src'));
  return { scripts, htmlHasPlaceholder: html.includes('placeholder.supabase.co') };
});

const result = {
  target,
  email,
  uiError,
  pageSnippet: pageText.slice(0, 1500),
  bakedUrls,
  requests,
  consoleLogs,
};

writeFileSync('scripts/real-user-signup-probe-result.json', JSON.stringify(result, null, 2));
console.log(JSON.stringify(result, null, 2));

await browser.close();
