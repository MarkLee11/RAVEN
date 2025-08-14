-- Create favorites tables for both bars and clubs
-- Handle all possible conflicts and existing objects

-- First drop all existing policies
DROP POLICY IF EXISTS "Users can view their own bar favorites" ON public.bar_favorites;
DROP POLICY IF EXISTS "Users can view their own club favorites" ON public.club_favorites;
DROP POLICY IF EXISTS "Users can add bar favorites" ON public.bar_favorites;
DROP POLICY IF EXISTS "Users can add club favorites" ON public.club_favorites;
DROP POLICY IF EXISTS "Users can delete their own bar favorites" ON public.bar_favorites;
DROP POLICY IF EXISTS "Users can delete their own club favorites" ON public.club_favorites;

-- Drop existing indexes
DROP INDEX IF EXISTS public.idx_bar_favorites_user_id;
DROP INDEX IF EXISTS public.idx_bar_favorites_bar_id;
DROP INDEX IF EXISTS public.idx_club_favorites_user_id;
DROP INDEX IF EXISTS public.idx_club_favorites_club_id;

-- Drop any existing conflicting objects
DROP TABLE IF EXISTS public.user_favorite_bars CASCADE;
DROP TABLE IF EXISTS public.user_favorite_clubs CASCADE;
DROP VIEW IF EXISTS public.user_favorite_bars CASCADE;
DROP VIEW IF EXISTS public.user_favorite_clubs CASCADE;
DROP VIEW IF EXISTS public.user_favorites CASCADE;

-- Disable RLS temporarily if tables exist
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'bar_favorites' AND table_schema = 'public') THEN
        ALTER TABLE public.bar_favorites DISABLE ROW LEVEL SECURITY;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'club_favorites' AND table_schema = 'public') THEN
        ALTER TABLE public.club_favorites DISABLE ROW LEVEL SECURITY;
    END IF;
END $$;

-- Create the favorites tables if they don't exist
CREATE TABLE IF NOT EXISTS public.bar_favorites (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.club_favorites (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    club_id BIGINT NOT NULL REFERENCES public.clubs(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Add unique constraints if they don't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'bar_favorites_user_id_bar_id_key' 
        AND table_name = 'bar_favorites'
    ) THEN
        ALTER TABLE public.bar_favorites ADD CONSTRAINT bar_favorites_user_id_bar_id_key UNIQUE(user_id, bar_id);
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'club_favorites_user_id_club_id_key' 
        AND table_name = 'club_favorites'
    ) THEN
        ALTER TABLE public.club_favorites ADD CONSTRAINT club_favorites_user_id_club_id_key UNIQUE(user_id, club_id);
    END IF;
END $$;

-- Enable RLS
ALTER TABLE public.bar_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.club_favorites ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can view their own bar favorites"
    ON public.bar_favorites
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can view their own club favorites"
    ON public.club_favorites
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can add bar favorites"
    ON public.bar_favorites
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can add club favorites"
    ON public.club_favorites
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own bar favorites"
    ON public.bar_favorites
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own club favorites"
    ON public.club_favorites
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_bar_favorites_user_id ON public.bar_favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_bar_favorites_bar_id ON public.bar_favorites(bar_id);
CREATE INDEX IF NOT EXISTS idx_club_favorites_user_id ON public.club_favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_club_favorites_club_id ON public.club_favorites(club_id);

-- Add comments
COMMENT ON TABLE public.bar_favorites IS 'User favorites for bars';
COMMENT ON TABLE public.club_favorites IS 'User favorites for clubs';