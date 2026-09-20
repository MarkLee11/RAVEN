-- RAVEN项目 - 酒吧评论数据 (批次 10)
-- 生成时间: 2025-08-23T06:00:20.223Z
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
    85 as quality_rating,
    63 as price_rating,
    67 as vibe_rating,
    88 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-05-24T13:59:40.473Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    50 as price_rating,
    45 as vibe_rating,
    75 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-18T11:16:19.122Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    89 as price_rating,
    68 as vibe_rating,
    60 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-23T22:51:38.193Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    82 as price_rating,
    72 as vibe_rating,
    83 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-06-18T00:16:51.220Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    83 as price_rating,
    86 as vibe_rating,
    76 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-05-17T03:20:34.301Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    80 as price_rating,
    63 as vibe_rating,
    79 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-05-15T07:10:56.247Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    43 as price_rating,
    89 as vibe_rating,
    74 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    37 as queue_time,
    false as is_anonymous,
    '2025-04-27T13:40:58.670Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    54 as price_rating,
    72 as vibe_rating,
    88 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-06-14T07:58:26.269Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    83 as price_rating,
    57 as vibe_rating,
    80 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-04-06T05:30:37.002Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    95 as price_rating,
    82 as vibe_rating,
    78 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-07-07T15:20:58.595Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    93 as price_rating,
    84 as vibe_rating,
    98 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-07-13T14:15:49.740Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    86 as price_rating,
    84 as vibe_rating,
    72 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-22T04:28:36.477Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    83 as price_rating,
    71 as vibe_rating,
    97 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    42 as queue_time,
    true as is_anonymous,
    '2025-05-10T06:21:32.687Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    40 as quality_rating,
    66 as price_rating,
    68 as vibe_rating,
    67 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-05-23T21:08:00.528Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    56 as price_rating,
    96 as vibe_rating,
    84 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-11T07:21:24.944Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    71 as price_rating,
    51 as vibe_rating,
    94 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-29T06:58:50.006Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    40 as quality_rating,
    80 as price_rating,
    71 as vibe_rating,
    46 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    13 as queue_time,
    false as is_anonymous,
    '2025-08-19T15:20:37.545Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    85 as price_rating,
    67 as vibe_rating,
    89 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    17 as queue_time,
    false as is_anonymous,
    '2025-06-20T10:28:05.155Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    72 as price_rating,
    68 as vibe_rating,
    86 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-08-18T03:29:22.621Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    70 as price_rating,
    87 as vibe_rating,
    95 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    16 as queue_time,
    true as is_anonymous,
    '2025-04-13T06:52:35.016Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    89 as price_rating,
    90 as vibe_rating,
    72 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-27T19:53:28.175Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    76 as price_rating,
    68 as vibe_rating,
    85 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-07-28T18:17:50.042Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    92 as price_rating,
    62 as vibe_rating,
    60 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-03-13T13:04:13.300Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    92 as price_rating,
    99 as vibe_rating,
    80 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-04-24T08:48:56.217Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    100 as price_rating,
    63 as vibe_rating,
    66 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-05-28T11:03:01.097Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    68 as price_rating,
    90 as vibe_rating,
    49 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-03T02:39:19.708Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    33 as quality_rating,
    46 as price_rating,
    69 as vibe_rating,
    90 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-04-04T17:14:32.764Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    92 as price_rating,
    68 as vibe_rating,
    87 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-06T20:55:40.058Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    73 as price_rating,
    76 as vibe_rating,
    85 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-07-17T10:39:15.906Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    52 as price_rating,
    92 as vibe_rating,
    97 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-07-12T06:10:47.668Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    80 as price_rating,
    78 as vibe_rating,
    83 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-07T10:50:30.917Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    70 as price_rating,
    35 as vibe_rating,
    63 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-07-18T11:16:46.253Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    80 as price_rating,
    81 as vibe_rating,
    85 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-05-06T20:20:35.463Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    42 as price_rating,
    84 as vibe_rating,
    63 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-06-24T20:12:33.215Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    36 as price_rating,
    95 as vibe_rating,
    95 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-15T19:29:26.875Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    91 as price_rating,
    84 as vibe_rating,
    75 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    42 as queue_time,
    false as is_anonymous,
    '2025-03-30T00:20:55.418Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    35 as quality_rating,
    54 as price_rating,
    65 as vibe_rating,
    82 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-08-09T06:50:46.530Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    98 as price_rating,
    82 as vibe_rating,
    87 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-24T07:59:55.021Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    66 as price_rating,
    68 as vibe_rating,
    65 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    22 as queue_time,
    false as is_anonymous,
    '2025-05-16T07:03:29.844Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    38 as price_rating,
    82 as vibe_rating,
    87 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-07-23T11:12:23.041Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    53 as price_rating,
    65 as vibe_rating,
    95 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-06-02T23:31:41.389Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    53 as price_rating,
    72 as vibe_rating,
    54 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-08-03T09:16:06.388Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    76 as price_rating,
    88 as vibe_rating,
    87 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-03-22T17:25:30.533Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    38 as quality_rating,
    99 as price_rating,
    79 as vibe_rating,
    65 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-06-28T13:11:07.513Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    55 as price_rating,
    93 as vibe_rating,
    91 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-07T21:15:45.312Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    64 as quality_rating,
    93 as price_rating,
    39 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-04-10T09:37:48.056Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    87 as price_rating,
    85 as vibe_rating,
    84 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-06-11T15:56:16.595Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    65 as price_rating,
    43 as vibe_rating,
    86 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-03-14T12:10:11.759Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    54 as price_rating,
    81 as vibe_rating,
    98 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-03-19T19:58:47.603Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    79 as price_rating,
    95 as vibe_rating,
    54 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-08-12T01:44:06.704Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    99 as price_rating,
    78 as vibe_rating,
    77 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-03-28T01:53:46.626Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    55 as price_rating,
    65 as vibe_rating,
    84 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-03-25T02:52:39.484Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    56 as price_rating,
    69 as vibe_rating,
    99 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    44 as queue_time,
    false as is_anonymous,
    '2025-04-18T17:47:16.661Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    77 as price_rating,
    76 as vibe_rating,
    70 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    18 as queue_time,
    false as is_anonymous,
    '2025-03-04T15:10:17.977Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    70 as price_rating,
    60 as vibe_rating,
    96 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-20T00:55:42.634Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    82 as price_rating,
    82 as vibe_rating,
    70 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-07-14T12:14:05.387Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    86 as price_rating,
    85 as vibe_rating,
    100 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-05-21T17:47:02.836Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    81 as price_rating,
    76 as vibe_rating,
    88 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-05-16T06:58:30.280Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    100 as price_rating,
    69 as vibe_rating,
    48 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-06-05T00:06:14.280Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    84 as price_rating,
    43 as vibe_rating,
    100 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-04-26T07:33:49.152Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    85 as price_rating,
    55 as vibe_rating,
    53 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-03-19T10:04:47.134Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    85 as price_rating,
    66 as vibe_rating,
    66 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-05-08T02:44:29.871Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    97 as price_rating,
    43 as vibe_rating,
    89 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-03-06T02:35:01.015Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    90 as price_rating,
    84 as vibe_rating,
    96 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    14 as queue_time,
    false as is_anonymous,
    '2025-07-27T04:47:29.096Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    68 as price_rating,
    62 as vibe_rating,
    95 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-07-04T19:49:40.678Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    94 as price_rating,
    30 as vibe_rating,
    78 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-06-06T15:23:32.173Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    55 as price_rating,
    70 as vibe_rating,
    84 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-29T11:00:52.459Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    85 as price_rating,
    59 as vibe_rating,
    82 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    42 as queue_time,
    true as is_anonymous,
    '2025-07-12T23:19:28.818Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    84 as price_rating,
    80 as vibe_rating,
    97 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-08-18T21:23:31.249Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    100 as price_rating,
    86 as vibe_rating,
    47 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-03T18:54:47.111Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    59 as price_rating,
    82 as vibe_rating,
    40 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-04T06:20:10.912Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    31 as quality_rating,
    75 as price_rating,
    50 as vibe_rating,
    71 as friendliness_rating,
    '价格太贵了，而且服务态度不好。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-06T05:34:18.813Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    60 as price_rating,
    86 as vibe_rating,
    70 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-15T19:17:33.817Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    65 as price_rating,
    76 as vibe_rating,
    79 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    19 as queue_time,
    false as is_anonymous,
    '2025-02-26T12:33:16.769Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    94 as price_rating,
    88 as vibe_rating,
    84 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-04-05T14:23:20.265Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    67 as price_rating,
    85 as vibe_rating,
    88 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-07-23T17:57:48.504Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    83 as price_rating,
    84 as vibe_rating,
    83 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-03-13T03:20:35.612Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    90 as price_rating,
    40 as vibe_rating,
    87 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-19T18:24:15.124Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    91 as price_rating,
    45 as vibe_rating,
    64 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    25 as queue_time,
    false as is_anonymous,
    '2025-03-03T18:43:53.956Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    70 as price_rating,
    89 as vibe_rating,
    30 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-05T05:05:00.087Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    85 as price_rating,
    88 as vibe_rating,
    61 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-07-16T16:57:34.814Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    90 as price_rating,
    66 as vibe_rating,
    100 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-16T10:15:17.173Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    72 as price_rating,
    75 as vibe_rating,
    95 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    19 as queue_time,
    false as is_anonymous,
    '2025-05-16T08:50:28.561Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    69 as price_rating,
    95 as vibe_rating,
    83 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-06-15T11:00:28.259Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    99 as price_rating,
    36 as vibe_rating,
    90 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-07-30T04:55:17.362Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    86 as price_rating,
    76 as vibe_rating,
    74 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    16 as queue_time,
    true as is_anonymous,
    '2025-03-16T09:41:13.610Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    95 as price_rating,
    94 as vibe_rating,
    72 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    31 as queue_time,
    true as is_anonymous,
    '2025-03-31T22:31:24.765Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    58 as price_rating,
    64 as vibe_rating,
    95 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-30T18:05:48.397Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    73 as price_rating,
    41 as vibe_rating,
    87 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    45 as queue_time,
    false as is_anonymous,
    '2025-07-08T11:15:51.067Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    87 as price_rating,
    92 as vibe_rating,
    90 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-04-22T20:52:25.077Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    60 as price_rating,
    90 as vibe_rating,
    69 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-05-26T04:17:21.329Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    46 as price_rating,
    80 as vibe_rating,
    85 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-07-23T18:34:38.744Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    88 as price_rating,
    100 as vibe_rating,
    98 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-12T02:30:58.570Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    52 as price_rating,
    86 as vibe_rating,
    72 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-09T16:06:52.953Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    83 as price_rating,
    72 as vibe_rating,
    57 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-07-17T12:09:53.981Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    95 as price_rating,
    97 as vibe_rating,
    67 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-23T23:30:17.144Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    65 as price_rating,
    88 as vibe_rating,
    52 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-04-13T03:18:13.666Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    85 as price_rating,
    57 as vibe_rating,
    51 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    20 as queue_time,
    true as is_anonymous,
    '2025-08-20T15:49:07.143Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    45 as price_rating,
    51 as vibe_rating,
    67 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-11T10:35:21.486Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    64 as price_rating,
    81 as vibe_rating,
    99 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-25T21:56:33.777Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
