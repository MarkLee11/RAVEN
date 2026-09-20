-- Fix RLS policies for club-related tables
-- Only add policies that don't already exist

-- Add RLS policy for themes table (if not exists)
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'themes' 
        AND policyname = 'Allow anonymous read access to themes'
    ) THEN
        CREATE POLICY "Allow anonymous read access to themes" ON "public"."themes"
        AS PERMISSIVE FOR SELECT
        TO anon
        USING (true);
    END IF;
END $$;

-- Add RLS policy for club_tonight_vibe table (if not exists)
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'club_tonight_vibe' 
        AND policyname = 'Allow anonymous read access to club_tonight_vibe'
    ) THEN
        CREATE POLICY "Allow anonymous read access to club_tonight_vibe" ON "public"."club_tonight_vibe"
        AS PERMISSIVE FOR SELECT
        TO anon
        USING (true);
    END IF;
END $$;

-- Add RLS policy for club_reviews table (if not exists)
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'club_reviews' 
        AND policyname = 'Allow anonymous read access to club_reviews'
    ) THEN
        CREATE POLICY "Allow anonymous read access to club_reviews" ON "public"."club_reviews"
        AS PERMISSIVE FOR SELECT
        TO anon
        USING (true);
    END IF;
END $$;