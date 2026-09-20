-- RAVEN项目 - 安全插入准备SQL脚本
-- 为批量导入添加冲突处理，确保插入操作的安全性

-- ==============================================
-- 1. 检查当前酒吧ID范围，为生成匹配数据做准备
-- ==============================================

-- 获取现有酒吧的ID范围信息
SELECT 
    'Current Bar Analysis' as analysis_type,
    MIN(id) as min_id,
    MAX(id) as max_id,
    COUNT(*) as total_count,
    CASE 
        WHEN MAX(id) - MIN(id) + 1 = COUNT(*) THEN '连续ID'
        ELSE '非连续ID'
    END as id_pattern
FROM public.bars;

-- 找出ID范围1-1000中已存在的酒吧
SELECT 
    'Existing Bars in Range 1-1000' as info,
    COUNT(*) as existing_count,
    ARRAY_AGG(id ORDER BY id) as existing_ids
FROM public.bars 
WHERE id BETWEEN 1 AND 1000;

-- ==============================================
-- 2. 创建临时ID映射表（如果需要）
-- ==============================================

-- 创建临时表存储ID映射关系
DROP TABLE IF EXISTS temp_bar_id_mapping;

CREATE TEMP TABLE temp_bar_id_mapping (
    mock_id INTEGER,      -- 模拟数据中的ID (1-1000)
    real_id INTEGER,      -- 实际酒吧的ID
    bar_name TEXT         -- 酒吧名称（用于验证）
);

-- 生成ID映射（将模拟ID映射到实际存在的酒吧ID）
-- 方案1: 如果你有足够的酒吧数据，随机映射到现有酒吧
INSERT INTO temp_bar_id_mapping (mock_id, real_id, bar_name)
SELECT 
    ROW_NUMBER() OVER (ORDER BY RANDOM()) as mock_id,
    id as real_id,
    name as bar_name
FROM public.bars
ORDER BY RANDOM()
LIMIT 1000;

-- 显示映射结果
SELECT 
    'ID Mapping Created' as status,
    COUNT(*) as mapped_count,
    MIN(mock_id) as min_mock_id,
    MAX(mock_id) as max_mock_id,
    MIN(real_id) as min_real_id,
    MAX(real_id) as max_real_id
FROM temp_bar_id_mapping;

-- ==============================================
-- 3. 备份现有数据（可选但推荐）
-- ==============================================

-- 备份现有评分数据
DROP TABLE IF EXISTS backup_bar_ratings;
CREATE TABLE backup_bar_ratings AS 
SELECT * FROM public.bar_ratings;

-- 备份现有评论数据  
DROP TABLE IF EXISTS backup_bar_reviews;
CREATE TABLE backup_bar_reviews AS 
SELECT * FROM public.bar_reviews;

-- 备份现有主题关联数据
DROP TABLE IF EXISTS backup_bar_themes;
CREATE TABLE backup_bar_themes AS 
SELECT * FROM public.bar_themes;

-- 显示备份状态
SELECT 
    'Backup Status' as info,
    (SELECT COUNT(*) FROM backup_bar_ratings) as backed_up_ratings,
    (SELECT COUNT(*) FROM backup_bar_reviews) as backed_up_reviews,
    (SELECT COUNT(*) FROM backup_bar_themes) as backed_up_themes;

-- ==============================================
-- 4. 创建安全插入函数
-- ==============================================

-- 创建安全插入评分的函数
CREATE OR REPLACE FUNCTION safe_insert_bar_rating(
    p_bar_id INTEGER,
    p_quality_rating INTEGER,
    p_price_rating INTEGER,
    p_vibe_rating INTEGER,
    p_friendliness_rating INTEGER
) RETURNS BOOLEAN AS $$
DECLARE
    existing_count INTEGER;
BEGIN
    -- 检查酒吧是否存在
    SELECT COUNT(*) INTO existing_count
    FROM public.bars WHERE id = p_bar_id;
    
    IF existing_count = 0 THEN
        RAISE NOTICE 'Bar ID % does not exist, skipping rating insert', p_bar_id;
        RETURN FALSE;
    END IF;
    
    -- 使用ON CONFLICT处理重复
    INSERT INTO public.bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (p_bar_id, p_quality_rating, p_price_rating, p_vibe_rating, p_friendliness_rating)
    ON CONFLICT (bar_id) DO UPDATE SET
        quality_rating = EXCLUDED.quality_rating,
        price_rating = EXCLUDED.price_rating,
        vibe_rating = EXCLUDED.vibe_rating,
        friendliness_rating = EXCLUDED.friendliness_rating,
        updated_at = NOW();
        
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- 创建安全插入评论的函数
CREATE OR REPLACE FUNCTION safe_insert_bar_review(
    p_bar_id INTEGER,
    p_user_id TEXT,
    p_quality_rating INTEGER,
    p_price_rating INTEGER,
    p_vibe_rating INTEGER,
    p_friendliness_rating INTEGER,
    p_review_text TEXT,
    p_queue_time INTEGER,
    p_is_anonymous BOOLEAN,
    p_created_at TIMESTAMPTZ
) RETURNS BOOLEAN AS $$
DECLARE
    existing_count INTEGER;
BEGIN
    -- 检查酒吧是否存在
    SELECT COUNT(*) INTO existing_count
    FROM public.bars WHERE id = p_bar_id;
    
    IF existing_count = 0 THEN
        RAISE NOTICE 'Bar ID % does not exist, skipping review insert', p_bar_id;
        RETURN FALSE;
    END IF;
    
    -- 插入评论（评论表通常允许重复，但我们可以添加去重逻辑）
    INSERT INTO public.bar_reviews (
        bar_id, user_id, quality_rating, price_rating, vibe_rating, 
        friendliness_rating, review_text, queue_time, is_anonymous, created_at
    )
    VALUES (
        p_bar_id, p_user_id, p_quality_rating, p_price_rating, p_vibe_rating,
        p_friendliness_rating, p_review_text, p_queue_time, p_is_anonymous, p_created_at
    );
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- ==============================================
-- 5. 显示准备完成状态
-- ==============================================

DO $$
BEGIN
    RAISE NOTICE '==============================================';
    RAISE NOTICE '安全插入准备完成！';
    RAISE NOTICE '==============================================';
    RAISE NOTICE '已创建:';
    RAISE NOTICE '- ID映射表 (temp_bar_id_mapping)';
    RAISE NOTICE '- 数据备份表 (backup_*)';
    RAISE NOTICE '- 安全插入函数';
    RAISE NOTICE '==============================================';
    RAISE NOTICE '建议的插入顺序:';
    RAISE NOTICE '1. 先执行 cleanup-conflicts.sql 清理冲突';
    RAISE NOTICE '2. 再执行评分数据批次文件';
    RAISE NOTICE '3. 最后执行评论数据批次文件';
    RAISE NOTICE '==============================================';
END $$;

-- 显示当前状态摘要
SELECT 
    'Preparation Summary' as summary,
    (SELECT COUNT(*) FROM public.bars) as total_bars,
    (SELECT COUNT(*) FROM temp_bar_id_mapping) as mapped_ids,
    (SELECT COUNT(*) FROM backup_bar_ratings) as backed_up_ratings,
    (SELECT COUNT(*) FROM backup_bar_reviews) as backed_up_reviews;
