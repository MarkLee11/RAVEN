-- RAVEN项目 - BARS功能数据库表创建脚本 (Version 2.0)
-- 重新设计的bars表结构，基于新的分类系统和评分维度
-- 执行顺序：按依赖关系排序

-- 1. 创建 bars 主表（精简版）
CREATE TABLE public.bars (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    district_id BIGINT REFERENCES public.districts(id),
    description TEXT,
    
    -- Payment方式（boolean字段）
    cash_only BOOLEAN NOT NULL DEFAULT false,
    card_accepted BOOLEAN NOT NULL DEFAULT false,
    
    -- 基础信息
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. 扩展themes表以支持bars的分类系统
-- 添加category字段（如果不存在）
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'themes' AND column_name = 'category'
    ) THEN
        ALTER TABLE public.themes ADD COLUMN category TEXT;
    END IF;
END $$;

-- 插入bars专用themes
INSERT INTO public.themes (name, category) VALUES 
-- Drinks
('cocktails', 'drinks'), ('beer', 'drinks'), ('wine', 'drinks'), ('shots', 'drinks'),
('whisky', 'drinks'), ('rum', 'drinks'), ('gin', 'drinks'), ('vodka', 'drinks'),
('tequila', 'drinks'), ('mocktails', 'drinks'),
-- Style
('upscale', 'style'), ('classic', 'style'), ('historic', 'style'), ('industrial', 'style'),
('minimalist', 'style'), ('alternative', 'style'), ('speakeasy', 'style'), ('art-bar', 'style'),
-- Architecture
('outdoor', 'architecture'), ('rooftop', 'architecture'), ('stage', 'architecture'),
('smoking-area', 'architecture'), ('private-rooms', 'architecture'),
-- Vibe
('straight-bar', 'vibe'), ('gay-bar', 'vibe'), ('lesbian-bar', 'vibe'), ('queer-bar', 'vibe'),
('lgbtq-friendly', 'vibe'), ('chill', 'vibe'), ('classy', 'vibe'), ('lively', 'vibe'),
('crowded', 'vibe'), ('cozy', 'vibe'), ('romantic', 'vibe'), ('wild', 'vibe'),
('underground', 'vibe'), ('artsy', 'vibe'), ('intimate', 'vibe'), ('touristy', 'vibe'), ('local', 'vibe'),
-- Music
('jazz', 'music'), ('blues', 'music'), ('funk', 'music'), ('soul', 'music'),
('disco', 'music'), ('pop', 'music'), ('indie', 'music'), ('rock', 'music'),
('electronic', 'music'), ('latin', 'music'), ('live-music', 'music')
ON CONFLICT (name) DO NOTHING;

-- 3. 创建 bar_ratings 表（新评分维度，0-100分制）
CREATE TABLE public.bar_ratings (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    quality_rating INTEGER NOT NULL DEFAULT 0 CHECK (quality_rating >= 0 AND quality_rating <= 100),
    price_rating INTEGER NOT NULL DEFAULT 0 CHECK (price_rating >= 0 AND price_rating <= 100),
    vibe_rating INTEGER NOT NULL DEFAULT 0 CHECK (vibe_rating >= 0 AND vibe_rating <= 100),
    friendliness_rating INTEGER NOT NULL DEFAULT 0 CHECK (friendliness_rating >= 0 AND friendliness_rating <= 100),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_bar_rating UNIQUE (bar_id)
);

-- 4. 创建 bar_reviews 表（新评分维度，0-100分制）
CREATE TABLE public.bar_reviews (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    quality_rating INTEGER NOT NULL CHECK (quality_rating >= 0 AND quality_rating <= 100),
    price_rating INTEGER NOT NULL CHECK (price_rating >= 0 AND price_rating <= 100),
    vibe_rating INTEGER NOT NULL CHECK (vibe_rating >= 0 AND vibe_rating <= 100),
    friendliness_rating INTEGER NOT NULL CHECK (friendliness_rating >= 0 AND friendliness_rating <= 100),
    review_text TEXT,
    queue_time INTEGER CHECK (queue_time >= 0),
    is_anonymous BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. 创建 bar_themes 表
CREATE TABLE public.bar_themes (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    theme_id BIGINT NOT NULL REFERENCES public.themes(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_bar_theme UNIQUE (bar_id, theme_id)
);

-- 6. 创建 bar_locations 表
CREATE TABLE public.bar_locations (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    address_line TEXT NOT NULL,
    postal_code VARCHAR(10),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_bar_location UNIQUE (bar_id)
);

-- 启用行级安全性
ALTER TABLE public.bars ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bar_ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bar_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bar_themes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bar_locations ENABLE ROW LEVEL SECURITY;

-- 添加公共读取权限
CREATE POLICY "Allow public read access on bars" ON public.bars FOR SELECT USING (true);
CREATE POLICY "Allow public read access on bar_ratings" ON public.bar_ratings FOR SELECT USING (true);
CREATE POLICY "Allow public read access on bar_reviews" ON public.bar_reviews FOR SELECT USING (true);
CREATE POLICY "Allow public read access on bar_themes" ON public.bar_themes FOR SELECT USING (true);
CREATE POLICY "Allow public read access on bar_locations" ON public.bar_locations FOR SELECT USING (true);

-- 添加用户插入权限（评论表）
CREATE POLICY "Allow authenticated users to insert bar_reviews" ON public.bar_reviews
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- 创建索引
-- bars表索引
CREATE INDEX idx_bars_district_id ON public.bars(district_id);
CREATE INDEX idx_bars_payment ON public.bars(cash_only, card_accepted);
-- 简单的name索引，不使用gin_trgm_ops
CREATE INDEX idx_bars_name ON public.bars(name);

-- themes表索引
CREATE INDEX IF NOT EXISTS idx_themes_category ON public.themes(category);

-- bar_ratings表索引
CREATE INDEX idx_bar_ratings_bar_id ON public.bar_ratings(bar_id);

-- bar_reviews表索引
CREATE INDEX idx_bar_reviews_bar_id ON public.bar_reviews(bar_id);
CREATE INDEX idx_bar_reviews_created_at ON public.bar_reviews(created_at DESC);
CREATE INDEX idx_bar_reviews_user_id ON public.bar_reviews(user_id);

-- bar_themes表索引
CREATE INDEX idx_bar_themes_bar_id ON public.bar_themes(bar_id);
CREATE INDEX idx_bar_themes_theme_id ON public.bar_themes(theme_id);
CREATE INDEX idx_bar_themes_bar_theme ON public.bar_themes(bar_id, theme_id);

-- bar_locations表索引
CREATE INDEX idx_bar_locations_bar_id ON public.bar_locations(bar_id);
CREATE INDEX idx_bar_locations_coordinates ON public.bar_locations(latitude, longitude) 
    WHERE latitude IS NOT NULL AND longitude IS NOT NULL;

-- 创建便捷查询视图 (带RLS安全设置)
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

CREATE OR REPLACE VIEW public.bar_themes_detailed 
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

-- 添加视图注释
COMMENT ON VIEW public.themes_by_category IS '主题分类视图 - 继承themes表的RLS策略';
COMMENT ON VIEW public.bar_themes_detailed IS '酒吧主题详情视图 - 继承相关表的RLS策略';