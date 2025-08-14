-- 修复视图的RLS权限问题
-- 视图默认不受RLS限制，但应该继承基础表的RLS策略

-- 1. 删除现有的不受限制的视图
DROP VIEW IF EXISTS public.themes_by_category;
DROP VIEW IF EXISTS public.bar_themes_detailed;

-- 2. 重新创建视图，确保它们受到RLS限制
-- 创建themes_by_category视图，继承themes表的RLS
CREATE VIEW public.themes_by_category 
WITH (security_invoker = true) AS
SELECT 
    category,
    array_agg(name ORDER BY name) as theme_names,
    array_agg(id ORDER BY name) as theme_ids
FROM public.themes 
WHERE category IS NOT NULL
GROUP BY category
ORDER BY category;

-- 创建bar_themes_detailed视图，继承相关表的RLS
CREATE VIEW public.bar_themes_detailed 
WITH (security_invoker = true) AS
SELECT 
    bt.bar_id,
    b.name as bar_name,
    bt.theme_id,
    t.name as theme_name,
    t.category as theme_category
FROM public.bar_themes bt
JOIN public.bars b ON bt.bar_id = b.id
JOIN public.themes t ON bt.theme_id = t.id;

-- 3. 为视图添加RLS策略
ALTER VIEW public.themes_by_category SET (security_invoker = true);
ALTER VIEW public.bar_themes_detailed SET (security_invoker = true);

-- 4. 添加注释说明安全设置
COMMENT ON VIEW public.themes_by_category IS '主题分类视图 - 继承themes表的RLS策略';
COMMENT ON VIEW public.bar_themes_detailed IS '酒吧主题详情视图 - 继承相关表的RLS策略';

-- 验证RLS状态
-- 这些视图现在应该受到基础表的RLS限制