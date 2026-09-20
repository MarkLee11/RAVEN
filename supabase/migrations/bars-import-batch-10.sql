BEGIN;

-- 插入bars表数�?INSERT INTO public.bars (name, district_id, description, cash_only, card_accepted) VALUES
    ('Spreegold Bikini Berlin', 1, '评分 4.2/5 (3741 条评�? | 2 | 类型: bar, cafe, establishment, food, point_of_interest, restaurant', false, false),
    ('Lang Bar im Waldorf Astoria', 1, '评分 4.1/5 (335 条评�? | 3 | 类型: bar, establishment, point_of_interest', false, false),
    ('Park Inn by Radisson Berlin Alexanderplatz', 1, '评分 4.1/5 (27824 条评�? | 类型: bar, establishment, food, lodging, point_of_interest, restaurant', false, false),
    ('Bar Steinkeller (Steinritze20)', 1, '评分 4.8/5 (296 条评�? | 类型: bar, establishment, point_of_interest', false, false),
    ('Sky Cocktail Bar Steglitz', 1, '评分 4.1/5 (17 条评�? | 类型: bar, establishment, point_of_interest', false, false),
    ('Grissini Bar im NH Hotel', 1, '评分 4.5/5 (19 条评�? | 类型: bar, establishment, point_of_interest', false, false),
    ('Strandbar Mitte', 1, '评分 4.3/5 (831 条评�? | 类型: bar, establishment, point_of_interest', false, false),
    ('Mio Berlin', 1, '评分 4/5 (4799 条评�? | 2 | 类型: bar, cafe, establishment, food, point_of_interest, restaurant, store', false, false),
    ('Mokka Mitte', 1, '评分 4/5 (1225 条评�? | 2 | 类型: bar, establishment, point_of_interest', false, false),
    ('The Unique Bar Berlin', 1, '评分 4.3/5 (50 条评�? | 类型: bar, establishment, point_of_interest', false, false);

-- 插入bar_locations表数�?WITH inserted_bars AS (
    SELECT id, name FROM public.bars WHERE name IN (
        'Spreegold Bikini Berlin',
        'Lang Bar im Waldorf Astoria',
        'Park Inn by Radisson Berlin Alexanderplatz',
        'Bar Steinkeller (Steinritze20)',
        'Sky Cocktail Bar Steglitz',
        'Grissini Bar im NH Hotel',
        'Strandbar Mitte',
        'Mio Berlin',
        'Mokka Mitte',
        'The Unique Bar Berlin'
    )
)
INSERT INTO public.bar_locations (bar_id, address_line, postal_code, latitude, longitude)
SELECT ib.id, loc.address_line, loc.postal_code, loc.latitude, loc.longitude
FROM inserted_bars ib
JOIN (VALUES
    ('Spreegold Bikini Berlin', 'Budapester Straße 50 Im Bikini, 10787 Berlin, Germany', '10787', 52.5056106, 13.3350293),
    ('Lang Bar im Waldorf Astoria', 'Hardenbergstraße 28, 10623 Berlin, Germany', '10623', 52.5054034, 13.3330219),
    ('Park Inn by Radisson Berlin Alexanderplatz', 'Alexanderpl. 7, 10178 Berlin, Germany', '10178', 52.522811, 13.4131023),
    ('Bar Steinkeller (Steinritze20)', 'Steinstraße 20, 10119 Berlin, Germany', '10119', 52.5273966, 13.4040725),
    ('Sky Cocktail Bar Steglitz', 'Steglitz Kreisel Turm, Albrechtstr. 2, 12165 Berlin, Germany', '12165', 52.456519, 13.32133),
    ('Grissini Bar im NH Hotel', 'Leipziger Str. 106, 10117 Berlin, Germany', '10117', 52.5104237, 13.3886284),
    ('Strandbar Mitte', 'Monbijoustraße 3B, 10117 Berlin, Germany', '10117', 52.522788, 13.3947422),
    ('Mio Berlin', 'Panoramastraße 1a, 10179 Berlin, Germany', '10179', 52.5203304, 13.4097),
    ('Mokka Mitte', 'James Simon Park, Stadtbahnbogen 159/160, 10178 Berlin, Germany', '10178', 52.5222181, 13.3984601),
    ('The Unique Bar Berlin', 'Sheraton Berlin Grand Hotel Esplanade, Lützowufer 15, 10785 Berlin, Germany', '10785', 52.505515, 13.354985)
) AS loc(name, address_line, postal_code, latitude, longitude) ON ib.name = loc.name;

-- 插入bar_themes表数�?WITH inserted_bars AS (
    SELECT id, name FROM public.bars WHERE name IN (
        'Spreegold Bikini Berlin',
        'Lang Bar im Waldorf Astoria',
        'Park Inn by Radisson Berlin Alexanderplatz',
        'Bar Steinkeller (Steinritze20)',
        'Sky Cocktail Bar Steglitz',
        'Grissini Bar im NH Hotel',
        'Strandbar Mitte',
        'Mio Berlin',
        'Mokka Mitte',
        'The Unique Bar Berlin'
    )
)
INSERT INTO public.bar_themes (bar_id, theme_id)
SELECT ib.id, t.id
FROM inserted_bars ib
JOIN (VALUES
    ('Spreegold Bikini Berlin', 'cocktails'),
    ('Spreegold Bikini Berlin', 'food'),
    ('Lang Bar im Waldorf Astoria', 'cocktails'),
    ('Park Inn by Radisson Berlin Alexanderplatz', 'cocktails'),
    ('Park Inn by Radisson Berlin Alexanderplatz', 'food'),
    ('Bar Steinkeller (Steinritze20)', 'cocktails'),
    ('Sky Cocktail Bar Steglitz', 'cocktails'),
    ('Grissini Bar im NH Hotel', 'cocktails'),
    ('Strandbar Mitte', 'cocktails'),
    ('Mio Berlin', 'cocktails'),
    ('Mio Berlin', 'food'),
    ('Mio Berlin', 'spirits'),
    ('Mokka Mitte', 'cocktails'),
    ('The Unique Bar Berlin', 'cocktails')
) AS bt(bar_name, theme_name) ON ib.name = bt.bar_name
JOIN public.themes t ON t.name = bt.theme_name;

COMMIT;

-- 数据验证查询
SELECT 'bars' as table_name, COUNT(*) as count FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%'
UNION ALL
SELECT 'bar_locations' as table_name, COUNT(*) as count FROM public.bar_locations bl
JOIN public.bars b ON bl.bar_id = b.id WHERE b.description LIKE '%柏林%' OR b.description LIKE '%Berlin%'
UNION ALL
SELECT 'bar_themes' as table_name, COUNT(*) as count FROM public.bar_themes bt
JOIN public.bars b ON bt.bar_id = b.id WHERE b.description LIKE '%柏林%' OR b.description LIKE '%Berlin%';

-- 导入数据示例查询
SELECT b.name, b.description, bl.address_line, bl.latitude, bl.longitude,
       STRING_AGG(t.name, ', ') as themes
FROM public.bars b
LEFT JOIN public.bar_locations bl ON b.id = bl.bar_id
LEFT JOIN public.bar_themes bt ON b.id = bt.bar_id
LEFT JOIN public.themes t ON bt.theme_id = t.id
WHERE b.description LIKE '%柏林%' OR b.description LIKE '%Berlin%'
GROUP BY b.id, b.name, b.description, bl.address_line, bl.latitude, bl.longitude
ORDER BY b.name
LIMIT 10;
