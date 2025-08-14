-- 创建 bar_themes 表 (Version 2.0)
-- 酒吧和主题标签的关联表

CREATE TABLE public.bar_themes (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    theme_id BIGINT NOT NULL REFERENCES public.themes(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- 确保同一个酒吧不会重复关联同一个主题
    CONSTRAINT unique_bar_theme UNIQUE (bar_id, theme_id)
);

-- 启用行级安全性
ALTER TABLE public.bar_themes ENABLE ROW LEVEL SECURITY;

-- 添加公共读取权限
CREATE POLICY "Allow public read access on bar_themes" ON public.bar_themes
    FOR SELECT USING (true);

-- 添加索引
CREATE INDEX idx_bar_themes_bar_id ON public.bar_themes(bar_id);
CREATE INDEX idx_bar_themes_theme_id ON public.bar_themes(theme_id);

-- 组合索引用于高效查询
CREATE INDEX idx_bar_themes_bar_theme ON public.bar_themes(bar_id, theme_id);

-- 添加注释
COMMENT ON TABLE public.bar_themes IS '酒吧主题标签关联表';
COMMENT ON COLUMN public.bar_themes.bar_id IS '关联的酒吧ID';
COMMENT ON COLUMN public.bar_themes.theme_id IS '关联的主题ID';

-- 创建便捷查询视图 (带RLS安全设置)
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
COMMENT ON VIEW public.bar_themes_detailed IS '酒吧主题详情视图 - 继承相关表的RLS策略';