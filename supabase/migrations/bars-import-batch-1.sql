-- RAVEN项目 - 柏林酒吧数据导入脚本 (版本2)
-- 生成时间: 2025-08-23T05:02:38.695Z
-- 数据来源: E:\RAVEN\scripts\berlin-bars-data.json
-- 总记录数: 410

-- 清理现有柏林酒吧数据以避免冲�?DELETE FROM public.bar_themes WHERE bar_id IN (
    SELECT id FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%'
);
DELETE FROM public.bar_locations WHERE bar_id IN (
    SELECT id FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%'
);
DELETE FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%';

-- 批次 1: 记录 1-50