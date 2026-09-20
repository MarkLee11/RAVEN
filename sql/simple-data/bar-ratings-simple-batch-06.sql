-- RAVEN项目 - 酒吧评分数据 (批次 6) - 简化版
-- 生成时间: 2025-08-23T06:03:07.424Z

-- 为100个随机酒吧插入评分
WITH selected_bars AS (
  SELECT id, ROW_NUMBER() OVER (ORDER BY RANDOM()) as rn
  FROM public.bars
  LIMIT 100
)
INSERT INTO public.bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
SELECT 
  id,
  (50 + (RANDOM() * 50))::integer,
  (50 + (RANDOM() * 50))::integer,
  (50 + (RANDOM() * 50))::integer,
  (50 + (RANDOM() * 50))::integer
FROM selected_bars
ON CONFLICT (bar_id) DO UPDATE SET
  quality_rating = EXCLUDED.quality_rating,
  price_rating = EXCLUDED.price_rating,
  vibe_rating = EXCLUDED.vibe_rating,
  friendliness_rating = EXCLUDED.friendliness_rating,
  updated_at = NOW();
