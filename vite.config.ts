import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  const supabaseUrl = env.VITE_SUPABASE_URL || '';
  const supabaseAnonKey = env.VITE_SUPABASE_ANON_KEY || '';
  const missingProductionEnv =
    !supabaseUrl ||
    !supabaseAnonKey ||
    supabaseUrl.includes('placeholder.supabase.co') ||
    supabaseAnonKey === 'placeholder-anon-key';

  if (mode === 'production' && missingProductionEnv) {
    throw new Error(
      'Production build blocked: VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY must be real values, not placeholders.'
    );
  }

  return {
    plugins: [react()],
    optimizeDeps: {
      exclude: ['lucide-react'],
    },
  };
});
