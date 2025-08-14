-- 创建 bar_locations 表 (Version 2.0)
-- 存储酒吧的地址信息

CREATE TABLE public.bar_locations (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id) ON DELETE CASCADE,
    address_line TEXT NOT NULL,
    postal_code VARCHAR(10),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- 确保每个酒吧只有一个主要地址
    CONSTRAINT unique_bar_location UNIQUE (bar_id)
);

-- 启用行级安全性
ALTER TABLE public.bar_locations ENABLE ROW LEVEL SECURITY;

-- 添加公共读取权限
CREATE POLICY "Allow public read access on bar_locations" ON public.bar_locations
    FOR SELECT USING (true);

-- 添加索引
CREATE INDEX idx_bar_locations_bar_id ON public.bar_locations(bar_id);
CREATE INDEX idx_bar_locations_coordinates ON public.bar_locations(latitude, longitude) 
    WHERE latitude IS NOT NULL AND longitude IS NOT NULL;

-- 添加注释
COMMENT ON TABLE public.bar_locations IS '酒吧地址信息表';
COMMENT ON COLUMN public.bar_locations.bar_id IS '关联的酒吧ID';
COMMENT ON COLUMN public.bar_locations.address_line IS '地址详情';
COMMENT ON COLUMN public.bar_locations.postal_code IS '邮政编码';
COMMENT ON COLUMN public.bar_locations.latitude IS '纬度';
COMMENT ON COLUMN public.bar_locations.longitude IS '经度';