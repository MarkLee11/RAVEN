-- RAVEN项目 - 酒吧评论数据 (批次 8)
-- 生成时间: 2025-08-23T06:00:20.214Z
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
    72 as quality_rating,
    97 as price_rating,
    66 as vibe_rating,
    72 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-03-04T16:54:45.389Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    86 as price_rating,
    90 as vibe_rating,
    86 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-27T09:50:56.752Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    83 as price_rating,
    50 as vibe_rating,
    72 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-05-25T13:29:27.348Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    96 as price_rating,
    73 as vibe_rating,
    88 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-08-09T12:05:49.422Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    86 as price_rating,
    70 as vibe_rating,
    82 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    24 as queue_time,
    false as is_anonymous,
    '2025-08-07T16:02:56.975Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    74 as price_rating,
    80 as vibe_rating,
    59 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-08-10T23:29:56.574Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    81 as price_rating,
    74 as vibe_rating,
    80 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-04-07T11:30:46.068Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    85 as price_rating,
    42 as vibe_rating,
    42 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-04-01T10:29:01.630Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    45 as price_rating,
    62 as vibe_rating,
    79 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-03-29T01:16:08.500Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    41 as price_rating,
    99 as vibe_rating,
    66 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    41 as queue_time,
    true as is_anonymous,
    '2025-07-21T15:22:54.299Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    87 as price_rating,
    76 as vibe_rating,
    84 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-28T23:05:43.686Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    40 as price_rating,
    83 as vibe_rating,
    72 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-03-04T19:04:19.695Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    68 as price_rating,
    82 as vibe_rating,
    87 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-12T21:56:48.537Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    32 as price_rating,
    84 as vibe_rating,
    96 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-08-17T20:05:51.205Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    55 as price_rating,
    96 as vibe_rating,
    80 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-04T21:13:21.247Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    61 as price_rating,
    98 as vibe_rating,
    42 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-03-26T07:32:38.269Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    34 as price_rating,
    58 as vibe_rating,
    60 as friendliness_rating,
    'Service was slow and drinks were overpriced.' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-07-13T23:50:24.713Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    96 as price_rating,
    43 as vibe_rating,
    74 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-07-07T23:04:04.548Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    67 as price_rating,
    61 as vibe_rating,
    74 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-07-27T01:37:41.784Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    65 as price_rating,
    85 as vibe_rating,
    67 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-05T23:11:12.475Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    78 as price_rating,
    79 as vibe_rating,
    75 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-21T00:29:19.689Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    84 as price_rating,
    85 as vibe_rating,
    97 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-03-18T02:03:37.802Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    71 as price_rating,
    90 as vibe_rating,
    93 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-06-24T05:47:27.693Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    55 as price_rating,
    94 as vibe_rating,
    73 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-05T03:58:52.404Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    59 as price_rating,
    80 as vibe_rating,
    76 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    40 as queue_time,
    false as is_anonymous,
    '2025-03-03T10:49:23.213Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    69 as price_rating,
    89 as vibe_rating,
    83 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-03-30T10:31:41.821Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    69 as price_rating,
    70 as vibe_rating,
    82 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-08-04T01:05:04.527Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    55 as price_rating,
    69 as vibe_rating,
    75 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-13T23:12:27.735Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    92 as price_rating,
    62 as vibe_rating,
    63 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-04-17T22:13:12.072Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    62 as price_rating,
    65 as vibe_rating,
    81 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    21 as queue_time,
    true as is_anonymous,
    '2025-06-29T09:58:42.908Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    72 as price_rating,
    95 as vibe_rating,
    81 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-03T15:59:18.608Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    74 as price_rating,
    65 as vibe_rating,
    89 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-21T11:36:14.105Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    50 as price_rating,
    50 as vibe_rating,
    71 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    34 as queue_time,
    false as is_anonymous,
    '2025-07-02T20:01:08.791Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    81 as price_rating,
    71 as vibe_rating,
    81 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-02T05:49:37.653Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    71 as price_rating,
    60 as vibe_rating,
    97 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-12T07:30:32.418Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    91 as price_rating,
    99 as vibe_rating,
    65 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    34 as queue_time,
    false as is_anonymous,
    '2025-06-10T08:01:12.131Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    82 as price_rating,
    75 as vibe_rating,
    79 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    31 as queue_time,
    true as is_anonymous,
    '2025-04-07T08:26:03.392Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    84 as price_rating,
    79 as vibe_rating,
    71 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-05-04T01:23:34.334Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    97 as price_rating,
    81 as vibe_rating,
    45 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    12 as queue_time,
    false as is_anonymous,
    '2025-06-23T03:23:28.435Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    58 as price_rating,
    80 as vibe_rating,
    58 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-08-16T22:30:23.720Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    92 as price_rating,
    99 as vibe_rating,
    85 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-05-18T04:31:15.842Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    50 as price_rating,
    54 as vibe_rating,
    51 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-03-02T12:17:24.577Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    69 as price_rating,
    49 as vibe_rating,
    93 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-08T19:14:20.544Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    76 as price_rating,
    57 as vibe_rating,
    85 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-08-07T02:01:33.043Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    41 as price_rating,
    88 as vibe_rating,
    89 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-29T02:23:49.349Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    83 as price_rating,
    82 as vibe_rating,
    67 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-04-20T13:07:08.269Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    82 as price_rating,
    97 as vibe_rating,
    98 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-03-26T09:04:09.573Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    53 as price_rating,
    71 as vibe_rating,
    100 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    9 as queue_time,
    false as is_anonymous,
    '2025-05-15T07:07:01.660Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    74 as price_rating,
    71 as vibe_rating,
    67 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-06-25T20:13:55.997Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    63 as price_rating,
    54 as vibe_rating,
    75 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-22T14:01:18.406Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    83 as price_rating,
    70 as vibe_rating,
    90 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-05-17T07:31:49.261Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    44 as price_rating,
    97 as vibe_rating,
    72 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-15T14:16:58.847Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    66 as price_rating,
    76 as vibe_rating,
    99 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-06-23T11:42:25.987Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    90 as price_rating,
    97 as vibe_rating,
    60 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-03-20T15:07:09.835Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    65 as price_rating,
    67 as vibe_rating,
    81 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    42 as queue_time,
    true as is_anonymous,
    '2025-05-22T11:25:06.693Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    85 as price_rating,
    79 as vibe_rating,
    66 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-22T13:47:50.824Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    35 as quality_rating,
    84 as price_rating,
    97 as vibe_rating,
    78 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-30T16:30:42.401Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    98 as price_rating,
    82 as vibe_rating,
    92 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-07-02T09:13:40.543Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    96 as price_rating,
    56 as vibe_rating,
    73 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-13T07:22:10.073Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    43 as price_rating,
    82 as vibe_rating,
    90 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    12 as queue_time,
    false as is_anonymous,
    '2025-07-18T14:39:42.726Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    85 as price_rating,
    94 as vibe_rating,
    54 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-11T19:03:47.036Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    45 as price_rating,
    91 as vibe_rating,
    81 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-08-09T09:13:19.191Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    88 as price_rating,
    50 as vibe_rating,
    33 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-04-07T20:14:01.104Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    87 as price_rating,
    65 as vibe_rating,
    72 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-02-28T07:19:40.459Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    92 as price_rating,
    71 as vibe_rating,
    72 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-02T11:54:41.311Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    80 as price_rating,
    54 as vibe_rating,
    69 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-03-15T13:19:13.057Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    84 as price_rating,
    80 as vibe_rating,
    77 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-08-07T20:20:34.576Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    92 as price_rating,
    95 as vibe_rating,
    85 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-04-04T01:01:26.870Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    64 as quality_rating,
    67 as price_rating,
    85 as vibe_rating,
    81 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    43 as queue_time,
    false as is_anonymous,
    '2025-06-08T19:35:15.075Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    56 as price_rating,
    99 as vibe_rating,
    79 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-03-13T05:42:37.790Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    57 as price_rating,
    83 as vibe_rating,
    66 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-05-03T07:49:44.512Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    46 as price_rating,
    34 as vibe_rating,
    97 as friendliness_rating,
    'Too crowded and expensive for what you get.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-01T01:00:11.691Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    81 as price_rating,
    81 as vibe_rating,
    89 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-03T10:01:14.262Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    66 as price_rating,
    35 as vibe_rating,
    95 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-05T23:51:50.842Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    61 as price_rating,
    76 as vibe_rating,
    81 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    28 as queue_time,
    false as is_anonymous,
    '2025-04-12T11:07:14.624Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    55 as price_rating,
    83 as vibe_rating,
    95 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-03-01T01:57:17.261Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    69 as price_rating,
    83 as vibe_rating,
    69 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    40 as queue_time,
    false as is_anonymous,
    '2025-03-23T19:57:33.067Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    65 as price_rating,
    100 as vibe_rating,
    98 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-28T02:36:55.262Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    50 as price_rating,
    63 as vibe_rating,
    87 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-03-01T02:45:37.834Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    80 as price_rating,
    97 as vibe_rating,
    68 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    18 as queue_time,
    false as is_anonymous,
    '2025-07-10T05:09:30.208Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    43 as price_rating,
    57 as vibe_rating,
    64 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-07-08T07:16:16.236Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    82 as price_rating,
    98 as vibe_rating,
    95 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-24T12:25:42.335Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    37 as quality_rating,
    82 as price_rating,
    80 as vibe_rating,
    57 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-09T11:36:34.013Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    68 as price_rating,
    93 as vibe_rating,
    68 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-01T06:59:48.768Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    86 as price_rating,
    55 as vibe_rating,
    81 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    36 as queue_time,
    true as is_anonymous,
    '2025-08-07T08:12:27.069Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    64 as price_rating,
    82 as vibe_rating,
    94 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-05T17:04:50.513Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    74 as price_rating,
    88 as vibe_rating,
    50 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-20T23:04:26.823Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    81 as price_rating,
    96 as vibe_rating,
    67 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-06-23T04:31:09.783Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    92 as price_rating,
    96 as vibe_rating,
    57 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-03-05T22:10:53.997Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    99 as price_rating,
    76 as vibe_rating,
    72 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-27T06:16:33.660Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    47 as price_rating,
    73 as vibe_rating,
    83 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-07-19T17:55:37.385Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    80 as price_rating,
    90 as vibe_rating,
    80 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-03-01T04:16:59.134Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    92 as price_rating,
    68 as vibe_rating,
    71 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-05-15T11:11:05.187Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    30 as quality_rating,
    33 as price_rating,
    31 as vibe_rating,
    69 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-26T18:14:25.307Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    99 as price_rating,
    87 as vibe_rating,
    51 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-07-18T05:08:34.996Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    82 as price_rating,
    74 as vibe_rating,
    68 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-07-01T20:30:50.079Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    34 as quality_rating,
    96 as price_rating,
    98 as vibe_rating,
    71 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-12T19:43:05.525Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    70 as price_rating,
    46 as vibe_rating,
    83 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-17T10:58:06.056Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    99 as price_rating,
    83 as vibe_rating,
    41 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    45 as queue_time,
    false as is_anonymous,
    '2025-03-30T13:13:42.326Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    100 as price_rating,
    89 as vibe_rating,
    59 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-03T11:50:47.353Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
