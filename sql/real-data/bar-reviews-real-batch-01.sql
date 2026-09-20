-- RAVEN项目 - 酒吧评论数据 (批次 1)
-- 生成时间: 2025-08-23T06:00:20.179Z
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
    76 as quality_rating,
    93 as price_rating,
    71 as vibe_rating,
    82 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-23T07:35:34.460Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    92 as price_rating,
    81 as vibe_rating,
    85 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-05-17T12:22:49.655Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    30 as quality_rating,
    91 as price_rating,
    98 as vibe_rating,
    95 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-01T13:13:40.795Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    75 as price_rating,
    99 as vibe_rating,
    84 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-05-13T07:41:13.134Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    49 as quality_rating,
    89 as price_rating,
    83 as vibe_rating,
    93 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-03-06T07:36:16.842Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    84 as price_rating,
    62 as vibe_rating,
    81 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-19T22:50:13.990Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    93 as price_rating,
    81 as vibe_rating,
    88 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-07-29T14:07:54.069Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    83 as price_rating,
    99 as vibe_rating,
    100 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-07-21T14:17:07.992Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    52 as price_rating,
    67 as vibe_rating,
    84 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-18T20:28:22.887Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    97 as price_rating,
    82 as vibe_rating,
    83 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    24 as queue_time,
    false as is_anonymous,
    '2025-03-23T06:41:03.944Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    30 as quality_rating,
    84 as price_rating,
    82 as vibe_rating,
    62 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-03-24T16:42:27.653Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    73 as price_rating,
    88 as vibe_rating,
    97 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-08-07T16:22:52.289Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    64 as price_rating,
    61 as vibe_rating,
    89 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-03-15T23:50:49.527Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    62 as price_rating,
    82 as vibe_rating,
    96 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-05-11T08:49:50.068Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    41 as price_rating,
    59 as vibe_rating,
    80 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    42 as queue_time,
    false as is_anonymous,
    '2025-08-22T17:22:24.376Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    92 as price_rating,
    90 as vibe_rating,
    57 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-01T17:54:18.611Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    64 as price_rating,
    82 as vibe_rating,
    50 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-11T22:17:59.303Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    93 as price_rating,
    81 as vibe_rating,
    32 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-25T21:27:03.222Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    94 as price_rating,
    55 as vibe_rating,
    80 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-08-14T15:11:57.201Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    53 as price_rating,
    92 as vibe_rating,
    84 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-07-24T01:30:08.689Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    95 as price_rating,
    88 as vibe_rating,
    97 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-14T23:29:09.198Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    71 as price_rating,
    67 as vibe_rating,
    80 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-02-27T23:38:59.403Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    71 as price_rating,
    100 as vibe_rating,
    66 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-08-20T12:52:14.527Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    56 as price_rating,
    91 as vibe_rating,
    78 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-03-11T22:29:33.273Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    78 as price_rating,
    85 as vibe_rating,
    63 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-05-13T19:49:50.088Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    69 as price_rating,
    100 as vibe_rating,
    52 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    37 as queue_time,
    false as is_anonymous,
    '2025-05-25T07:40:28.280Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    36 as price_rating,
    79 as vibe_rating,
    46 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-22T22:23:50.319Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    86 as price_rating,
    72 as vibe_rating,
    38 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-04-16T02:29:56.652Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    89 as price_rating,
    76 as vibe_rating,
    87 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-03T10:07:18.781Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    48 as price_rating,
    55 as vibe_rating,
    85 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-07-27T21:14:35.508Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    71 as price_rating,
    69 as vibe_rating,
    96 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-25T02:07:26.939Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    74 as price_rating,
    94 as vibe_rating,
    59 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-11T09:14:17.131Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    57 as price_rating,
    83 as vibe_rating,
    68 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-17T22:32:33.862Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    55 as price_rating,
    79 as vibe_rating,
    94 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    26 as queue_time,
    true as is_anonymous,
    '2025-05-30T14:14:35.062Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    76 as price_rating,
    79 as vibe_rating,
    68 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-29T05:41:51.162Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    90 as price_rating,
    68 as vibe_rating,
    48 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-06-27T12:39:29.976Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    77 as price_rating,
    55 as vibe_rating,
    69 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-07T12:13:35.249Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    37 as quality_rating,
    77 as price_rating,
    60 as vibe_rating,
    83 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    26 as queue_time,
    false as is_anonymous,
    '2025-08-07T01:14:39.380Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    60 as price_rating,
    81 as vibe_rating,
    71 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    40 as queue_time,
    false as is_anonymous,
    '2025-05-30T07:35:31.970Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    34 as quality_rating,
    89 as price_rating,
    45 as vibe_rating,
    70 as friendliness_rating,
    '价格太贵了，而且服务态度不好。' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-04-26T00:23:57.341Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    36 as quality_rating,
    83 as price_rating,
    95 as vibe_rating,
    46 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-05-21T13:25:32.193Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    83 as price_rating,
    54 as vibe_rating,
    62 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-13T22:01:56.457Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    74 as price_rating,
    95 as vibe_rating,
    80 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-25T15:23:40.352Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    78 as price_rating,
    73 as vibe_rating,
    63 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-03-13T16:38:04.630Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    84 as price_rating,
    80 as vibe_rating,
    57 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-08-21T11:37:03.270Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    37 as quality_rating,
    94 as price_rating,
    74 as vibe_rating,
    51 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-31T14:55:28.649Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    96 as price_rating,
    58 as vibe_rating,
    66 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-02-26T07:22:46.131Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    83 as price_rating,
    90 as vibe_rating,
    98 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-04-18T05:52:09.397Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    85 as price_rating,
    89 as vibe_rating,
    69 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    8 as queue_time,
    true as is_anonymous,
    '2025-08-04T18:17:06.546Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    99 as price_rating,
    97 as vibe_rating,
    93 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-11T09:22:06.963Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    44 as price_rating,
    99 as vibe_rating,
    81 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-06-12T10:41:44.822Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    65 as price_rating,
    98 as vibe_rating,
    39 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-07-17T22:25:11.640Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    82 as price_rating,
    50 as vibe_rating,
    76 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-07-13T20:02:30.458Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    88 as price_rating,
    87 as vibe_rating,
    58 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-08-12T01:38:58.176Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    48 as price_rating,
    84 as vibe_rating,
    80 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-03-20T19:20:49.252Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    69 as price_rating,
    85 as vibe_rating,
    89 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-15T12:20:57.986Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    83 as price_rating,
    66 as vibe_rating,
    34 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-08T09:42:48.249Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    85 as price_rating,
    70 as vibe_rating,
    99 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-21T00:32:15.094Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    47 as quality_rating,
    69 as price_rating,
    67 as vibe_rating,
    100 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    2 as queue_time,
    true as is_anonymous,
    '2025-04-18T04:26:13.470Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    79 as price_rating,
    84 as vibe_rating,
    80 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-02-26T00:35:28.988Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    35 as price_rating,
    58 as vibe_rating,
    99 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-06-06T12:16:13.076Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    84 as price_rating,
    93 as vibe_rating,
    70 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-17T22:53:22.438Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    73 as price_rating,
    57 as vibe_rating,
    54 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    21 as queue_time,
    true as is_anonymous,
    '2025-07-16T21:38:08.337Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    96 as price_rating,
    84 as vibe_rating,
    72 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-06-27T14:44:04.627Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    74 as price_rating,
    100 as vibe_rating,
    73 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-31T09:19:52.309Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    82 as price_rating,
    45 as vibe_rating,
    53 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-12T12:11:28.480Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    78 as price_rating,
    84 as vibe_rating,
    88 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-05-11T20:56:45.660Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    70 as price_rating,
    71 as vibe_rating,
    81 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    5 as queue_time,
    true as is_anonymous,
    '2025-05-19T00:08:24.658Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    71 as price_rating,
    76 as vibe_rating,
    97 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-06-27T12:37:39.720Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    72 as price_rating,
    100 as vibe_rating,
    84 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-03T21:38:18.935Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    82 as price_rating,
    79 as vibe_rating,
    92 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-28T21:33:40.588Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    46 as quality_rating,
    79 as price_rating,
    75 as vibe_rating,
    83 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-03-07T07:57:22.115Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    71 as price_rating,
    100 as vibe_rating,
    83 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    44 as queue_time,
    false as is_anonymous,
    '2025-03-24T09:04:58.684Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    66 as price_rating,
    84 as vibe_rating,
    80 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    36 as queue_time,
    true as is_anonymous,
    '2025-06-16T22:14:05.355Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    94 as price_rating,
    66 as vibe_rating,
    83 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-25T01:41:33.060Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    68 as price_rating,
    83 as vibe_rating,
    71 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-25T18:22:13.609Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    97 as price_rating,
    84 as vibe_rating,
    72 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-27T02:59:57.389Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    96 as price_rating,
    88 as vibe_rating,
    77 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-04T22:53:54.647Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    89 as price_rating,
    42 as vibe_rating,
    65 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-14T05:57:15.184Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    69 as price_rating,
    44 as vibe_rating,
    92 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-06-19T17:56:12.923Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    83 as price_rating,
    71 as vibe_rating,
    70 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-12T22:51:01.438Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    72 as price_rating,
    70 as vibe_rating,
    80 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-07-01T20:40:28.460Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    34 as price_rating,
    60 as vibe_rating,
    85 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    31 as queue_time,
    true as is_anonymous,
    '2025-07-28T09:37:45.013Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    96 as price_rating,
    65 as vibe_rating,
    71 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-04-28T12:15:22.362Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    85 as price_rating,
    88 as vibe_rating,
    35 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-08-06T03:19:26.314Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    74 as price_rating,
    96 as vibe_rating,
    77 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-06-18T05:47:08.354Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    93 as price_rating,
    38 as vibe_rating,
    83 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-07-11T02:48:26.251Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    58 as price_rating,
    82 as vibe_rating,
    100 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-03-22T10:54:59.740Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    81 as price_rating,
    32 as vibe_rating,
    68 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-04-18T07:43:18.705Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    60 as price_rating,
    81 as vibe_rating,
    80 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    21 as queue_time,
    true as is_anonymous,
    '2025-07-14T06:09:53.504Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    100 as price_rating,
    81 as vibe_rating,
    72 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-07-03T00:01:12.672Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    44 as price_rating,
    75 as vibe_rating,
    63 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    37 as queue_time,
    false as is_anonymous,
    '2025-07-25T02:39:46.026Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    39 as quality_rating,
    88 as price_rating,
    86 as vibe_rating,
    74 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-15T06:05:32.566Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    65 as price_rating,
    62 as vibe_rating,
    69 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-04-02T05:43:56.529Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    45 as price_rating,
    71 as vibe_rating,
    59 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-04-08T04:31:19.245Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    99 as price_rating,
    82 as vibe_rating,
    94 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-05T07:56:36.121Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    92 as price_rating,
    93 as vibe_rating,
    95 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    37 as queue_time,
    true as is_anonymous,
    '2025-04-26T03:44:55.267Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    46 as price_rating,
    85 as vibe_rating,
    97 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-09T15:31:59.854Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    81 as price_rating,
    42 as vibe_rating,
    78 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-07-21T23:23:02.502Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    87 as price_rating,
    84 as vibe_rating,
    58 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-02T03:11:17.837Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
