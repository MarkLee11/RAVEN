-- RAVEN项目 - 酒吧评分数据 (批次 3)
-- 生成时间: 2025-08-23T06:00:20.187Z
-- 记录数: 100
-- 使用现有bars表中的真实bar_id

-- 为随机选择的现有酒吧生成评分数据
WITH random_bars AS (
  SELECT id as bar_id FROM public.bars 
  ORDER BY RANDOM() 
  LIMIT 100
),
ratings_data AS (
  SELECT 
    bar_id,
    96 as quality_rating,
    67 as price_rating,
    62 as vibe_rating,
    69 as friendliness_rating
  FROM random_bars OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id,
    76 as quality_rating,
    58 as price_rating,
    89 as vibe_rating,
    65 as friendliness_rating
  FROM random_bars OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id,
    79 as quality_rating,
    82 as price_rating,
    94 as vibe_rating,
    82 as friendliness_rating
  FROM random_bars OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id,
    81 as quality_rating,
    77 as price_rating,
    46 as vibe_rating,
    38 as friendliness_rating
  FROM random_bars OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id,
    57 as quality_rating,
    95 as price_rating,
    74 as vibe_rating,
    43 as friendliness_rating
  FROM random_bars OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    85 as price_rating,
    85 as vibe_rating,
    75 as friendliness_rating
  FROM random_bars OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id,
    67 as quality_rating,
    84 as price_rating,
    69 as vibe_rating,
    69 as friendliness_rating
  FROM random_bars OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id,
    84 as quality_rating,
    100 as price_rating,
    46 as vibe_rating,
    97 as friendliness_rating
  FROM random_bars OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id,
    92 as quality_rating,
    68 as price_rating,
    89 as vibe_rating,
    100 as friendliness_rating
  FROM random_bars OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id,
    90 as quality_rating,
    77 as price_rating,
    71 as vibe_rating,
    87 as friendliness_rating
  FROM random_bars OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id,
    96 as quality_rating,
    83 as price_rating,
    55 as vibe_rating,
    36 as friendliness_rating
  FROM random_bars OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id,
    65 as quality_rating,
    86 as price_rating,
    81 as vibe_rating,
    73 as friendliness_rating
  FROM random_bars OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id,
    82 as quality_rating,
    84 as price_rating,
    56 as vibe_rating,
    100 as friendliness_rating
  FROM random_bars OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id,
    89 as quality_rating,
    82 as price_rating,
    80 as vibe_rating,
    80 as friendliness_rating
  FROM random_bars OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id,
    57 as quality_rating,
    100 as price_rating,
    76 as vibe_rating,
    82 as friendliness_rating
  FROM random_bars OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id,
    98 as quality_rating,
    98 as price_rating,
    86 as vibe_rating,
    86 as friendliness_rating
  FROM random_bars OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id,
    78 as quality_rating,
    92 as price_rating,
    72 as vibe_rating,
    73 as friendliness_rating
  FROM random_bars OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id,
    67 as quality_rating,
    97 as price_rating,
    65 as vibe_rating,
    38 as friendliness_rating
  FROM random_bars OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id,
    75 as quality_rating,
    80 as price_rating,
    86 as vibe_rating,
    75 as friendliness_rating
  FROM random_bars OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id,
    98 as quality_rating,
    56 as price_rating,
    74 as vibe_rating,
    84 as friendliness_rating
  FROM random_bars OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id,
    80 as quality_rating,
    55 as price_rating,
    49 as vibe_rating,
    75 as friendliness_rating
  FROM random_bars OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id,
    82 as quality_rating,
    40 as price_rating,
    62 as vibe_rating,
    70 as friendliness_rating
  FROM random_bars OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    91 as price_rating,
    67 as vibe_rating,
    78 as friendliness_rating
  FROM random_bars OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id,
    84 as quality_rating,
    87 as price_rating,
    91 as vibe_rating,
    69 as friendliness_rating
  FROM random_bars OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id,
    62 as quality_rating,
    61 as price_rating,
    88 as vibe_rating,
    88 as friendliness_rating
  FROM random_bars OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id,
    68 as quality_rating,
    85 as price_rating,
    74 as vibe_rating,
    63 as friendliness_rating
  FROM random_bars OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id,
    56 as quality_rating,
    81 as price_rating,
    87 as vibe_rating,
    91 as friendliness_rating
  FROM random_bars OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id,
    55 as quality_rating,
    82 as price_rating,
    80 as vibe_rating,
    66 as friendliness_rating
  FROM random_bars OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    66 as price_rating,
    52 as vibe_rating,
    78 as friendliness_rating
  FROM random_bars OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id,
    76 as quality_rating,
    98 as price_rating,
    73 as vibe_rating,
    82 as friendliness_rating
  FROM random_bars OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id,
    64 as quality_rating,
    74 as price_rating,
    96 as vibe_rating,
    80 as friendliness_rating
  FROM random_bars OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id,
    69 as quality_rating,
    94 as price_rating,
    80 as vibe_rating,
    90 as friendliness_rating
  FROM random_bars OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id,
    78 as quality_rating,
    73 as price_rating,
    71 as vibe_rating,
    88 as friendliness_rating
  FROM random_bars OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id,
    34 as quality_rating,
    76 as price_rating,
    82 as vibe_rating,
    75 as friendliness_rating
  FROM random_bars OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id,
    53 as quality_rating,
    80 as price_rating,
    59 as vibe_rating,
    77 as friendliness_rating
  FROM random_bars OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id,
    83 as quality_rating,
    60 as price_rating,
    87 as vibe_rating,
    84 as friendliness_rating
  FROM random_bars OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id,
    92 as quality_rating,
    86 as price_rating,
    79 as vibe_rating,
    99 as friendliness_rating
  FROM random_bars OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id,
    100 as quality_rating,
    65 as price_rating,
    85 as vibe_rating,
    89 as friendliness_rating
  FROM random_bars OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id,
    72 as quality_rating,
    69 as price_rating,
    66 as vibe_rating,
    55 as friendliness_rating
  FROM random_bars OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    100 as price_rating,
    58 as vibe_rating,
    99 as friendliness_rating
  FROM random_bars OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id,
    69 as quality_rating,
    66 as price_rating,
    84 as vibe_rating,
    68 as friendliness_rating
  FROM random_bars OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id,
    65 as quality_rating,
    97 as price_rating,
    31 as vibe_rating,
    96 as friendliness_rating
  FROM random_bars OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id,
    63 as quality_rating,
    74 as price_rating,
    81 as vibe_rating,
    90 as friendliness_rating
  FROM random_bars OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id,
    81 as quality_rating,
    56 as price_rating,
    75 as vibe_rating,
    86 as friendliness_rating
  FROM random_bars OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    95 as price_rating,
    66 as vibe_rating,
    99 as friendliness_rating
  FROM random_bars OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id,
    95 as quality_rating,
    81 as price_rating,
    89 as vibe_rating,
    70 as friendliness_rating
  FROM random_bars OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id,
    53 as quality_rating,
    82 as price_rating,
    54 as vibe_rating,
    87 as friendliness_rating
  FROM random_bars OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id,
    79 as quality_rating,
    82 as price_rating,
    89 as vibe_rating,
    55 as friendliness_rating
  FROM random_bars OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id,
    97 as quality_rating,
    86 as price_rating,
    41 as vibe_rating,
    59 as friendliness_rating
  FROM random_bars OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id,
    85 as quality_rating,
    80 as price_rating,
    97 as vibe_rating,
    84 as friendliness_rating
  FROM random_bars OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id,
    74 as quality_rating,
    95 as price_rating,
    50 as vibe_rating,
    90 as friendliness_rating
  FROM random_bars OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id,
    79 as quality_rating,
    53 as price_rating,
    90 as vibe_rating,
    79 as friendliness_rating
  FROM random_bars OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id,
    89 as quality_rating,
    82 as price_rating,
    88 as vibe_rating,
    77 as friendliness_rating
  FROM random_bars OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id,
    59 as quality_rating,
    97 as price_rating,
    86 as vibe_rating,
    85 as friendliness_rating
  FROM random_bars OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id,
    82 as quality_rating,
    85 as price_rating,
    65 as vibe_rating,
    85 as friendliness_rating
  FROM random_bars OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    36 as price_rating,
    59 as vibe_rating,
    99 as friendliness_rating
  FROM random_bars OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id,
    66 as quality_rating,
    73 as price_rating,
    79 as vibe_rating,
    58 as friendliness_rating
  FROM random_bars OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id,
    81 as quality_rating,
    62 as price_rating,
    96 as vibe_rating,
    71 as friendliness_rating
  FROM random_bars OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id,
    62 as quality_rating,
    66 as price_rating,
    85 as vibe_rating,
    97 as friendliness_rating
  FROM random_bars OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id,
    93 as quality_rating,
    77 as price_rating,
    84 as vibe_rating,
    97 as friendliness_rating
  FROM random_bars OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id,
    96 as quality_rating,
    50 as price_rating,
    74 as vibe_rating,
    80 as friendliness_rating
  FROM random_bars OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id,
    91 as quality_rating,
    86 as price_rating,
    60 as vibe_rating,
    82 as friendliness_rating
  FROM random_bars OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id,
    81 as quality_rating,
    84 as price_rating,
    51 as vibe_rating,
    86 as friendliness_rating
  FROM random_bars OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id,
    62 as quality_rating,
    82 as price_rating,
    56 as vibe_rating,
    82 as friendliness_rating
  FROM random_bars OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id,
    85 as quality_rating,
    67 as price_rating,
    93 as vibe_rating,
    97 as friendliness_rating
  FROM random_bars OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id,
    72 as quality_rating,
    85 as price_rating,
    77 as vibe_rating,
    70 as friendliness_rating
  FROM random_bars OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id,
    76 as quality_rating,
    81 as price_rating,
    98 as vibe_rating,
    36 as friendliness_rating
  FROM random_bars OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id,
    69 as quality_rating,
    56 as price_rating,
    81 as vibe_rating,
    98 as friendliness_rating
  FROM random_bars OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id,
    98 as quality_rating,
    91 as price_rating,
    41 as vibe_rating,
    52 as friendliness_rating
  FROM random_bars OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id,
    55 as quality_rating,
    64 as price_rating,
    75 as vibe_rating,
    89 as friendliness_rating
  FROM random_bars OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id,
    57 as quality_rating,
    72 as price_rating,
    97 as vibe_rating,
    82 as friendliness_rating
  FROM random_bars OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id,
    96 as quality_rating,
    84 as price_rating,
    76 as vibe_rating,
    36 as friendliness_rating
  FROM random_bars OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id,
    68 as quality_rating,
    93 as price_rating,
    54 as vibe_rating,
    92 as friendliness_rating
  FROM random_bars OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id,
    67 as quality_rating,
    85 as price_rating,
    34 as vibe_rating,
    42 as friendliness_rating
  FROM random_bars OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id,
    85 as quality_rating,
    73 as price_rating,
    42 as vibe_rating,
    62 as friendliness_rating
  FROM random_bars OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id,
    62 as quality_rating,
    48 as price_rating,
    76 as vibe_rating,
    38 as friendliness_rating
  FROM random_bars OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id,
    34 as quality_rating,
    74 as price_rating,
    82 as vibe_rating,
    59 as friendliness_rating
  FROM random_bars OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id,
    61 as quality_rating,
    83 as price_rating,
    81 as vibe_rating,
    72 as friendliness_rating
  FROM random_bars OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id,
    60 as quality_rating,
    74 as price_rating,
    75 as vibe_rating,
    83 as friendliness_rating
  FROM random_bars OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id,
    89 as quality_rating,
    72 as price_rating,
    76 as vibe_rating,
    71 as friendliness_rating
  FROM random_bars OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id,
    81 as quality_rating,
    63 as price_rating,
    82 as vibe_rating,
    67 as friendliness_rating
  FROM random_bars OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id,
    86 as quality_rating,
    82 as price_rating,
    63 as vibe_rating,
    50 as friendliness_rating
  FROM random_bars OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id,
    55 as quality_rating,
    39 as price_rating,
    79 as vibe_rating,
    35 as friendliness_rating
  FROM random_bars OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id,
    79 as quality_rating,
    76 as price_rating,
    95 as vibe_rating,
    57 as friendliness_rating
  FROM random_bars OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id,
    83 as quality_rating,
    69 as price_rating,
    82 as vibe_rating,
    83 as friendliness_rating
  FROM random_bars OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id,
    78 as quality_rating,
    67 as price_rating,
    42 as vibe_rating,
    66 as friendliness_rating
  FROM random_bars OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id,
    73 as quality_rating,
    84 as price_rating,
    66 as vibe_rating,
    57 as friendliness_rating
  FROM random_bars OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id,
    66 as quality_rating,
    73 as price_rating,
    100 as vibe_rating,
    87 as friendliness_rating
  FROM random_bars OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id,
    41 as quality_rating,
    72 as price_rating,
    81 as vibe_rating,
    73 as friendliness_rating
  FROM random_bars OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id,
    53 as quality_rating,
    66 as price_rating,
    70 as vibe_rating,
    85 as friendliness_rating
  FROM random_bars OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id,
    80 as quality_rating,
    80 as price_rating,
    77 as vibe_rating,
    86 as friendliness_rating
  FROM random_bars OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id,
    100 as quality_rating,
    84 as price_rating,
    75 as vibe_rating,
    73 as friendliness_rating
  FROM random_bars OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id,
    77 as quality_rating,
    96 as price_rating,
    63 as vibe_rating,
    66 as friendliness_rating
  FROM random_bars OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id,
    34 as quality_rating,
    71 as price_rating,
    95 as vibe_rating,
    70 as friendliness_rating
  FROM random_bars OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id,
    79 as quality_rating,
    58 as price_rating,
    94 as vibe_rating,
    95 as friendliness_rating
  FROM random_bars OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id,
    95 as quality_rating,
    74 as price_rating,
    87 as vibe_rating,
    94 as friendliness_rating
  FROM random_bars OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id,
    94 as quality_rating,
    86 as price_rating,
    62 as vibe_rating,
    72 as friendliness_rating
  FROM random_bars OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id,
    82 as quality_rating,
    89 as price_rating,
    72 as vibe_rating,
    79 as friendliness_rating
  FROM random_bars OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id,
    32 as quality_rating,
    95 as price_rating,
    90 as vibe_rating,
    81 as friendliness_rating
  FROM random_bars OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id,
    91 as quality_rating,
    95 as price_rating,
    70 as vibe_rating,
    57 as friendliness_rating
  FROM random_bars OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating)
SELECT * FROM ratings_data
ON CONFLICT (bar_id) DO UPDATE SET
  quality_rating = EXCLUDED.quality_rating,
  price_rating = EXCLUDED.price_rating,
  vibe_rating = EXCLUDED.vibe_rating,
  friendliness_rating = EXCLUDED.friendliness_rating,
  updated_at = NOW();
