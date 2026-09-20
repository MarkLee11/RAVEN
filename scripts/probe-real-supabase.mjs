import { readFileSync } from 'node:fs';

const envText = readFileSync(new URL('../.env', import.meta.url), 'utf8');
const env = Object.fromEntries(
  envText
    .split(/\r?\n/)
    .filter((line) => line && !line.startsWith('#') && line.includes('='))
    .map((line) => {
      const idx = line.indexOf('=');
      return [line.slice(0, idx).trim(), line.slice(idx + 1).trim()];
    })
);

const url = env.VITE_SUPABASE_URL;
const key = env.VITE_SUPABASE_ANON_KEY;

if (!url || !key || url.includes('placeholder')) {
  console.error('Local .env is missing a real Supabase URL/key.');
  process.exit(1);
}

const email = `raven.probe.${Date.now()}@gmail.com`;
const signupRes = await fetch(`${url}/auth/v1/signup`, {
  method: 'POST',
  headers: {
    apikey: key,
    Authorization: `Bearer ${key}`,
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ email, password: 'Pass1234!' }),
});

const clubsRes = await fetch(`${url}/rest/v1/clubs?select=id,name&limit=1`, {
  headers: {
    apikey: key,
    Authorization: `Bearer ${key}`,
  },
});

const signupBody = await signupRes.text();
const clubsBody = await clubsRes.text();

console.log(
  JSON.stringify(
    {
      supabaseHost: new URL(url).host,
      signupStatus: signupRes.status,
      signupOk: signupRes.ok,
      signupBody: signupBody.slice(0, 400),
      clubsStatus: clubsRes.status,
      clubsOk: clubsRes.ok,
      clubsBody: clubsBody.slice(0, 400),
    },
    null,
    2
  )
);
