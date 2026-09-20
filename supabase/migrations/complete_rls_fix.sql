-- Complete RLS fix for all tables to allow anonymous read access
-- This migration ensures all venue-related tables have proper anonymous access policies

-- Grant anonymous read access to districts table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'districts' 
        AND policyname = 'Allow anonymous read access to districts'
    ) THEN
        CREATE POLICY "Allow anonymous read access to districts" ON public.districts
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.districts TO anon;

-- Grant anonymous read access to clubs table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'clubs' 
        AND policyname = 'Allow anonymous read access to clubs'
    ) THEN
        CREATE POLICY "Allow anonymous read access to clubs" ON public.clubs
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.clubs TO anon;

-- Grant anonymous read access to themes table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'themes' 
        AND policyname = 'Allow anonymous read access to themes'
    ) THEN
        CREATE POLICY "Allow anonymous read access to themes" ON public.themes
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.themes TO anon;

-- Grant anonymous read access to club_themes table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'club_themes' 
        AND policyname = 'Allow anonymous read access to club_themes'
    ) THEN
        CREATE POLICY "Allow anonymous read access to club_themes" ON public.club_themes
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.club_themes TO anon;

-- Grant anonymous read access to club_ratings table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'club_ratings' 
        AND policyname = 'Allow anonymous read access to club_ratings'
    ) THEN
        CREATE POLICY "Allow anonymous read access to club_ratings" ON public.club_ratings
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.club_ratings TO anon;

-- Grant anonymous read access to club_reviews table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'club_reviews' 
        AND policyname = 'Allow anonymous read access to club_reviews'
    ) THEN
        CREATE POLICY "Allow anonymous read access to club_reviews" ON public.club_reviews
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.club_reviews TO anon;

-- Grant anonymous read access to club_tonight_vibe table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'club_tonight_vibe' 
        AND policyname = 'Allow anonymous read access to club_tonight_vibe'
    ) THEN
        CREATE POLICY "Allow anonymous read access to club_tonight_vibe" ON public.club_tonight_vibe
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.club_tonight_vibe TO anon;

-- Grant anonymous read access to bars table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'bars' 
        AND policyname = 'Allow anonymous read access to bars'
    ) THEN
        CREATE POLICY "Allow anonymous read access to bars" ON public.bars
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.bars TO anon;

-- Grant anonymous read access to bar_ratings table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'bar_ratings' 
        AND policyname = 'Allow anonymous read access to bar_ratings'
    ) THEN
        CREATE POLICY "Allow anonymous read access to bar_ratings" ON public.bar_ratings
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.bar_ratings TO anon;

-- Grant anonymous read access to bar_reviews table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'bar_reviews' 
        AND policyname = 'Allow anonymous read access to bar_reviews'
    ) THEN
        CREATE POLICY "Allow anonymous read access to bar_reviews" ON public.bar_reviews
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.bar_reviews TO anon;

-- Grant anonymous read access to bar_themes table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'bar_themes' 
        AND policyname = 'Allow anonymous read access to bar_themes'
    ) THEN
        CREATE POLICY "Allow anonymous read access to bar_themes" ON public.bar_themes
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.bar_themes TO anon;

-- Grant anonymous read access to bar_locations table
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'bar_locations' 
        AND policyname = 'Allow anonymous read access to bar_locations'
    ) THEN
        CREATE POLICY "Allow anonymous read access to bar_locations" ON public.bar_locations
            FOR SELECT USING (true);
    END IF;
END $$;

GRANT SELECT ON public.bar_locations TO anon;