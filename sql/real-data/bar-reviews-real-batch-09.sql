-- RAVEN项目 - 酒吧评论数据 (批次 9)
-- 生成时间: 2025-08-23T06:00:20.218Z
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
    63 as quality_rating,
    70 as price_rating,
    94 as vibe_rating,
    100 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-02T12:23:55.246Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    65 as price_rating,
    59 as vibe_rating,
    75 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-18T06:35:32.322Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    71 as price_rating,
    65 as vibe_rating,
    90 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-03-05T01:23:34.217Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    52 as price_rating,
    72 as vibe_rating,
    84 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-03-08T14:07:22.744Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    83 as price_rating,
    74 as vibe_rating,
    97 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-07-29T10:24:44.031Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    80 as price_rating,
    91 as vibe_rating,
    91 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-30T11:25:16.673Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    86 as price_rating,
    80 as vibe_rating,
    96 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-04-11T09:35:12.807Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    55 as price_rating,
    81 as vibe_rating,
    70 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-21T02:25:12.617Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    84 as price_rating,
    97 as vibe_rating,
    93 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-06-08T01:31:40.756Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    57 as price_rating,
    66 as vibe_rating,
    72 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-13T10:26:56.835Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    81 as price_rating,
    75 as vibe_rating,
    87 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-23T16:47:25.621Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    62 as price_rating,
    81 as vibe_rating,
    67 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-04-07T10:07:50.221Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    64 as quality_rating,
    38 as price_rating,
    89 as vibe_rating,
    74 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-06-24T21:53:33.153Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    64 as price_rating,
    81 as vibe_rating,
    91 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-08T12:42:44.545Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    66 as price_rating,
    81 as vibe_rating,
    78 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-07-23T20:12:43.920Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    80 as price_rating,
    65 as vibe_rating,
    71 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-07-04T20:59:20.666Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    99 as price_rating,
    39 as vibe_rating,
    84 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-15T09:41:44.037Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    58 as price_rating,
    99 as vibe_rating,
    52 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-06-22T04:35:19.806Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    96 as price_rating,
    69 as vibe_rating,
    56 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-26T16:43:34.099Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    98 as price_rating,
    72 as vibe_rating,
    65 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-14T03:05:22.627Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    94 as price_rating,
    88 as vibe_rating,
    90 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-02T01:17:04.422Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    65 as price_rating,
    67 as vibe_rating,
    88 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-03-01T18:05:18.738Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    65 as price_rating,
    65 as vibe_rating,
    86 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    31 as queue_time,
    false as is_anonymous,
    '2025-04-08T21:13:18.717Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    82 as price_rating,
    90 as vibe_rating,
    36 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-06-27T19:39:25.814Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    67 as price_rating,
    84 as vibe_rating,
    69 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-15T18:40:19.312Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    94 as price_rating,
    84 as vibe_rating,
    83 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-15T07:09:49.540Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    59 as price_rating,
    80 as vibe_rating,
    81 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-05-22T22:58:06.995Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    93 as price_rating,
    43 as vibe_rating,
    72 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-02-28T05:43:03.388Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    54 as price_rating,
    84 as vibe_rating,
    78 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-08T13:23:01.410Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    87 as price_rating,
    84 as vibe_rating,
    51 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-25T04:10:37.396Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    41 as price_rating,
    64 as vibe_rating,
    69 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-08-20T04:15:02.372Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    37 as quality_rating,
    67 as price_rating,
    91 as vibe_rating,
    34 as friendliness_rating,
    'Service was slow and drinks were overpriced.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-04T19:55:32.587Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    56 as price_rating,
    73 as vibe_rating,
    91 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-04-03T13:35:21.530Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    97 as price_rating,
    52 as vibe_rating,
    56 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-07T05:24:54.526Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    89 as price_rating,
    67 as vibe_rating,
    67 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-06-07T04:39:12.039Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    58 as price_rating,
    82 as vibe_rating,
    91 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-21T06:35:27.213Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    66 as price_rating,
    65 as vibe_rating,
    76 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-20T09:34:08.526Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    97 as price_rating,
    58 as vibe_rating,
    56 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-07-28T16:41:23.871Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    43 as price_rating,
    86 as vibe_rating,
    85 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    28 as queue_time,
    false as is_anonymous,
    '2025-07-06T05:25:41.490Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    47 as quality_rating,
    91 as price_rating,
    65 as vibe_rating,
    37 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-28T04:05:22.433Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    83 as price_rating,
    70 as vibe_rating,
    97 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-06-30T12:49:38.881Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    75 as price_rating,
    85 as vibe_rating,
    81 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-07-21T15:41:23.843Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    98 as price_rating,
    98 as vibe_rating,
    58 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    36 as queue_time,
    true as is_anonymous,
    '2025-07-19T09:18:56.893Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    47 as price_rating,
    83 as vibe_rating,
    56 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-04T04:32:11.798Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    50 as price_rating,
    66 as vibe_rating,
    84 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-07-05T12:55:31.955Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    90 as price_rating,
    85 as vibe_rating,
    62 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-29T22:52:21.342Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    63 as price_rating,
    56 as vibe_rating,
    68 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-07-05T05:37:48.603Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    70 as price_rating,
    50 as vibe_rating,
    78 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    41 as queue_time,
    true as is_anonymous,
    '2025-06-18T01:33:28.391Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    100 as price_rating,
    58 as vibe_rating,
    82 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    33 as queue_time,
    true as is_anonymous,
    '2025-08-18T01:24:11.606Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    97 as price_rating,
    60 as vibe_rating,
    97 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-09T00:54:33.054Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    95 as price_rating,
    71 as vibe_rating,
    36 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-29T10:04:51.258Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    87 as price_rating,
    51 as vibe_rating,
    55 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-08-13T18:56:18.587Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    57 as price_rating,
    85 as vibe_rating,
    74 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    26 as queue_time,
    false as is_anonymous,
    '2025-07-04T03:21:23.057Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    80 as price_rating,
    60 as vibe_rating,
    85 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-08-03T09:37:40.538Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    81 as price_rating,
    75 as vibe_rating,
    89 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-04-11T14:50:13.045Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    33 as price_rating,
    70 as vibe_rating,
    66 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-21T02:19:24.778Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    48 as price_rating,
    64 as vibe_rating,
    56 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    41 as queue_time,
    true as is_anonymous,
    '2025-07-13T22:15:39.544Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    44 as quality_rating,
    78 as price_rating,
    89 as vibe_rating,
    67 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    22 as queue_time,
    false as is_anonymous,
    '2025-04-22T14:07:41.016Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    73 as price_rating,
    77 as vibe_rating,
    85 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-03-11T19:26:31.383Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    65 as price_rating,
    82 as vibe_rating,
    84 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-07T04:11:44.229Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    67 as price_rating,
    38 as vibe_rating,
    60 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-07-22T16:55:02.418Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    80 as price_rating,
    71 as vibe_rating,
    53 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-08T19:21:11.122Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    67 as price_rating,
    49 as vibe_rating,
    75 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-03-17T14:10:01.744Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    86 as price_rating,
    44 as vibe_rating,
    72 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    25 as queue_time,
    false as is_anonymous,
    '2025-03-21T16:57:24.412Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    88 as price_rating,
    98 as vibe_rating,
    77 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-04T10:20:13.156Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    86 as price_rating,
    61 as vibe_rating,
    97 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-11T21:13:37.194Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    90 as price_rating,
    43 as vibe_rating,
    70 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    31 as queue_time,
    false as is_anonymous,
    '2025-04-03T23:12:49.432Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    68 as price_rating,
    78 as vibe_rating,
    88 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-06-28T20:56:24.502Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    67 as price_rating,
    76 as vibe_rating,
    82 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-10T10:16:39.698Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    72 as price_rating,
    70 as vibe_rating,
    84 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    26 as queue_time,
    true as is_anonymous,
    '2025-03-02T00:20:19.864Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    54 as price_rating,
    57 as vibe_rating,
    53 as friendliness_rating,
    '价格太贵了，而且服务态度不好。' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-03-30T04:54:19.871Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    100 as price_rating,
    62 as vibe_rating,
    56 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-08-16T23:03:17.130Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    65 as price_rating,
    72 as vibe_rating,
    61 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-08T19:40:21.123Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    89 as price_rating,
    57 as vibe_rating,
    60 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-11T12:41:04.266Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    54 as price_rating,
    85 as vibe_rating,
    37 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-05-16T20:15:13.478Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    52 as price_rating,
    85 as vibe_rating,
    82 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-04-01T08:49:48.288Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    50 as price_rating,
    84 as vibe_rating,
    51 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-05-01T06:11:56.836Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    90 as price_rating,
    73 as vibe_rating,
    67 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-05-26T19:52:44.020Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    100 as price_rating,
    61 as vibe_rating,
    93 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    26 as queue_time,
    false as is_anonymous,
    '2025-07-04T20:15:40.461Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    95 as price_rating,
    91 as vibe_rating,
    89 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-09T05:44:57.257Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    87 as price_rating,
    75 as vibe_rating,
    100 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-07-02T21:10:10.334Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    84 as price_rating,
    83 as vibe_rating,
    53 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    41 as queue_time,
    false as is_anonymous,
    '2025-07-21T14:39:32.154Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    95 as price_rating,
    68 as vibe_rating,
    60 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-03-25T10:15:29.237Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    36 as quality_rating,
    95 as price_rating,
    88 as vibe_rating,
    75 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-09T22:13:35.577Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    51 as price_rating,
    78 as vibe_rating,
    85 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-06-19T14:34:09.051Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    89 as price_rating,
    70 as vibe_rating,
    78 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-06-02T08:59:10.214Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    70 as price_rating,
    51 as vibe_rating,
    69 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-06T02:12:11.929Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    80 as price_rating,
    84 as vibe_rating,
    78 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-05-19T17:51:54.206Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    72 as price_rating,
    83 as vibe_rating,
    97 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-24T05:39:30.327Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    59 as price_rating,
    82 as vibe_rating,
    56 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-08-22T02:51:38.928Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    67 as price_rating,
    99 as vibe_rating,
    76 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    2 as queue_time,
    true as is_anonymous,
    '2025-08-14T04:44:22.957Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    54 as price_rating,
    100 as vibe_rating,
    74 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-05-13T11:10:04.752Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    47 as price_rating,
    90 as vibe_rating,
    84 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-14T12:53:44.111Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    96 as price_rating,
    87 as vibe_rating,
    94 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-15T14:42:36.656Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    35 as price_rating,
    74 as vibe_rating,
    77 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-02-28T21:14:36.388Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    68 as price_rating,
    56 as vibe_rating,
    90 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-20T21:20:35.491Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    74 as price_rating,
    92 as vibe_rating,
    51 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-03-05T14:34:03.245Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    57 as price_rating,
    52 as vibe_rating,
    52 as friendliness_rating,
    '价格太贵了，而且服务态度不好。' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-04-19T23:54:22.923Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    84 as price_rating,
    92 as vibe_rating,
    78 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-05T12:54:02.721Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    83 as price_rating,
    83 as vibe_rating,
    85 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-27T05:18:37.895Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
