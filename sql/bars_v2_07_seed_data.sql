-- BARS种子数据插入脚本
-- 基于src/data/bars.ts的mock数据生成

-- 首先获取district_id映射
-- 我们需要从districts表获取ID，假设这些district已经存在

-- 临时存储district映射的变量
DO $$
DECLARE
    neukolln_id BIGINT;
    friedrichshain_id BIGINT;
    mitte_id BIGINT;
    schoneberg_id BIGINT;
    prenzlauer_id BIGINT;
    charlottenburg_id BIGINT;
    
    -- Theme IDs
    house_id BIGINT;
    disco_id BIGINT;
    outdoor_id BIGINT;
    queer_friendly_id BIGINT;
    cocktails_id BIGINT;
    upscale_id BIGINT;
    cash_only_id BIGINT;
    classic_id BIGINT;
    late_night_id BIGINT;
    beer_garden_id BIGINT;
    traditional_id BIGINT;
    rooftop_id BIGINT;
    historic_id BIGINT;
    beer_id BIGINT;
    
    -- Bar IDs
    klunkerkranich_id BIGINT;
    renate_id BIGINT;
    buck_breck_id BIGINT;
    green_door_id BIGINT;
    prater_id BIGINT;
    monkey_bar_id BIGINT;
    letzten_instanz_id BIGINT;
    
