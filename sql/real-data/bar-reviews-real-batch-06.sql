-- RAVEN项目 - 酒吧评论数据 (批次 6)
-- 生成时间: 2025-08-23T06:00:20.205Z
-- 记录数: 100
-- 使用现有bars和auth.users中的真实数据

-- 为随机选择的现有酒吧和用户生成评论数据
WITH random_combinations AS (
  SELECT 
    b.id as bar_id,
    u.id as user_id
  FROM public.bars b
  CROSS JOIN auth.users u
  ORDER BY RANDOM()
  LIMIT 100
),
review_data AS (
  SELECT 
    bar_id,
    user_id,
    89 as quality_rating,
    83 as price_rating,
    85 as vibe_rating,
    54 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-07T19:27:56.503Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    100 as price_rating,
    72 as vibe_rating,
    88 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-07-03T11:32:02.288Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    85 as price_rating,
    97 as vibe_rating,
    85 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-02-28T03:15:07.062Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    100 as price_rating,
    77 as vibe_rating,
    81 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-21T21:08:07.661Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    65 as price_rating,
    88 as vibe_rating,
    97 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-11T19:35:54.701Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    42 as quality_rating,
    72 as price_rating,
    67 as vibe_rating,
    63 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-06-25T20:12:01.247Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    82 as price_rating,
    61 as vibe_rating,
    73 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-14T16:27:49.394Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    84 as price_rating,
    67 as vibe_rating,
    94 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-15T12:35:41.573Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    45 as price_rating,
    80 as vibe_rating,
    57 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    28 as queue_time,
    false as is_anonymous,
    '2025-06-02T08:03:53.538Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    37 as price_rating,
    100 as vibe_rating,
    84 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-06-05T06:51:13.969Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    50 as price_rating,
    65 as vibe_rating,
    91 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-12T04:12:53.158Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    100 as price_rating,
    81 as vibe_rating,
    68 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-17T03:41:41.999Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    95 as price_rating,
    90 as vibe_rating,
    68 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-05-27T20:02:44.229Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    82 as price_rating,
    93 as vibe_rating,
    92 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-08-08T07:01:51.082Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    50 as price_rating,
    53 as vibe_rating,
    70 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    34 as queue_time,
    false as is_anonymous,
    '2025-03-15T02:30:48.512Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    84 as price_rating,
    69 as vibe_rating,
    92 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-23T02:47:30.452Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    39 as price_rating,
    86 as vibe_rating,
    83 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-02T17:37:43.164Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    36 as quality_rating,
    56 as price_rating,
    32 as vibe_rating,
    90 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    31 as queue_time,
    false as is_anonymous,
    '2025-08-12T22:12:10.124Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    51 as price_rating,
    86 as vibe_rating,
    91 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-07-17T09:07:14.842Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    67 as price_rating,
    84 as vibe_rating,
    43 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-28T13:19:20.108Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    84 as price_rating,
    52 as vibe_rating,
    83 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    22 as queue_time,
    false as is_anonymous,
    '2025-08-21T19:28:45.103Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    66 as price_rating,
    57 as vibe_rating,
    97 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-14T18:45:00.145Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    82 as price_rating,
    98 as vibe_rating,
    89 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-02-27T21:01:42.535Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    53 as price_rating,
    67 as vibe_rating,
    97 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-11T12:42:12.820Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    90 as price_rating,
    54 as vibe_rating,
    59 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    13 as queue_time,
    false as is_anonymous,
    '2025-07-07T19:48:57.706Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    94 as price_rating,
    70 as vibe_rating,
    73 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-12T22:13:05.682Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    87 as price_rating,
    92 as vibe_rating,
    66 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    43 as queue_time,
    false as is_anonymous,
    '2025-03-30T01:06:59.351Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    92 as price_rating,
    90 as vibe_rating,
    94 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-07-13T03:31:10.837Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    82 as price_rating,
    80 as vibe_rating,
    59 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-03-22T22:07:07.296Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    69 as price_rating,
    65 as vibe_rating,
    84 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-05-29T15:49:22.621Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    60 as price_rating,
    59 as vibe_rating,
    71 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    2 as queue_time,
    true as is_anonymous,
    '2025-05-14T13:05:21.766Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    71 as price_rating,
    84 as vibe_rating,
    50 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-08-15T04:22:53.526Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    92 as price_rating,
    66 as vibe_rating,
    80 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-05-11T15:42:39.532Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    75 as price_rating,
    92 as vibe_rating,
    74 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    33 as queue_time,
    true as is_anonymous,
    '2025-05-17T05:45:18.313Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    98 as price_rating,
    100 as vibe_rating,
    65 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-07-06T06:45:18.035Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    90 as price_rating,
    82 as vibe_rating,
    67 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-06-11T14:51:04.069Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    75 as price_rating,
    94 as vibe_rating,
    82 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-03-14T12:12:39.317Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    56 as price_rating,
    95 as vibe_rating,
    81 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-06T14:47:22.500Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    93 as price_rating,
    73 as vibe_rating,
    71 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-30T01:42:13.469Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    71 as price_rating,
    75 as vibe_rating,
    84 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-07-06T15:45:12.719Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    85 as price_rating,
    58 as vibe_rating,
    84 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-03-18T14:42:03.956Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    82 as price_rating,
    91 as vibe_rating,
    71 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    16 as queue_time,
    true as is_anonymous,
    '2025-07-24T15:20:18.180Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    37 as price_rating,
    87 as vibe_rating,
    71 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-03-02T02:56:28.162Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    55 as price_rating,
    49 as vibe_rating,
    85 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-07-06T14:17:14.156Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    96 as price_rating,
    83 as vibe_rating,
    83 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-07-28T08:23:45.584Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    99 as price_rating,
    32 as vibe_rating,
    81 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    8 as queue_time,
    true as is_anonymous,
    '2025-07-25T21:41:29.127Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    50 as price_rating,
    58 as vibe_rating,
    89 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-03-15T07:14:43.310Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    98 as price_rating,
    97 as vibe_rating,
    81 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-08-18T18:54:46.164Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    91 as price_rating,
    93 as vibe_rating,
    80 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-08-16T04:25:55.165Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    85 as price_rating,
    81 as vibe_rating,
    84 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-22T10:35:24.602Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    35 as price_rating,
    58 as vibe_rating,
    53 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-04T01:46:53.116Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    73 as price_rating,
    86 as vibe_rating,
    91 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-07-22T01:34:18.111Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    31 as quality_rating,
    70 as price_rating,
    83 as vibe_rating,
    80 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    32 as queue_time,
    false as is_anonymous,
    '2025-06-15T02:04:01.153Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    44 as quality_rating,
    75 as price_rating,
    69 as vibe_rating,
    70 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-06-26T11:35:47.143Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    83 as price_rating,
    75 as vibe_rating,
    52 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-03-23T21:41:16.589Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    51 as price_rating,
    57 as vibe_rating,
    84 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-03-13T19:49:36.638Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    93 as price_rating,
    84 as vibe_rating,
    79 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-06-05T20:56:34.616Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    43 as price_rating,
    70 as vibe_rating,
    84 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-17T01:55:04.412Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    92 as price_rating,
    67 as vibe_rating,
    84 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-03-13T08:48:29.953Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    90 as price_rating,
    69 as vibe_rating,
    99 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-19T05:13:24.426Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    41 as price_rating,
    95 as vibe_rating,
    85 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-08-19T17:57:38.797Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    35 as price_rating,
    84 as vibe_rating,
    78 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-03-29T23:39:30.620Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    70 as price_rating,
    61 as vibe_rating,
    82 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-05-01T19:38:09.818Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    54 as price_rating,
    75 as vibe_rating,
    42 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-08-02T06:29:48.758Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    83 as price_rating,
    73 as vibe_rating,
    82 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    31 as queue_time,
    false as is_anonymous,
    '2025-05-22T22:20:44.644Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    68 as price_rating,
    67 as vibe_rating,
    64 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    27 as queue_time,
    false as is_anonymous,
    '2025-07-14T01:24:18.241Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    85 as price_rating,
    94 as vibe_rating,
    50 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-13T20:52:57.875Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    82 as price_rating,
    74 as vibe_rating,
    90 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-12T12:46:17.806Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    93 as price_rating,
    68 as vibe_rating,
    53 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-07-19T04:35:53.021Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    72 as price_rating,
    100 as vibe_rating,
    95 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-04-28T17:36:59.779Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    95 as price_rating,
    84 as vibe_rating,
    95 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-10T15:11:47.531Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    72 as price_rating,
    94 as vibe_rating,
    91 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-03-15T22:42:51.729Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    69 as price_rating,
    86 as vibe_rating,
    69 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-07-05T02:51:25.896Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    53 as price_rating,
    69 as vibe_rating,
    85 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-08-05T00:13:29.060Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    99 as price_rating,
    84 as vibe_rating,
    77 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    14 as queue_time,
    false as is_anonymous,
    '2025-06-04T20:38:30.000Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    59 as price_rating,
    72 as vibe_rating,
    59 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-26T19:28:54.956Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    72 as price_rating,
    80 as vibe_rating,
    84 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-30T09:44:10.791Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    79 as price_rating,
    82 as vibe_rating,
    69 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-05-24T18:51:19.362Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    32 as quality_rating,
    97 as price_rating,
    85 as vibe_rating,
    100 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-23T00:43:42.622Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    95 as price_rating,
    52 as vibe_rating,
    99 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-06-05T18:55:26.338Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    50 as price_rating,
    78 as vibe_rating,
    81 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-06-11T23:37:57.172Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    90 as price_rating,
    91 as vibe_rating,
    98 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-13T12:50:58.379Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    86 as price_rating,
    59 as vibe_rating,
    97 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    37 as queue_time,
    false as is_anonymous,
    '2025-05-23T09:48:37.376Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    38 as quality_rating,
    95 as price_rating,
    95 as vibe_rating,
    83 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-03-31T12:32:12.041Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    93 as price_rating,
    54 as vibe_rating,
    65 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-08-21T18:59:51.832Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    86 as price_rating,
    87 as vibe_rating,
    83 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-04-26T22:27:18.947Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    45 as price_rating,
    35 as vibe_rating,
    88 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-03-14T09:13:45.709Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    73 as price_rating,
    76 as vibe_rating,
    90 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-12T16:02:01.542Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    60 as price_rating,
    94 as vibe_rating,
    87 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-05T01:38:39.953Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    58 as price_rating,
    80 as vibe_rating,
    89 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-14T10:12:13.473Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    50 as price_rating,
    73 as vibe_rating,
    84 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-04-24T21:10:32.956Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    65 as price_rating,
    81 as vibe_rating,
    88 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-03-19T08:29:51.853Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    83 as price_rating,
    59 as vibe_rating,
    69 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-06-17T06:53:40.918Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    81 as price_rating,
    95 as vibe_rating,
    77 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-08-10T09:08:39.402Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    69 as price_rating,
    72 as vibe_rating,
    79 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-14T16:22:33.449Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    80 as price_rating,
    69 as vibe_rating,
    100 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-03-20T03:26:28.364Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    43 as price_rating,
    67 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-01T03:20:07.056Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    82 as price_rating,
    57 as vibe_rating,
    89 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-25T04:56:52.671Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    84 as price_rating,
    82 as vibe_rating,
    96 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-30T23:54:28.231Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    75 as price_rating,
    53 as vibe_rating,
    84 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-28T02:33:11.043Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
