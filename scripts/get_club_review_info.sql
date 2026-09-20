-- 获取生成club评价数据所需的数据库信息
-- 请在Supabase控制台或数据库客户端中执行这些查询

-- 1. 获取club_reviews表的完整结构
SELECT 'CLUB_REVIEWS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'club_reviews' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 2. 检查club_reviews表是否存在
SELECT 'CLUB_REVIEWS_TABLE_EXISTS' as query_type;
SELECT EXISTS (
    SELECT 1 
    FROM information_schema.tables 
    WHERE table_name = 'club_reviews' 
    AND table_schema = 'public'
) as table_exists;

-- 3. 获取所有现有clubs的id和name列表
SELECT 'CLUBS_LIST' as query_type;
SELECT id, name FROM clubs ORDER BY id;

-- 4. 检查auth.users表是否存在并获取结构
SELECT 'AUTH_USERS_TABLE_EXISTS' as query_type;
SELECT EXISTS (
    SELECT 1 
    FROM information_schema.tables 
    WHERE table_name = 'users' 
    AND table_schema = 'auth'
) as auth_users_exists;

-- 5. 获取auth.users表的结构（如果存在）
SELECT 'AUTH_USERS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'users' 
AND table_schema = 'auth'
ORDER BY ordinal_position;

-- 6. 获取auth.users表中的用户id列表（前20个）
SELECT 'AUTH_USERS_SAMPLE' as query_type;
SELECT id, email, created_at FROM auth.users ORDER BY created_at LIMIT 20;

-- 7. 检查public.users表是否存在
SELECT 'PUBLIC_USERS_TABLE_EXISTS' as query_type;
SELECT EXISTS (
    SELECT 1 
    FROM information_schema.tables 
    WHERE table_name = 'users' 
    AND table_schema = 'public'
) as public_users_exists;

-- 8. 获取public.users表的结构（如果存在）
SELECT 'PUBLIC_USERS_TABLE_STRUCTURE' as query_type;
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'users' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- 9. 获取现有club_reviews表中的样本数据（如果有的话）
SELECT 'CLUB_REVIEWS_SAMPLE_DATA' as query_type;
SELECT * FROM club_reviews LIMIT 5;

-- 10. 获取所有相关表的列表
SELECT 'RELATED_TABLES' as query_type;
SELECT table_name, table_schema
FROM information_schema.tables 
WHERE table_schema IN ('public', 'auth')
AND table_name LIKE '%user%' OR table_name LIKE '%club%' OR table_name LIKE '%review%'
ORDER BY table_schema, table_name;

-- 11. 检查是否有其他评价相关的表
SELECT 'REVIEW_TABLES' as query_type;
SELECT table_name, table_schema
FROM information_schema.tables 
WHERE table_schema = 'public'
AND table_name LIKE '%review%'
ORDER BY table_name;

-- 12. 获取clubs表的总数量
SELECT 'CLUBS_COUNT' as query_type;
SELECT COUNT(*) as total_clubs FROM clubs;

-- 13. 获取用户总数量（从auth.users）
SELECT 'USERS_COUNT' as query_type;
SELECT COUNT(*) as total_users FROM auth.users;