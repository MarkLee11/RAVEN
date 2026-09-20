# RAVEN项目 - 酒吧评论和评分模拟数据

## 概述

本目录包含为RAVEN项目生成的1000条酒吧评论和评分模拟数据，分为10个批次，每批次100条记录。数据基于真实的Berlin地区和主题标签生成，评分偏向乐观（高分）。

## 生成时间
2025-08-23T05:36:34.551Z

## 文件结构

### 酒吧数据
- `bars-mock-data.sql` - 1000个模拟酒吧的基础数据和主题关联

### 评分数据（10个批次）
- `bar-ratings-batch-01.sql` 到 `bar-ratings-batch-10.sql`
- 每个文件包含100条评分记录
- 总计：1000条 `bar_ratings` 记录

### 评论数据（10个批次）  
- `bar-reviews-batch-01.sql` 到 `bar-reviews-batch-10.sql`
- 每个文件包含100条评论记录
- 总计：1000条 `bar_reviews` 记录

## 数据特征

### 地区分布
数据涵盖Berlin的15个主要地区：
- Mitte (ID: 60)
- Friedrichshain (ID: 61)
- Kreuzberg (ID: 62)
- Prenzlauer Berg (ID: 63)
- Pankow (ID: 64)
- Schöneberg (ID: 65)
- Neukölln (ID: 66)
- Treptow (ID: 67)
- Charlottenburg-Wilmersdorf (ID: 68)
- Spandau (ID: 69)
- Steglitz-Zehlendorf (ID: 70)
- Marzahn-Hellersdorf (ID: 71)
- Lichtenberg (ID: 72)
- Reinickendorf (ID: 73)
- Köpenick (ID: 74)

### 主题标签
包含5个类别的主题标签：
- **drinks**: cocktails, beer, wine, shots, whisky, rum, gin, vodka, tequila, mocktails
- **style**: upscale, classic, historic, industrial, minimalist, alternative, speakeasy, art-bar, traditional
- **architecture**: outdoor, rooftop, stage, smoking-area, private-rooms, beer-garden
- **vibe**: straight-bar, gay-bar, lesbian-bar, queer-bar, lgbtq-friendly, chill, classy, lively, crowded, cozy, romantic, wild, underground, artsy, intimate, touristy, local, late-night
- **music**: jazz, blues, funk, soul, disco, pop, indie, rock, electronic, latin, live-music, house

### 评分分布（0-100分制）
为了创造乐观的评分分布：
- 40% 概率：80-100分（高分）
- 30% 概率：65-85分（中上分）
- 20% 概率：50-75分（中等分）
- 10% 概率：30-60分（较低分）

### 评论内容
- 中英文混合评论
- 正面评论（80%）
- 中性评论（15%）
- 负面评论（5%）
- 评论内容与评分相匹配

### 用户和时间
- 模拟UUID格式的用户ID
- 60% 概率匿名评论
- 70% 概率包含排队时间（0-45分钟）
- 评论时间分布在最近6个月内

## 数据库表结构

### bar_ratings表
```sql
CREATE TABLE public.bar_ratings (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id),
    quality_rating INTEGER NOT NULL CHECK (quality_rating >= 0 AND quality_rating <= 100),
    price_rating INTEGER NOT NULL CHECK (price_rating >= 0 AND price_rating <= 100),
    vibe_rating INTEGER NOT NULL CHECK (vibe_rating >= 0 AND vibe_rating <= 100),
    friendliness_rating INTEGER NOT NULL CHECK (friendliness_rating >= 0 AND friendliness_rating <= 100),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_bar_rating UNIQUE (bar_id)
);
```

### bar_reviews表
```sql
CREATE TABLE public.bar_reviews (
    id BIGSERIAL PRIMARY KEY,
    bar_id BIGINT NOT NULL REFERENCES public.bars(id),
    user_id UUID REFERENCES auth.users(id),
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
```

## 使用方法

### 1. 首先导入酒吧基础数据
```sql
\i sql/mock-data/bars-mock-data.sql
```

### 2. 分批导入评分数据
```sql
\i sql/mock-data/bar-ratings-batch-01.sql
\i sql/mock-data/bar-ratings-batch-02.sql
-- ... 继续导入所有批次
\i sql/mock-data/bar-ratings-batch-10.sql
```

### 3. 分批导入评论数据
```sql
\i sql/mock-data/bar-reviews-batch-01.sql
\i sql/mock-data/bar-reviews-batch-02.sql
-- ... 继续导入所有批次
\i sql/mock-data/bar-reviews-batch-10.sql
```

## 数据完整性检查

### 统计查询
```sql
-- 检查导入的数据量
SELECT COUNT(*) FROM public.bars;           -- 应该是1000
SELECT COUNT(*) FROM public.bar_ratings;    -- 应该是1000  
SELECT COUNT(*) FROM public.bar_reviews;    -- 应该是1000
SELECT COUNT(*) FROM public.bar_themes;     -- 应该是2000-5000（每个酒吧2-5个主题）

-- 检查评分分布
SELECT 
    AVG(quality_rating) as avg_quality,
    AVG(price_rating) as avg_price,
    AVG(vibe_rating) as avg_vibe,
    AVG(friendliness_rating) as avg_friendliness
FROM public.bar_ratings;

-- 检查地区分布
SELECT d.name, COUNT(*) as bar_count
FROM public.bars b
JOIN public.districts d ON b.district_id = d.id
GROUP BY d.name
ORDER BY bar_count DESC;
```

## 注意事项

1. **外键约束**: 确保在导入前已有对应的 `districts` 和 `themes` 数据
2. **用户ID**: 生成的user_id是模拟的UUID，需要与实际的Supabase用户系统对应
3. **去重**: `bar_ratings` 表有 `unique_bar_rating` 约束，确保每个酒吧只有一条评分记录
4. **权限**: 确保数据库用户有相应的INSERT权限

## 生成脚本

数据由 `scripts/generate-bar-mock-reviews.js` 生成，如需重新生成或调整参数，可修改该脚本重新运行。


