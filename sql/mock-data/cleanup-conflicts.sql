-- RAVEN项目 - 清理数据冲突SQL脚本
-- 在批量导入模拟数据前执行，避免主键和唯一约束冲突
-- 生成时间: 2025-08-23

-- ==============================================
-- 1. 清理可能冲突的评分数据
-- ==============================================

-- 删除可能存在的模拟酒吧评分记录（bar_id 1-1000范围）
DELETE FROM public.bar_ratings 
WHERE bar_id BETWEEN 1 AND 1000;

-- 显示清理结果
SELECT 'bar_ratings清理完成' as status, COUNT(*) as remaining_records 
FROM public.bar_ratings;

-- ==============================================
-- 2. 清理可能冲突的评论数据  
-- ==============================================

-- 删除可能存在的模拟酒吧评论记录（bar_id 1-1000范围）
DELETE FROM public.bar_reviews 
WHERE bar_id BETWEEN 1 AND 1000;

-- 显示清理结果
SELECT 'bar_reviews清理完成' as status, COUNT(*) as remaining_records 
FROM public.bar_reviews;

-- ==============================================
-- 3. 清理可能冲突的酒吧主题关联
-- ==============================================

-- 删除可能存在的模拟酒吧主题关联（bar_id 1-1000范围）
DELETE FROM public.bar_themes 
WHERE bar_id BETWEEN 1 AND 1000;

-- 显示清理结果
SELECT 'bar_themes清理完成' as status, COUNT(*) as remaining_records 
FROM public.bar_themes;

-- ==============================================
-- 4. 清理可能冲突的酒吧位置信息
-- ==============================================

-- 删除可能存在的模拟酒吧位置记录（bar_id 1-1000范围）
DELETE FROM public.bar_locations 
WHERE bar_id BETWEEN 1 AND 1000;

-- 显示清理结果
SELECT 'bar_locations清理完成' as status, COUNT(*) as remaining_records 
FROM public.bar_locations;

-- ==============================================
-- 5. 清理可能冲突的酒吧基础数据（可选）
-- ==============================================

-- 如果需要清理模拟酒吧数据，取消注释下面的语句
-- 注意：这会删除ID在1-1000范围内的所有酒吧数据！

/*
DELETE FROM public.bars 
WHERE id BETWEEN 1 AND 1000;

SELECT 'bars清理完成' as status, COUNT(*) as remaining_records 
FROM public.bars;
*/

-- ==============================================
-- 6. 重置序列（如果需要）
-- ==============================================

-- 如果你想重置自增序列，确保新插入的数据从指定ID开始
-- 取消注释并调整起始值

/*
-- 重置bars表序列
SELECT setval('public.bars_id_seq', 1000, true);

-- 重置bar_ratings表序列  
SELECT setval('public.bar_ratings_id_seq', 1000, true);

-- 重置bar_reviews表序列
SELECT setval('public.bar_reviews_id_seq', 1000, true);

-- 重置bar_themes表序列
SELECT setval('public.bar_themes_id_seq', 1000, true);

-- 重置bar_locations表序列
SELECT setval('public.bar_locations_id_seq', 1000, true);
*/

-- ==============================================
-- 7. 数据完整性检查
-- ==============================================

-- 检查当前数据状态
SELECT 
    'Data Status Check' as check_type,
    (SELECT COUNT(*) FROM public.bars) as total_bars,
    (SELECT COUNT(*) FROM public.bar_ratings) as total_ratings,
    (SELECT COUNT(*) FROM public.bar_reviews) as total_reviews,
    (SELECT COUNT(*) FROM public.bar_themes) as total_themes,
    (SELECT COUNT(*) FROM public.bar_locations) as total_locations;

-- 检查现有酒吧ID范围
SELECT 
    'Current Bar ID Range' as info,
    MIN(id) as min_bar_id,
    MAX(id) as max_bar_id,
    COUNT(*) as total_bars
FROM public.bars
WHERE id IS NOT NULL;

-- 检查是否存在孤立的评分记录（没有对应酒吧的评分）
SELECT 
    'Orphaned Ratings Check' as check_type,
    COUNT(*) as orphaned_ratings_count
FROM public.bar_ratings br
LEFT JOIN public.bars b ON br.bar_id = b.id
WHERE b.id IS NULL;

-- 检查是否存在孤立的评论记录（没有对应酒吧的评论）
SELECT 
    'Orphaned Reviews Check' as check_type,
    COUNT(*) as orphaned_reviews_count
FROM public.bar_reviews br
LEFT JOIN public.bars b ON br.bar_id = b.id
WHERE b.id IS NULL;

-- 检查是否存在孤立的主题关联（没有对应酒吧的主题）
SELECT 
    'Orphaned Themes Check' as check_type,
    COUNT(*) as orphaned_themes_count
FROM public.bar_themes bt
LEFT JOIN public.bars b ON bt.bar_id = b.id
WHERE b.id IS NULL;

-- ==============================================
-- 8. 显示清理摘要
-- ==============================================

DO $$
BEGIN
    RAISE NOTICE '==============================================';
    RAISE NOTICE '数据清理完成！';
    RAISE NOTICE '==============================================';
    RAISE NOTICE '已清理ID范围1-1000的以下数据:';
    RAISE NOTICE '- bar_ratings (评分记录)';
    RAISE NOTICE '- bar_reviews (评论记录)';  
    RAISE NOTICE '- bar_themes (主题关联)';
    RAISE NOTICE '- bar_locations (位置信息)';
    RAISE NOTICE '==============================================';
    RAISE NOTICE '现在可以安全地导入新的模拟数据！';
    RAISE NOTICE '==============================================';
END $$;
