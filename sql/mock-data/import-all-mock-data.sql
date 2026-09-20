-- RAVEN项目 - 一键导入所有模拟数据脚本
-- 生成时间: 2025-08-23T05:36:34.551Z
-- 总数据量: 1000个酒吧 + 1000条评分 + 1000条评论

-- 开始事务
BEGIN;

-- 导入酒吧基础数据和主题关联
\i sql/mock-data/bars-mock-data.sql

-- 导入评分数据（10个批次）
\i sql/mock-data/bar-ratings-batch-01.sql
\i sql/mock-data/bar-ratings-batch-02.sql
\i sql/mock-data/bar-ratings-batch-03.sql
\i sql/mock-data/bar-ratings-batch-04.sql
\i sql/mock-data/bar-ratings-batch-05.sql
\i sql/mock-data/bar-ratings-batch-06.sql
\i sql/mock-data/bar-ratings-batch-07.sql
\i sql/mock-data/bar-ratings-batch-08.sql
\i sql/mock-data/bar-ratings-batch-09.sql
\i sql/mock-data/bar-ratings-batch-10.sql

-- 导入评论数据（10个批次）
\i sql/mock-data/bar-reviews-batch-01.sql
\i sql/mock-data/bar-reviews-batch-02.sql
\i sql/mock-data/bar-reviews-batch-03.sql
\i sql/mock-data/bar-reviews-batch-04.sql
\i sql/mock-data/bar-reviews-batch-05.sql
\i sql/mock-data/bar-reviews-batch-06.sql
\i sql/mock-data/bar-reviews-batch-07.sql
\i sql/mock-data/bar-reviews-batch-08.sql
\i sql/mock-data/bar-reviews-batch-09.sql
\i sql/mock-data/bar-reviews-batch-10.sql

-- 提交事务
COMMIT;

-- 数据完整性检查
DO $$
DECLARE
    bars_count INTEGER;
    ratings_count INTEGER;
    reviews_count INTEGER;
    themes_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO bars_count FROM public.bars WHERE id BETWEEN 1 AND 1000;
    SELECT COUNT(*) INTO ratings_count FROM public.bar_ratings WHERE bar_id BETWEEN 1 AND 1000;
    SELECT COUNT(*) INTO reviews_count FROM public.bar_reviews WHERE bar_id BETWEEN 1 AND 1000;
    SELECT COUNT(*) INTO themes_count FROM public.bar_themes WHERE bar_id BETWEEN 1 AND 1000;
    
    RAISE NOTICE '数据导入完成统计:';
    RAISE NOTICE '酒吧数量: %', bars_count;
    RAISE NOTICE '评分记录: %', ratings_count;
    RAISE NOTICE '评论记录: %', reviews_count;
    RAISE NOTICE '主题关联: %', themes_count;
    
    IF bars_count = 1000 AND ratings_count = 1000 AND reviews_count = 1000 THEN
        RAISE NOTICE '✅ 所有数据导入成功！';
    ELSE
        RAISE WARNING '⚠️  数据导入可能不完整，请检查！';
    END IF;
END $$;

-- 评分分布统计
SELECT 
    '评分统计' as category,
    ROUND(AVG(quality_rating), 2) as avg_quality,
    ROUND(AVG(price_rating), 2) as avg_price,
    ROUND(AVG(vibe_rating), 2) as avg_vibe,
    ROUND(AVG(friendliness_rating), 2) as avg_friendliness
FROM public.bar_ratings WHERE bar_id BETWEEN 1 AND 1000;

-- 地区分布统计
SELECT 
    d.name as district,
    COUNT(*) as bar_count
FROM public.bars b
JOIN public.districts d ON b.district_id = d.id
WHERE b.id BETWEEN 1 AND 1000
GROUP BY d.name
ORDER BY bar_count DESC;

-- 主题分布统计（前10名）
SELECT 
    t.name as theme,
    t.category,
    COUNT(*) as usage_count
FROM public.bar_themes bt
JOIN public.themes t ON bt.theme_id = t.id
WHERE bt.bar_id BETWEEN 1 AND 1000
GROUP BY t.name, t.category
ORDER BY usage_count DESC
LIMIT 10;

