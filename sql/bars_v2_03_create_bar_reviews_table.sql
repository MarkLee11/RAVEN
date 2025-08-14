-- 创建 bar_reviews 表 (Version 2.0)
-- 用户评论表，使用新的评分维度

CREATE TABLE public.bar_reviews (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    
    -- 新的评分维度 (0-100分制)
    quality_rating INTEGER NOT NULL CHECK (quality_rating >= 0 AND quality_rating <= 100),
    price_rating INTEGER NOT NULL CHECK (price_rating >= 0 AND price_rating <= 100),
    vibe_rating INTEGER NOT NULL CHECK (vibe_rating >= 0 AND vibe_rating <= 100),
    friendliness_rating INTEGER NOT NULL CHECK (friendliness_rating >= 0 AND friendliness_rating <= 100),
    
    -- 评论内容
    review_text TEXT,
    queue_time INTEGER CHECK (queue_time >= 0),
    is_anonymous BOOLEAN NOT NULL DEFAULT true,
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 启用行级安全性
ALTER TABLE public.bar_reviews ENABLE ROW LEVEL SECURITY;

-- 添加公共读取权限
CREATE POLICY "Allow public read access on bar_reviews" ON public.bar_reviews
    FOR SELECT USING (true);

-- 添加插入权限（用户可以创建评论）
CREATE POLICY "Allow authenticated users to insert bar_reviews" ON public.bar_reviews
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- 添加索引
CREATE INDEX idx_bar_reviews_bar_id ON public.bar_reviews(bar_id);
CREATE INDEX idx_bar_reviews_created_at ON public.bar_reviews(created_at DESC);
CREATE INDEX idx_bar_reviews_user_id ON public.bar_reviews(user_id);

-- 添加注释
COMMENT ON TABLE public.bar_reviews IS '酒吧用户评论表 - 新评分维度';
COMMENT ON COLUMN public.bar_reviews.bar_id IS '关联的酒吧ID';
COMMENT ON COLUMN public.bar_reviews.user_id IS '评论用户ID，允许为空（匿名）';
COMMENT ON COLUMN public.bar_reviews.quality_rating IS '饮品/服务质量评分 (0-100分)';
COMMENT ON COLUMN public.bar_reviews.price_rating IS '价格水平评分/性价比 (0-100分)';
COMMENT ON COLUMN public.bar_reviews.vibe_rating IS '氛围/装潢评分 (0-100分)';
COMMENT ON COLUMN public.bar_reviews.friendliness_rating IS '友善度评分 (0-100分)';
COMMENT ON COLUMN public.bar_reviews.review_text IS '评论文字内容';
COMMENT ON COLUMN public.bar_reviews.queue_time IS '排队时间（分钟）';
COMMENT ON COLUMN public.bar_reviews.is_anonymous IS '是否匿名评论';