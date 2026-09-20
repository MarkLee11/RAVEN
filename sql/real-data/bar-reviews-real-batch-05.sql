-- RAVEN项目 - 酒吧评论数据 (批次 5)
-- 生成时间: 2025-08-23T06:00:20.199Z
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
    86 as quality_rating,
    37 as price_rating,
    92 as vibe_rating,
    89 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-17T02:55:39.705Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    76 as price_rating,
    51 as vibe_rating,
    98 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-05T04:17:40.188Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    59 as price_rating,
    68 as vibe_rating,
    64 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-05-08T23:11:57.400Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    90 as price_rating,
    91 as vibe_rating,
    74 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    37 as queue_time,
    true as is_anonymous,
    '2025-05-18T10:52:15.884Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    75 as price_rating,
    60 as vibe_rating,
    52 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-06-14T11:31:41.304Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    54 as price_rating,
    69 as vibe_rating,
    71 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-03-26T22:13:51.483Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    90 as price_rating,
    65 as vibe_rating,
    78 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    22 as queue_time,
    false as is_anonymous,
    '2025-05-30T08:07:07.823Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    89 as price_rating,
    58 as vibe_rating,
    84 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-04-15T21:49:19.099Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    92 as price_rating,
    90 as vibe_rating,
    68 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-05-30T17:45:15.694Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    94 as price_rating,
    84 as vibe_rating,
    67 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-30T00:00:45.170Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    67 as price_rating,
    84 as vibe_rating,
    100 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-03-13T09:33:55.366Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    81 as price_rating,
    78 as vibe_rating,
    72 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    9 as queue_time,
    false as is_anonymous,
    '2025-05-16T23:12:07.013Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    59 as price_rating,
    87 as vibe_rating,
    57 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-04-04T06:10:05.087Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    65 as price_rating,
    87 as vibe_rating,
    94 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-05-21T08:11:15.142Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    83 as price_rating,
    78 as vibe_rating,
    31 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    36 as queue_time,
    true as is_anonymous,
    '2025-03-29T07:45:09.498Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    73 as price_rating,
    76 as vibe_rating,
    63 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-16T04:48:04.414Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    96 as price_rating,
    31 as vibe_rating,
    85 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-11T22:55:56.033Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    60 as price_rating,
    99 as vibe_rating,
    99 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-04-22T07:42:26.939Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    91 as price_rating,
    65 as vibe_rating,
    94 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-06-05T17:45:38.240Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    63 as price_rating,
    48 as vibe_rating,
    74 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-03-15T02:02:50.903Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    71 as price_rating,
    85 as vibe_rating,
    88 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-25T21:41:25.775Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    83 as price_rating,
    84 as vibe_rating,
    59 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-07-30T01:44:48.914Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    86 as price_rating,
    33 as vibe_rating,
    80 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-07-05T15:00:07.376Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    42 as price_rating,
    73 as vibe_rating,
    73 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-04-02T23:21:53.255Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    69 as price_rating,
    68 as vibe_rating,
    100 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-08-06T09:06:17.786Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    82 as price_rating,
    84 as vibe_rating,
    96 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-07-27T11:40:33.071Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    57 as price_rating,
    85 as vibe_rating,
    99 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    26 as queue_time,
    true as is_anonymous,
    '2025-08-05T03:32:18.184Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    48 as price_rating,
    67 as vibe_rating,
    69 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-08-15T09:17:00.385Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    54 as price_rating,
    96 as vibe_rating,
    48 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-14T00:27:25.950Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    33 as quality_rating,
    70 as price_rating,
    58 as vibe_rating,
    81 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-08-16T11:12:40.475Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    88 as price_rating,
    86 as vibe_rating,
    75 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-04-10T06:44:46.586Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    85 as price_rating,
    87 as vibe_rating,
    69 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-03-06T23:21:20.090Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    95 as price_rating,
    77 as vibe_rating,
    63 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-16T12:40:29.084Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    32 as quality_rating,
    92 as price_rating,
    89 as vibe_rating,
    74 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-28T04:51:04.366Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    97 as price_rating,
    76 as vibe_rating,
    76 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-03-17T00:58:08.197Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    98 as price_rating,
    94 as vibe_rating,
    93 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-04T10:06:04.054Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    60 as price_rating,
    86 as vibe_rating,
    72 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-06-09T01:46:22.195Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    95 as price_rating,
    50 as vibe_rating,
    91 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-05-24T20:14:16.558Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    85 as price_rating,
    63 as vibe_rating,
    66 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-05-27T08:36:17.122Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    84 as price_rating,
    92 as vibe_rating,
    73 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-06-21T00:43:45.629Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    84 as price_rating,
    90 as vibe_rating,
    76 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    27 as queue_time,
    false as is_anonymous,
    '2025-07-25T03:20:55.723Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    60 as price_rating,
    66 as vibe_rating,
    60 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    40 as queue_time,
    false as is_anonymous,
    '2025-06-06T14:11:39.994Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    74 as price_rating,
    66 as vibe_rating,
    72 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    8 as queue_time,
    true as is_anonymous,
    '2025-06-03T23:33:41.698Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    42 as price_rating,
    92 as vibe_rating,
    46 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-06-13T02:17:31.532Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    40 as price_rating,
    89 as vibe_rating,
    84 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    2 as queue_time,
    true as is_anonymous,
    '2025-08-10T22:17:34.079Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    83 as price_rating,
    70 as vibe_rating,
    93 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-05-26T23:53:26.798Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    62 as price_rating,
    59 as vibe_rating,
    81 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-05T18:49:06.791Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    77 as price_rating,
    88 as vibe_rating,
    55 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-04-23T13:38:24.193Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    99 as price_rating,
    91 as vibe_rating,
    57 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    25 as queue_time,
    false as is_anonymous,
    '2025-03-09T08:56:02.646Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    50 as price_rating,
    87 as vibe_rating,
    91 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-06-17T14:22:22.452Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    52 as price_rating,
    78 as vibe_rating,
    90 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-03-03T22:16:17.801Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    82 as price_rating,
    71 as vibe_rating,
    71 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-31T03:53:30.538Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    56 as price_rating,
    86 as vibe_rating,
    71 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-30T07:38:39.983Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    81 as price_rating,
    59 as vibe_rating,
    77 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-08-14T16:50:03.838Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    82 as price_rating,
    75 as vibe_rating,
    36 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-04-17T00:14:24.844Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    85 as price_rating,
    93 as vibe_rating,
    81 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-05-01T08:03:06.035Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    49 as quality_rating,
    51 as price_rating,
    65 as vibe_rating,
    57 as friendliness_rating,
    'Too crowded and expensive for what you get.' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-03-23T23:06:49.511Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    50 as price_rating,
    93 as vibe_rating,
    70 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-07-03T12:49:20.207Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    98 as price_rating,
    71 as vibe_rating,
    97 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-07-16T07:03:36.520Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    71 as price_rating,
    64 as vibe_rating,
    55 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-11T09:03:20.658Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    82 as price_rating,
    80 as vibe_rating,
    74 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-06-15T05:17:16.459Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    76 as price_rating,
    69 as vibe_rating,
    96 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-06-22T21:51:50.796Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    87 as price_rating,
    54 as vibe_rating,
    82 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-04-12T12:27:58.433Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    83 as price_rating,
    81 as vibe_rating,
    83 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-04T04:16:32.827Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    82 as price_rating,
    66 as vibe_rating,
    74 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-06-22T01:24:24.554Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    83 as price_rating,
    64 as vibe_rating,
    97 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-04-14T04:53:30.830Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    83 as price_rating,
    89 as vibe_rating,
    96 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-25T13:38:24.804Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    51 as price_rating,
    97 as vibe_rating,
    82 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-03-03T03:32:48.138Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    83 as price_rating,
    72 as vibe_rating,
    80 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    24 as queue_time,
    false as is_anonymous,
    '2025-02-24T06:55:22.264Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    92 as price_rating,
    91 as vibe_rating,
    84 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-03-20T07:01:20.545Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    86 as price_rating,
    92 as vibe_rating,
    45 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-05-16T09:06:07.587Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    89 as price_rating,
    83 as vibe_rating,
    54 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-04-27T15:02:01.078Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    64 as quality_rating,
    100 as price_rating,
    72 as vibe_rating,
    97 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-19T01:33:55.922Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    81 as price_rating,
    72 as vibe_rating,
    68 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-07-05T18:42:49.626Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    68 as price_rating,
    61 as vibe_rating,
    83 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    22 as queue_time,
    false as is_anonymous,
    '2025-08-03T18:57:41.360Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    95 as price_rating,
    99 as vibe_rating,
    100 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-02-25T11:23:39.839Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    65 as price_rating,
    82 as vibe_rating,
    92 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-25T01:50:00.978Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    68 as price_rating,
    51 as vibe_rating,
    73 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-02-27T05:15:36.974Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    99 as price_rating,
    65 as vibe_rating,
    83 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-03-26T07:17:02.355Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    52 as price_rating,
    82 as vibe_rating,
    86 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-04-29T06:23:54.395Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    33 as price_rating,
    82 as vibe_rating,
    92 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-26T16:06:52.711Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    98 as price_rating,
    65 as vibe_rating,
    99 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-18T21:43:00.717Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    69 as price_rating,
    85 as vibe_rating,
    96 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-04-10T13:00:27.835Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    35 as quality_rating,
    48 as price_rating,
    36 as vibe_rating,
    67 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-03-29T06:42:51.247Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    66 as price_rating,
    99 as vibe_rating,
    99 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-08T14:27:41.934Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    69 as price_rating,
    57 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-27T06:44:25.652Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    100 as price_rating,
    75 as vibe_rating,
    85 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-07T00:08:07.181Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    57 as price_rating,
    89 as vibe_rating,
    85 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-14T17:18:02.420Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    57 as price_rating,
    73 as vibe_rating,
    73 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    37 as queue_time,
    true as is_anonymous,
    '2025-07-04T01:56:34.894Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    49 as price_rating,
    81 as vibe_rating,
    69 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-03-31T11:46:09.767Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    100 as price_rating,
    78 as vibe_rating,
    93 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-03-17T15:42:21.701Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    75 as price_rating,
    81 as vibe_rating,
    73 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-06-03T19:49:54.616Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    78 as price_rating,
    73 as vibe_rating,
    74 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-05-25T06:48:02.501Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    92 as price_rating,
    94 as vibe_rating,
    50 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-07-15T01:21:49.395Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    42 as quality_rating,
    67 as price_rating,
    97 as vibe_rating,
    63 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-27T14:37:31.625Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    63 as price_rating,
    47 as vibe_rating,
    44 as friendliness_rating,
    'Too crowded and expensive for what you get.' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-04-06T12:00:13.578Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    59 as price_rating,
    86 as vibe_rating,
    73 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-07-04T09:42:23.505Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    86 as price_rating,
    63 as vibe_rating,
    36 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-02-24T10:25:49.330Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    50 as price_rating,
    84 as vibe_rating,
    98 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-28T01:32:30.573Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    48 as price_rating,
    86 as vibe_rating,
    71 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    31 as queue_time,
    true as is_anonymous,
    '2025-07-14T19:12:54.496Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
