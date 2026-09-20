-- 获取数据库表信息的SQL查询脚本
-- 请在Supabase控制台或数据库客户端中执行这些查询

-- 1. 获取所有districts数据
SELECT 'DISTRICTS_DATA' as query_type;
SELECT * FROM districts ORDER BY id;

-- 2. 获取所有themes数据
SELECT 'THEMES_DATA' as query_type;
SELECT * FROM themes ORDER BY id;

-- 3. 获取clubs表结构信息
SELECT 'CLUBS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'clubs' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 4. 获取clubs表现有数据示例（前5条）
SELECT 'CLUBS_SAMPLE_DATA' as query_type;
SELECT * FROM clubs LIMIT 5;

-- 5. 获取bars表结构信息
SELECT 'BARS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'bars' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 6. 获取bars表现有数据示例（前5条）
SELECT 'BARS_SAMPLE_DATA' as query_type;
SELECT * FROM bars LIMIT 5;

-- 7. 获取club_ratings表结构
SELECT 'CLUB_RATINGS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'club_ratings' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 8. 获取bar_ratings表结构
SELECT 'BAR_RATINGS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'bar_ratings' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 9. 获取club_themes表结构
SELECT 'CLUB_THEMES_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'club_themes' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 10. 获取bar_themes表结构
SELECT 'BAR_THEMES_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'bar_themes' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 11. 获取club_locations表结构
SELECT 'CLUB_LOCATIONS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'club_locations' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 12. 获取bar_locations表结构
SELECT 'BAR_LOCATIONS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'bar_locations' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 13. 获取现有的club_themes关联数据示例
SELECT 'CLUB_THEMES_SAMPLE_DATA' as query_type;
SELECT * FROM club_themes LIMIT 10;

-- 14. 获取现有的bar_themes关联数据示例
SELECT 'BAR_THEMES_SAMPLE_DATA' as query_type;
SELECT * FROM bar_themes LIMIT 10;

-- 15. 获取现有的club_locations数据示例
SELECT 'CLUB_LOCATIONS_SAMPLE_DATA' as query_type;
SELECT * FROM club_locations LIMIT 5;

-- 16. 获取现有的bar_locations数据示例
SELECT 'BAR_LOCATIONS_SAMPLE_DATA' as query_type;
SELECT * FROM bar_locations LIMIT 5;

-- 17. 获取现有的club_ratings数据示例
SELECT 'CLUB_RATINGS_SAMPLE_DATA' as query_type;
SELECT * FROM club_ratings LIMIT 5;

-- 18. 获取现有的bar_ratings数据示例
SELECT 'BAR_RATINGS_SAMPLE_DATA' as query_type;
SELECT * FROM bar_ratings LIMIT 5;