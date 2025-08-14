-- 创建 bar_ratings 表 (Version 2.0)
-- 新的评分维度：quality, price, vibe, friendliness

CREATE TABLE public.bar_ratings (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    
    -- 新的评分维度 (0-100分制)
    quality_rating INTEGER NOT NULL DEFAULT 0 CHECK (quality_rating >= 0 AND quality_rating <= 100),
    price_rating INTEGER NOT NULL DEFAULT 0 CHECK (price_rating >= 0 AND price_rating <= 100),
    vibe_rating INTEGER NOT NULL DEFAULT 0 CHECK (vibe_rating >= 0 AND vibe_rating <= 100),
    friendliness_rating INTEGER NOT NULL DEFAULT 0 CHECK (friendliness_rating >= 0 AND friendliness_rating <= 100),
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- 确保每个bar只有一条评分记录
    CONSTRAINT unique_bar_rating UNIQUE (bar_id)
);

-- 启用行级安全性
ALTER TABLE public.bar_ratings ENABLE ROW LEVEL SECURITY;

-- 添加公共读取权限
CREATE POLICY "Allow public read access on bar_ratings" ON public.bar_ratings
    FOR SELECT USING (true);

-- 添加索引
CREATE INDEX idx_bar_ratings_bar_id ON public.bar_ratings(bar_id);

-- 添加注释
COMMENT ON TABLE public.bar_ratings IS '酒吧默认评分表 - 新评分维度';
COMMENT ON COLUMN public.bar_ratings.bar_id IS '关联的酒吧ID';
COMMENT ON COLUMN public.bar_ratings.quality_rating IS '饮品/服务质量评分 (0-100分)';
COMMENT ON COLUMN public.bar_ratings.price_rating IS '价格水平评分/性价比 (0-100分)';
COMMENT ON COLUMN public.bar_ratings.vibe_rating IS '氛围/装潢评分 (0-100分)';
COMMENT ON COLUMN public.bar_ratings.friendliness_rating IS '友善度评分 (0-100分)';