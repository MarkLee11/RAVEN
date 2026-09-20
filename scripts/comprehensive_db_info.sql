-- 获取数据库表信息的综合查询脚本
-- 用于生成酒吧和夜店模拟数据

-- 1. 查询所有districts表的数据
SELECT 'DISTRICTS_DATA' as query_type;
SELECT id, name FROM districts ORDER BY id;

-- 2. 查询所有themes表的数据
SELECT 'THEMES_DATA' as query_type;
SELECT id, name, category FROM themes ORDER BY category, id;

-- 3. 查询clubs表的结构信息
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

-- 4. 查询clubs表的现有数据样本（前5条）
SELECT 'CLUBS_SAMPLE_DATA' as query_type;
SELECT * FROM clubs LIMIT 5;

-- 5. 查询bars表的结构信息
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

-- 6. 查询bars表的现有数据样本（前5条）
SELECT 'BARS_SAMPLE_DATA' as query_type;
SELECT * FROM bars LIMIT 5;

-- 7. 查询club_ratings表结构
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

-- 8. 查询club_themes表结构
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

-- 9. 查询club_locations表结构
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

-- 10. 查询bar_ratings表结构
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

-- 11. 查询bar_themes表结构
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

-- 12. 查询bar_locations表结构
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

-- 13. 查询现有club_ratings样本数据
SELECT 'CLUB_RATINGS_SAMPLE_DATA' as query_type;
SELECT * FROM club_ratings LIMIT 3;

-- 14. 查询现有bar_ratings样本数据
SELECT 'BAR_RATINGS_SAMPLE_DATA' as query_type;
SELECT * FROM bar_ratings LIMIT 3;

-- 15. 查询现有club_themes样本数据
SELECT 'CLUB_THEMES_SAMPLE_DATA' as query_type;
SELECT * FROM club_themes LIMIT 5;

-- 16. 查询现有bar_themes样本数据
SELECT 'BAR_THEMES_SAMPLE_DATA' as query_type;
SELECT * FROM bar_themes LIMIT 5;

-- 17. 查询现有club_locations样本数据
SELECT 'CLUB_LOCATIONS_SAMPLE_DATA' as query_type;
SELECT * FROM club_locations LIMIT 3;

-- 18. 查询现有bar_locations样本数据
SELECT 'BAR_LOCATIONS_SAMPLE_DATA' as query_type;
SELECT * FROM bar_locations LIMIT 3;

-- 19. 统计现有数据量
SELECT 'DATA_COUNTS' as query_type;
SELECT 
    'clubs' as table_name, COUNT(*) as record_count FROM clubs
UNION ALL
SELECT 
    'bars' as table_name, COUNT(*) as record_count FROM bars
UNION ALL
SELECT 
    'districts' as table_name, COUNT(*) as record_count FROM districts
UNION ALL
SELECT 
    'themes' as table_name, COUNT(*) as record_count FROM themes;