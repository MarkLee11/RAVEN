-- 扩展 themes 表以支持bars的新分类系统
-- 添加category字段来区分不同类型的主题

-- 首先检查themes表是否已有category字段，如果没有则添加
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'themes' AND column_name = 'category'
    ) THEN
        ALTER TABLE public.themes ADD COLUMN category TEXT;
    END IF;
END $$;

-- 插入bars专用的theme数据
INSERT INTO public.themes (name, category) VALUES 
-- Drinks 分类
('cocktails', 'drinks'), 
('beer', 'drinks'), 
('wine', 'drinks'), 
('shots', 'drinks'),
('whisky', 'drinks'), 
('rum', 'drinks'), 
('gin', 'drinks'), 
('vodka', 'drinks'),
('tequila', 'drinks'), 
('mocktails', 'drinks'),

-- Style 分类
('upscale', 'style'), 
('classic', 'style'), 
('historic', 'style'), 
('industrial', 'style'),
('minimalist', 'style'), 
('alternative', 'style'), 
('speakeasy', 'style'), 
('art-bar', 'style'),

-- Architecture 分类
('outdoor', 'architecture'), 
('rooftop', 'architecture'), 
('stage', 'architecture'),
('smoking-area', 'architecture'), 
('private-rooms', 'architecture'),

-- Vibe 分类
('straight-bar', 'vibe'), 
('gay-bar', 'vibe'), 
('lesbian-bar', 'vibe'), 
('queer-bar', 'vibe'),
('lgbtq-friendly', 'vibe'), 
('chill', 'vibe'), 
('classy', 'vibe'), 
('lively', 'vibe'),
('crowded', 'vibe'), 
('cozy', 'vibe'), 
('romantic', 'vibe'), 
('wild', 'vibe'),
('underground', 'vibe'), 
('artsy', 'vibe'), 
('intimate', 'vibe'), 
('touristy', 'vibe'), 
('local', 'vibe'),

-- Music 分类
('jazz', 'music'), 
('blues', 'music'), 
('funk', 'music'), 
('soul', 'music'),
('disco', 'music'), 
('pop', 'music'), 
('indie', 'music'), 
('rock', 'music'),
('electronic', 'music'), 
('latin', 'music'), 
('live-music', 'music')

ON CONFLICT (name) DO NOTHING; -- 避免重复插入

-- 为category字段添加索引
CREATE INDEX IF NOT EXISTS idx_themes_category ON public.themes(category);

-- 添加注释
COMMENT ON COLUMN public.themes.category IS '主题分类：drinks, style, architecture, vibe, music';

-- 创建视图方便按分类查询themes (带RLS安全设置)
CREATE OR REPLACE VIEW public.themes_by_category 
WITH (security_invoker = true) AS
SELECT 
    category,
    array_agg(name ORDER BY name) as theme_names,
    array_agg(id ORDER BY name) as theme_ids
FROM public.themes 
WHERE category IS NOT NULL
GROUP BY category
ORDER BY category;

-- 添加视图注释
COMMENT ON VIEW public.themes_by_category IS '主题分类视图 - 继承themes表的RLS策略';