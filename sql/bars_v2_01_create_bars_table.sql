-- 创建 bars 主表 (Version 2.0)
-- 简化的bars表，只保留payment相关的boolean字段
-- 所有其他分类通过themes关联表管理

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

-- 启用行级安全性
ALTER TABLE public.bars ENABLE ROW LEVEL SECURITY;

-- 添加公共读取权限
CREATE POLICY "Allow public read access on bars" ON public.bars
    FOR SELECT USING (true);

-- 添加索引提升查询性能
CREATE INDEX idx_bars_district_id ON public.bars(district_id);
CREATE INDEX idx_bars_payment ON public.bars(cash_only, card_accepted);
CREATE INDEX idx_bars_name ON public.bars(name);

-- 添加注释
COMMENT ON TABLE public.bars IS 'Berlin酒吧信息表 - 精简版';
COMMENT ON COLUMN public.bars.name IS '酒吧名称';
COMMENT ON COLUMN public.bars.district_id IS '所属地区ID，关联districts表';
COMMENT ON COLUMN public.bars.description IS '酒吧描述';
COMMENT ON COLUMN public.bars.cash_only IS '是否仅接受现金';
COMMENT ON COLUMN public.bars.card_accepted IS '是否接受刷卡';