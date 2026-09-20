-- RAVEN项目 - 酒吧评论数据 (批次 4)
-- 生成时间: 2025-08-23T06:00:20.194Z
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
    50 as quality_rating,
    97 as price_rating,
    54 as vibe_rating,
    84 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-08-12T23:00:35.538Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    61 as price_rating,
    100 as vibe_rating,
    100 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-19T16:56:14.004Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    83 as price_rating,
    70 as vibe_rating,
    85 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-20T20:52:16.127Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    82 as price_rating,
    93 as vibe_rating,
    70 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-01T17:25:11.736Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    50 as price_rating,
    92 as vibe_rating,
    83 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-03-22T05:03:51.200Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    65 as price_rating,
    50 as vibe_rating,
    75 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-05-09T14:13:41.191Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    41 as price_rating,
    92 as vibe_rating,
    74 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-24T12:34:27.758Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    100 as price_rating,
    92 as vibe_rating,
    84 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-04-19T06:36:23.714Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    67 as price_rating,
    82 as vibe_rating,
    46 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    44 as queue_time,
    false as is_anonymous,
    '2025-07-19T13:14:35.846Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    96 as price_rating,
    98 as vibe_rating,
    86 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-05-26T15:14:18.407Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    88 as price_rating,
    33 as vibe_rating,
    50 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-08-18T11:36:00.967Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    92 as price_rating,
    78 as vibe_rating,
    80 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-24T18:47:23.260Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    92 as price_rating,
    98 as vibe_rating,
    70 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-30T16:56:17.887Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    61 as price_rating,
    82 as vibe_rating,
    70 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-05T12:08:54.821Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    74 as price_rating,
    68 as vibe_rating,
    69 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    32 as queue_time,
    false as is_anonymous,
    '2025-08-09T10:52:49.305Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    48 as quality_rating,
    98 as price_rating,
    68 as vibe_rating,
    81 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    33 as queue_time,
    true as is_anonymous,
    '2025-07-17T10:50:44.047Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    50 as price_rating,
    90 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-05-22T03:02:05.149Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    52 as price_rating,
    80 as vibe_rating,
    88 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    19 as queue_time,
    false as is_anonymous,
    '2025-05-13T21:35:04.785Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    77 as price_rating,
    81 as vibe_rating,
    67 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-05-31T00:29:09.705Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    80 as price_rating,
    53 as vibe_rating,
    85 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    8 as queue_time,
    true as is_anonymous,
    '2025-07-25T00:52:02.393Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    80 as price_rating,
    85 as vibe_rating,
    59 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-08-05T11:54:56.696Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    72 as price_rating,
    64 as vibe_rating,
    80 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-07-06T15:10:06.399Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    81 as price_rating,
    70 as vibe_rating,
    59 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-07-03T06:16:30.328Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    81 as price_rating,
    47 as vibe_rating,
    66 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-10T19:06:29.570Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    67 as price_rating,
    84 as vibe_rating,
    85 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-04-11T20:54:16.849Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    80 as price_rating,
    92 as vibe_rating,
    94 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-08-16T03:48:49.521Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    45 as price_rating,
    81 as vibe_rating,
    92 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-03-16T13:44:44.672Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    91 as price_rating,
    91 as vibe_rating,
    37 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-04-29T07:26:27.297Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    91 as price_rating,
    68 as vibe_rating,
    90 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    42 as queue_time,
    false as is_anonymous,
    '2025-06-24T23:02:42.005Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    75 as price_rating,
    71 as vibe_rating,
    99 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-04-27T23:57:32.537Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    55 as price_rating,
    99 as vibe_rating,
    65 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-29T05:58:33.351Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    66 as price_rating,
    67 as vibe_rating,
    81 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-07-17T01:47:47.093Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    79 as price_rating,
    57 as vibe_rating,
    74 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-05-08T05:09:36.225Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    65 as price_rating,
    93 as vibe_rating,
    78 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-07-01T18:04:20.750Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    56 as price_rating,
    84 as vibe_rating,
    87 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-07-03T04:28:57.972Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    86 as price_rating,
    83 as vibe_rating,
    72 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-24T07:58:55.217Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    96 as price_rating,
    70 as vibe_rating,
    84 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    41 as queue_time,
    false as is_anonymous,
    '2025-03-14T10:17:12.537Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    92 as price_rating,
    50 as vibe_rating,
    88 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-31T03:40:16.459Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    97 as price_rating,
    92 as vibe_rating,
    79 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-03-23T09:00:10.249Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    68 as price_rating,
    92 as vibe_rating,
    32 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-21T11:24:19.783Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    52 as price_rating,
    100 as vibe_rating,
    75 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    9 as queue_time,
    false as is_anonymous,
    '2025-05-17T12:44:30.772Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    80 as price_rating,
    76 as vibe_rating,
    70 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-22T21:57:45.230Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    80 as price_rating,
    100 as vibe_rating,
    84 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-08-17T15:46:38.296Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    85 as price_rating,
    59 as vibe_rating,
    73 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-31T01:26:04.993Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    68 as price_rating,
    83 as vibe_rating,
    67 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    31 as queue_time,
    true as is_anonymous,
    '2025-07-04T01:57:13.814Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    60 as price_rating,
    79 as vibe_rating,
    30 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-02-26T22:58:41.730Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    69 as price_rating,
    51 as vibe_rating,
    91 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-08-10T23:04:52.953Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    82 as price_rating,
    65 as vibe_rating,
    88 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    28 as queue_time,
    false as is_anonymous,
    '2025-07-03T08:36:50.490Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    93 as price_rating,
    96 as vibe_rating,
    81 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-15T15:15:27.032Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    50 as price_rating,
    74 as vibe_rating,
    67 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-04-24T19:02:38.064Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    34 as quality_rating,
    77 as price_rating,
    93 as vibe_rating,
    89 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-08-20T18:42:49.839Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    85 as price_rating,
    49 as vibe_rating,
    91 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-04-14T11:33:12.227Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    93 as price_rating,
    68 as vibe_rating,
    99 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-05-23T06:10:55.536Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    76 as price_rating,
    67 as vibe_rating,
    92 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-21T10:43:51.084Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    55 as price_rating,
    80 as vibe_rating,
    85 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    42 as queue_time,
    false as is_anonymous,
    '2025-04-04T21:56:57.744Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    86 as price_rating,
    66 as vibe_rating,
    72 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-03T04:36:33.049Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    65 as price_rating,
    81 as vibe_rating,
    81 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-06-04T07:36:15.353Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    72 as price_rating,
    85 as vibe_rating,
    84 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-16T17:09:33.008Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    79 as price_rating,
    67 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-06-21T00:06:37.763Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    35 as quality_rating,
    84 as price_rating,
    81 as vibe_rating,
    83 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-07-01T02:06:17.701Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    60 as price_rating,
    100 as vibe_rating,
    67 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    41 as queue_time,
    true as is_anonymous,
    '2025-05-18T23:12:08.071Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    43 as price_rating,
    84 as vibe_rating,
    81 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-09T00:17:55.836Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    84 as price_rating,
    85 as vibe_rating,
    86 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-07-22T00:06:47.263Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    87 as price_rating,
    92 as vibe_rating,
    49 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-04-28T19:33:22.899Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    78 as price_rating,
    90 as vibe_rating,
    95 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-01T02:25:24.336Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    81 as price_rating,
    81 as vibe_rating,
    61 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-07-09T16:17:13.711Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    53 as price_rating,
    98 as vibe_rating,
    81 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-02-27T14:25:27.970Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    48 as price_rating,
    48 as vibe_rating,
    80 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-30T18:31:47.506Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    55 as price_rating,
    84 as vibe_rating,
    84 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-06-01T12:59:15.777Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    95 as price_rating,
    46 as vibe_rating,
    32 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    42 as queue_time,
    false as is_anonymous,
    '2025-05-25T23:36:17.836Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    48 as quality_rating,
    90 as price_rating,
    65 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-26T00:28:10.306Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    68 as price_rating,
    97 as vibe_rating,
    56 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-02-26T05:09:49.530Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    84 as price_rating,
    74 as vibe_rating,
    73 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-30T06:06:31.564Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    70 as price_rating,
    83 as vibe_rating,
    65 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-02T09:12:46.854Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    81 as price_rating,
    82 as vibe_rating,
    66 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    32 as queue_time,
    false as is_anonymous,
    '2025-06-11T19:42:58.668Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    68 as price_rating,
    56 as vibe_rating,
    82 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-19T17:25:12.372Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    85 as price_rating,
    74 as vibe_rating,
    75 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-07-25T07:21:54.093Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    92 as price_rating,
    82 as vibe_rating,
    83 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-25T23:38:32.538Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    73 as price_rating,
    100 as vibe_rating,
    67 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-03-18T11:29:07.539Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    89 as price_rating,
    94 as vibe_rating,
    48 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-06T04:36:05.691Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    95 as price_rating,
    57 as vibe_rating,
    82 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-03T07:07:44.246Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    33 as price_rating,
    85 as vibe_rating,
    51 as friendliness_rating,
    'Too crowded and expensive for what you get.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-03-23T04:37:49.846Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    82 as price_rating,
    88 as vibe_rating,
    96 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-08-08T05:39:58.666Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    78 as price_rating,
    79 as vibe_rating,
    85 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-23T08:07:37.359Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    65 as price_rating,
    100 as vibe_rating,
    65 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-25T02:41:56.835Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    63 as price_rating,
    91 as vibe_rating,
    93 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-22T07:31:51.149Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    92 as price_rating,
    58 as vibe_rating,
    66 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-08-14T23:38:10.871Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    62 as price_rating,
    63 as vibe_rating,
    91 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-14T05:13:58.770Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    35 as quality_rating,
    72 as price_rating,
    74 as vibe_rating,
    98 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    9 as queue_time,
    false as is_anonymous,
    '2025-06-15T12:05:56.987Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    84 as price_rating,
    71 as vibe_rating,
    87 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-04-12T01:11:59.213Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    87 as price_rating,
    84 as vibe_rating,
    78 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-04-05T09:59:47.526Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    81 as price_rating,
    84 as vibe_rating,
    92 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-20T12:40:24.619Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    97 as price_rating,
    99 as vibe_rating,
    80 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-18T15:47:37.629Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    65 as price_rating,
    89 as vibe_rating,
    73 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    8 as queue_time,
    true as is_anonymous,
    '2025-05-07T04:07:24.006Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    38 as quality_rating,
    69 as price_rating,
    84 as vibe_rating,
    72 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-13T12:17:55.623Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    82 as price_rating,
    93 as vibe_rating,
    92 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-05-04T09:28:37.651Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    100 as price_rating,
    98 as vibe_rating,
    87 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-23T11:04:31.361Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    89 as price_rating,
    73 as vibe_rating,
    64 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-05-31T19:12:46.525Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    30 as price_rating,
    37 as vibe_rating,
    84 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-03-23T20:39:39.285Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    38 as quality_rating,
    75 as price_rating,
    81 as vibe_rating,
    79 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-01T10:22:17.524Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
