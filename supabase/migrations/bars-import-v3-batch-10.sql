BEGIN;

-- Insert bars table data
INSERT INTO public.bars (name, district_id, description, cash_only, card_accepted) VALUES
    ('Spreegold Bikini Berlin', NULL, 'Rating 4.2/5 (3741 reviews) | Price: 2 | Types: bar, cafe, establishment, food, point_of_interest, restaurant', false, false),
    ('Lang Bar im Waldorf Astoria', NULL, 'Rating 4.1/5 (335 reviews) | Price: 3 | Types: bar, establishment, point_of_interest', false, false),
    ('Park Inn by Radisson Berlin Alexanderplatz', NULL, 'Rating 4.1/5 (27824 reviews) | Price:  | Types: bar, establishment, food, lodging, point_of_interest, restaurant', false, false),
    ('Bar Steinkeller (Steinritze20)', NULL, 'Rating 4.8/5 (296 reviews) | Price:  | Types: bar, establishment, point_of_interest', false, false),
    ('Sky Cocktail Bar Steglitz', NULL, 'Rating 4.1/5 (17 reviews) | Price:  | Types: bar, establishment, point_of_interest', false, false),
    ('Grissini Bar im NH Hotel', NULL, 'Rating 4.5/5 (19 reviews) | Price:  | Types: bar, establishment, point_of_interest', false, false),
    ('Strandbar Mitte', NULL, 'Rating 4.3/5 (831 reviews) | Price:  | Types: bar, establishment, point_of_interest', false, false),
    ('Mio Berlin', NULL, 'Rating 4/5 (4799 reviews) | Price: 2 | Types: bar, cafe, establishment, food, point_of_interest, restaurant, store', false, false),
    ('Mokka Mitte', NULL, 'Rating 4/5 (1225 reviews) | Price: 2 | Types: bar, establishment, point_of_interest', false, false),
    ('The Unique Bar Berlin', NULL, 'Rating 4.3/5 (50 reviews) | Price:  | Types: bar, establishment, point_of_interest', false, false);

-- Insert bar_locations table data
WITH inserted_bars AS (
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

-- Insert bar_themes table data
WITH inserted_bars AS (
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
),
theme_mapping AS (
    SELECT ib.id as bar_id, t.id as theme_id
    FROM inserted_bars ib
    CROSS JOIN public.themes t
    WHERE t.name = 'Bar' -- Default theme for all bars
)
INSERT INTO public.bar_themes (bar_id, theme_id)
SELECT DISTINCT bar_id, theme_id FROM theme_mapping;

COMMIT;

