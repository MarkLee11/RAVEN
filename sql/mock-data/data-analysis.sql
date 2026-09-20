-- RAVEN项目 - 模拟数据分析查询
-- 用于验证和分析导入的模拟数据质量

-- 基础数据统计
SELECT 
    '基础数据统计' as category,
    (SELECT COUNT(*) FROM public.bars WHERE id BETWEEN 1 AND 1000) as bars_count,
    (SELECT COUNT(*) FROM public.bar_ratings WHERE bar_id BETWEEN 1 AND 1000) as ratings_count,
    (SELECT COUNT(*) FROM public.bar_reviews WHERE bar_id BETWEEN 1 AND 1000) as reviews_count,
    (SELECT COUNT(*) FROM public.bar_themes WHERE bar_id BETWEEN 1 AND 1000) as themes_count;

-- 评分分布统计
SELECT 
    '评分统计' as category,
    ROUND(AVG(quality_rating), 2) as avg_quality,
    ROUND(AVG(price_rating), 2) as avg_price,
    ROUND(AVG(vibe_rating), 2) as avg_vibe,
    ROUND(AVG(friendliness_rating), 2) as avg_friendliness,
    ROUND(MIN(quality_rating), 0) as min_quality,
    ROUND(MAX(quality_rating), 0) as max_quality
FROM public.bar_ratings WHERE bar_id BETWEEN 1 AND 1000;

-- 地区分布统计
SELECT 
    '地区分布' as category,
    d.name as district,
    COUNT(*) as bar_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM public.bars b
JOIN public.districts d ON b.district_id = d.id
WHERE b.id BETWEEN 1 AND 1000
GROUP BY d.name
ORDER BY bar_count DESC;

-- 主题使用频率统计（按类别）
SELECT 
    '主题使用频率' as category,
    t.category,
    COUNT(*) as usage_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY t.category), 2) as category_percentage
FROM public.bar_themes bt
JOIN public.themes t ON bt.theme_id = t.id
WHERE bt.bar_id BETWEEN 1 AND 1000 AND t.category IS NOT NULL
GROUP BY t.category, t.name
ORDER BY t.category, usage_count DESC;

-- 支付方式分布
SELECT 
    '支付方式分布' as category,
    CASE 
        WHEN cash_only = true AND card_accepted = false THEN '仅现金'
        WHEN cash_only = false AND card_accepted = true THEN '仅刷卡'
        WHEN cash_only = true AND card_accepted = true THEN '现金+刷卡'
        WHEN cash_only = false AND card_accepted = false THEN '无支付信息'
    END as payment_type,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM public.bars
WHERE id BETWEEN 1 AND 1000
GROUP BY payment_type
ORDER BY count DESC;

-- 评论匿名度统计
SELECT 
    '评论统计' as category,
    is_anonymous,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM public.bar_reviews
WHERE bar_id BETWEEN 1 AND 1000
GROUP BY is_anonymous;

-- 排队时间统计
SELECT 
    '排队时间统计' as category,
    CASE 
        WHEN queue_time IS NULL THEN '无排队信息'
        WHEN queue_time = 0 THEN '无需排队'
        WHEN queue_time BETWEEN 1 AND 10 THEN '1-10分钟'
        WHEN queue_time BETWEEN 11 AND 20 THEN '11-20分钟'
        WHEN queue_time BETWEEN 21 AND 30 THEN '21-30分钟'
        WHEN queue_time > 30 THEN '30分钟以上'
    END as queue_range,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM public.bar_reviews
WHERE bar_id BETWEEN 1 AND 1000
GROUP BY queue_range
ORDER BY 
    CASE queue_range
        WHEN '无排队信息' THEN 1
        WHEN '无需排队' THEN 2
        WHEN '1-10分钟' THEN 3
        WHEN '11-20分钟' THEN 4
        WHEN '21-30分钟' THEN 5
        WHEN '30分钟以上' THEN 6
    END;

-- 评分与评论匹配度分析
WITH rating_categories AS (
    SELECT 
        bar_id,
        user_id,
        CASE 
            WHEN (quality_rating + price_rating + vibe_rating + friendliness_rating) / 4.0 >= 80 THEN '高分'
            WHEN (quality_rating + price_rating + vibe_rating + friendliness_rating) / 4.0 >= 60 THEN '中等'
            ELSE '低分'
        END as rating_category,
        review_text
    FROM public.bar_reviews
    WHERE bar_id BETWEEN 1 AND 1000
)
SELECT 
    '评分评论匹配度' as category,
    rating_category,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM rating_categories
GROUP BY rating_category
ORDER BY 
    CASE rating_category 
        WHEN '高分' THEN 1 
        WHEN '中等' THEN 2 
        WHEN '低分' THEN 3 
    END;

-- 最受欢迎的主题组合（前10名）
WITH theme_combinations AS (
    SELECT 
        bt.bar_id,
        STRING_AGG(t.name, ', ' ORDER BY t.name) as theme_combo
    FROM public.bar_themes bt
    JOIN public.themes t ON bt.theme_id = t.id
    WHERE bt.bar_id BETWEEN 1 AND 1000 AND t.category IS NOT NULL
    GROUP BY bt.bar_id
)
SELECT 
    '热门主题组合' as category,
    theme_combo,
    COUNT(*) as usage_count
FROM theme_combinations
GROUP BY theme_combo
ORDER BY usage_count DESC
LIMIT 10;

-- 按地区的平均评分
SELECT 
    '地区评分分析' as category,
    d.name as district,
    COUNT(DISTINCT br.bar_id) as bars_with_ratings,
    ROUND(AVG(br.quality_rating), 2) as avg_quality,
    ROUND(AVG(br.price_rating), 2) as avg_price,
    ROUND(AVG(br.vibe_rating), 2) as avg_vibe,
    ROUND(AVG(br.friendliness_rating), 2) as avg_friendliness
FROM public.bar_ratings br
JOIN public.bars b ON br.bar_id = b.id
JOIN public.districts d ON b.district_id = d.id
WHERE br.bar_id BETWEEN 1 AND 1000
GROUP BY d.name
ORDER BY avg_quality DESC;


