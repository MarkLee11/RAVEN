-- Check existing RLS policies for related tables
SELECT schemaname, tablename, policyname, roles, cmd 
FROM pg_policies 
WHERE tablename IN ('club_ratings', 'club_themes', 'themes', 'club_tonight_vibe', 'club_reviews') 
ORDER BY tablename, policyname;