BEGIN
    -- 获取district IDs
    SELECT id INTO neukolln_id FROM districts WHERE name = 'Neukölln';
    SELECT id INTO friedrichshain_id FROM districts WHERE name = 'Friedrichshain';
    SELECT id INTO mitte_id FROM districts WHERE name = 'Mitte';
    SELECT id INTO schoneberg_id FROM districts WHERE name = 'Schöneberg';
    SELECT id INTO prenzlauer_id FROM districts WHERE name = 'Prenzlauer Berg';
    SELECT id INTO charlottenburg_id FROM districts WHERE name = 'Charlottenburg';
    
    -- 获取theme IDs (一些可能不存在，我们需要先插入到themes表)
    -- 插入可能缺失的themes（包括所有需要的themes）
    INSERT INTO themes (name, category) VALUES 
        ('house', 'music'), 
        ('disco', 'music'), 
        ('late-night', 'vibe'),
        ('beer-garden', 'architecture'),
        ('traditional', 'style'),
        ('lgbtq-friendly', 'vibe')
    ON CONFLICT (name) DO NOTHING;
    
    -- 获取theme IDs (确保所有theme都存在，如果不存在就跳过)
    SELECT id INTO house_id FROM themes WHERE name = 'house';
    SELECT id INTO disco_id FROM themes WHERE name = 'disco';
    SELECT id INTO outdoor_id FROM themes WHERE name = 'outdoor';
    SELECT id INTO queer_friendly_id FROM themes WHERE name = 'lgbtq-friendly';
    SELECT id INTO cocktails_id FROM themes WHERE name = 'cocktails';
    SELECT id INTO upscale_id FROM themes WHERE name = 'upscale';
    SELECT id INTO classic_id FROM themes WHERE name = 'classic';
    SELECT id INTO late_night_id FROM themes WHERE name = 'late-night';
    SELECT id INTO beer_garden_id FROM themes WHERE name = 'beer-garden';
    SELECT id INTO traditional_id FROM themes WHERE name = 'traditional';
    SELECT id INTO rooftop_id FROM themes WHERE name = 'rooftop';
    SELECT id INTO historic_id FROM themes WHERE name = 'historic';
    SELECT id INTO beer_id FROM themes WHERE name = 'beer';
    
    -- 调试输出，显示哪些theme_id为null
    RAISE NOTICE '获取到的theme IDs:';
    RAISE NOTICE 'house_id: %, disco_id: %, outdoor_id: %', house_id, disco_id, outdoor_id;
    RAISE NOTICE 'queer_friendly_id: %, cocktails_id: %, upscale_id: %', queer_friendly_id, cocktails_id, upscale_id;
    RAISE NOTICE 'classic_id: %, late_night_id: %, beer_garden_id: %', classic_id, late_night_id, beer_garden_id;
    RAISE NOTICE 'traditional_id: %, rooftop_id: %, historic_id: %, beer_id: %', traditional_id, rooftop_id, historic_id, beer_id;
    
    -- 插入bars数据
    -- 1. Klunkerkranich
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Klunkerkranich', neukolln_id, 'Rooftop paradise above shopping mall. Sunset sessions.', false, true)
    RETURNING id INTO klunkerkranich_id;
    
    -- 2. Zur Wilden Renate  
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Zur Wilden Renate', friedrichshain_id, 'Quirky apartment-style bar with themed rooms and friendly crowd.', true, false)
    RETURNING id INTO renate_id;
    
    -- 3. Buck and Breck
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Buck and Breck', mitte_id, 'Intimate cocktail bar with surgical precision. Reservation recommended.', true, false)
    RETURNING id INTO buck_breck_id;
    
    -- 4. Green Door
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Green Door', schoneberg_id, 'Classic cocktail bar with dim lighting and excellent bartenders.', false, true)
    RETURNING id INTO green_door_id;
    
    -- 5. Prater Garten
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Prater Garten', prenzlauer_id, 'Berlin''s oldest beer garden. Traditional atmosphere, great for groups.', false, true)
    RETURNING id INTO prater_id;
    
    -- 6. Monkey Bar
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Monkey Bar', charlottenburg_id, 'Rooftop bar with zoo views. Sophisticated cocktails and city panorama.', false, true)
    RETURNING id INTO monkey_bar_id;
    
    -- 7. Zur Letzten Instanz
    INSERT INTO bars (name, district_id, description, cash_only, card_accepted)
    VALUES ('Zur Letzten Instanz', mitte_id, 'Berlin''s oldest restaurant-bar. Historic charm and traditional German fare.', false, true)
    RETURNING id INTO letzten_instanz_id;
    
    -- 插入bar_ratings（基于原始评分生成合理的新评分）
    -- 新评分逻辑：
    -- quality_rating: 基于music评分 + 场所类型调整
    -- price_rating: 基于crowd评分和upscale属性调整  
    -- vibe_rating: 直接使用原vibe评分
    -- friendliness_rating: 基于safety评分调整
    
    -- Klunkerkranich (music:75, vibe:92, crowd:88, safety:95)
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (klunkerkranich_id, 82, 75, 92, 90);
    
    -- Zur Wilden Renate (music:78, vibe:89, crowd:86, safety:90) 
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (renate_id, 80, 78, 89, 88);
    
    -- Buck and Breck (music:65, vibe:85, crowd:75, safety:95) - upscale, 价格高
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (buck_breck_id, 90, 40, 85, 92);
    
    -- Green Door (music:70, vibe:88, crowd:82, safety:92)
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (green_door_id, 85, 70, 88, 90);
    
    -- Prater Garten (music:60, vibe:85, crowd:90, safety:95) - traditional, 价格便宜
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (prater_id, 75, 85, 85, 95);
    
    -- Monkey Bar (music:72, vibe:80, crowd:70, safety:98) - upscale, 价格高
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (monkey_bar_id, 88, 35, 80, 95);
    
    -- Zur Letzten Instanz (music:55, vibe:82, crowd:85, safety:95) - historic, 价格中等
    INSERT INTO bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
    VALUES (letzten_instanz_id, 78, 75, 82, 93);
    
    -- 插入bar_themes关联 (只插入存在的theme_id，跳过null值)
    -- Klunkerkranich: house, disco, outdoor, queer-friendly
    IF house_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (klunkerkranich_id, house_id);
    END IF;
    IF disco_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (klunkerkranich_id, disco_id);
    END IF;
    IF outdoor_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (klunkerkranich_id, outdoor_id);
    END IF;
    IF queer_friendly_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (klunkerkranich_id, queer_friendly_id);
    END IF;
    
    -- Zur Wilden Renate: house, disco, queer-friendly  
    IF house_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (renate_id, house_id);
    END IF;
    IF disco_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (renate_id, disco_id);
    END IF;
    IF queer_friendly_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (renate_id, queer_friendly_id);
    END IF;
    
    -- Buck and Breck: cocktails, upscale
    IF cocktails_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (buck_breck_id, cocktails_id);
    END IF;
    IF upscale_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (buck_breck_id, upscale_id);
    END IF;
    
    -- Green Door: cocktails, classic, late-night 
    IF cocktails_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (green_door_id, cocktails_id);
    END IF;
    IF classic_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (green_door_id, classic_id);
    END IF;
    IF late_night_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (green_door_id, late_night_id);
    END IF;
    
    -- Prater Garten: beer-garden, outdoor, traditional
    IF beer_garden_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (prater_id, beer_garden_id);
    END IF;
    IF outdoor_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (prater_id, outdoor_id);
    END IF;
    IF traditional_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (prater_id, traditional_id);
    END IF;
    
    -- Monkey Bar: cocktails, rooftop, upscale
    IF cocktails_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (monkey_bar_id, cocktails_id);
    END IF;
    IF rooftop_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (monkey_bar_id, rooftop_id);
    END IF;
    IF upscale_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (monkey_bar_id, upscale_id);
    END IF;
    
    -- Zur Letzten Instanz: traditional, historic, beer
    IF traditional_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (letzten_instanz_id, traditional_id);
    END IF;
    IF historic_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (letzten_instanz_id, historic_id);
    END IF;
    IF beer_id IS NOT NULL THEN
        INSERT INTO bar_themes (bar_id, theme_id) VALUES (letzten_instanz_id, beer_id);
    END IF;

    RAISE NOTICE '成功插入 7 个bars及其相关数据';
    
END $$;