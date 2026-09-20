-- RAVEN项目 - 真实数据一键导入脚本
-- 生成时间: 2025-08-23T06:00:20.225Z
-- 总记录数: 1000条评分 + 1000条评论
-- 使用现有的bars和auth.users数据

-- 开始事务
BEGIN;

-- 导入评分数据 (1000条)
\i sql/real-data/bar-ratings-real-batch-01.sql
\i sql/real-data/bar-ratings-real-batch-02.sql
\i sql/real-data/bar-ratings-real-batch-03.sql
\i sql/real-data/bar-ratings-real-batch-04.sql
\i sql/real-data/bar-ratings-real-batch-05.sql
\i sql/real-data/bar-ratings-real-batch-06.sql
\i sql/real-data/bar-ratings-real-batch-07.sql
\i sql/real-data/bar-ratings-real-batch-08.sql
\i sql/real-data/bar-ratings-real-batch-09.sql
\i sql/real-data/bar-ratings-real-batch-10.sql

-- 导入评论数据 (1000条)
\i sql/real-data/bar-reviews-real-batch-01.sql
\i sql/real-data/bar-reviews-real-batch-02.sql
\i sql/real-data/bar-reviews-real-batch-03.sql
\i sql/real-data/bar-reviews-real-batch-04.sql
\i sql/real-data/bar-reviews-real-batch-05.sql
\i sql/real-data/bar-reviews-real-batch-06.sql
\i sql/real-data/bar-reviews-real-batch-07.sql
\i sql/real-data/bar-reviews-real-batch-08.sql
\i sql/real-data/bar-reviews-real-batch-09.sql
\i sql/real-data/bar-reviews-real-batch-10.sql

-- 提交事务
COMMIT;

-- 验证结果
SELECT 'Ratings imported' as status, COUNT(*) as count FROM public.bar_ratings;
SELECT 'Reviews imported' as status, COUNT(*) as count FROM public.bar_reviews;
