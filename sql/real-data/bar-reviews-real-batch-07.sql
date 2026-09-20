-- RAVEN项目 - 酒吧评论数据 (批次 7)
-- 生成时间: 2025-08-23T06:00:20.211Z
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
    48 as quality_rating,
    91 as price_rating,
    59 as vibe_rating,
    67 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-26T20:55:34.598Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    71 as price_rating,
    59 as vibe_rating,
    52 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    37 as queue_time,
    false as is_anonymous,
    '2025-05-13T21:19:08.845Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    94 as price_rating,
    65 as vibe_rating,
    91 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-17T17:18:02.695Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    68 as price_rating,
    100 as vibe_rating,
    61 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    32 as queue_time,
    false as is_anonymous,
    '2025-04-29T16:57:16.908Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    86 as price_rating,
    53 as vibe_rating,
    91 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-08-06T20:07:00.856Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    79 as price_rating,
    76 as vibe_rating,
    33 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-05-11T17:43:41.127Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    66 as price_rating,
    66 as vibe_rating,
    94 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-20T15:45:22.869Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    71 as price_rating,
    55 as vibe_rating,
    67 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    22 as queue_time,
    false as is_anonymous,
    '2025-05-31T08:32:32.716Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    66 as price_rating,
    73 as vibe_rating,
    89 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-16T06:51:51.161Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    47 as price_rating,
    82 as vibe_rating,
    64 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-06-25T19:38:57.776Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    80 as price_rating,
    85 as vibe_rating,
    73 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-08-03T19:18:14.659Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    56 as price_rating,
    66 as vibe_rating,
    91 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-03-16T08:07:42.291Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    100 as price_rating,
    53 as vibe_rating,
    83 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-08T11:48:50.437Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    85 as price_rating,
    94 as vibe_rating,
    78 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-07-13T22:53:48.059Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    57 as price_rating,
    81 as vibe_rating,
    78 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-05-10T20:02:38.863Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    61 as price_rating,
    91 as vibe_rating,
    81 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-05-22T01:51:23.268Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    53 as price_rating,
    63 as vibe_rating,
    78 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-13T09:14:22.874Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    81 as price_rating,
    66 as vibe_rating,
    77 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-03-28T03:35:55.443Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    77 as price_rating,
    83 as vibe_rating,
    99 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-04-13T17:08:05.801Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    99 as price_rating,
    74 as vibe_rating,
    42 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-03-10T20:48:59.766Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    73 as price_rating,
    72 as vibe_rating,
    67 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-09T18:07:50.367Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    81 as price_rating,
    82 as vibe_rating,
    92 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-11T03:31:50.777Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    86 as price_rating,
    88 as vibe_rating,
    48 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    13 as queue_time,
    false as is_anonymous,
    '2025-08-16T08:48:29.609Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    47 as price_rating,
    80 as vibe_rating,
    85 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-18T07:21:11.337Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    58 as price_rating,
    82 as vibe_rating,
    65 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-04-07T07:49:25.422Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    69 as price_rating,
    85 as vibe_rating,
    70 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-05-14T22:51:17.670Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    90 as price_rating,
    80 as vibe_rating,
    62 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-16T04:46:53.252Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    48 as price_rating,
    82 as vibe_rating,
    52 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    24 as queue_time,
    false as is_anonymous,
    '2025-05-20T18:13:14.454Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    30 as price_rating,
    77 as vibe_rating,
    66 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-21T14:29:03.944Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    80 as price_rating,
    66 as vibe_rating,
    81 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-08-12T21:18:16.494Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    82 as price_rating,
    55 as vibe_rating,
    81 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    14 as queue_time,
    false as is_anonymous,
    '2025-06-13T18:17:39.525Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    89 as price_rating,
    80 as vibe_rating,
    64 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-18T04:31:15.081Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    77 as price_rating,
    93 as vibe_rating,
    63 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-03T20:43:01.141Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    74 as price_rating,
    58 as vibe_rating,
    91 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-08-04T03:12:45.095Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    82 as price_rating,
    78 as vibe_rating,
    96 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    32 as queue_time,
    false as is_anonymous,
    '2025-06-15T22:15:04.075Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    86 as price_rating,
    66 as vibe_rating,
    69 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-06-05T20:26:15.894Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    98 as price_rating,
    80 as vibe_rating,
    80 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-19T22:27:29.023Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    75 as price_rating,
    80 as vibe_rating,
    30 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-04T19:27:42.543Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    66 as price_rating,
    87 as vibe_rating,
    81 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-07-27T13:18:15.600Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    57 as price_rating,
    88 as vibe_rating,
    57 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-04T07:06:38.686Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    50 as price_rating,
    85 as vibe_rating,
    61 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-06-24T17:48:53.642Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    44 as quality_rating,
    50 as price_rating,
    66 as vibe_rating,
    83 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    38 as queue_time,
    false as is_anonymous,
    '2025-08-12T21:13:59.006Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    81 as price_rating,
    98 as vibe_rating,
    84 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-05-28T22:31:53.709Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    95 as price_rating,
    83 as vibe_rating,
    64 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-10T10:41:10.697Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    86 as price_rating,
    82 as vibe_rating,
    47 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    37 as queue_time,
    true as is_anonymous,
    '2025-04-06T13:46:54.539Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    88 as price_rating,
    60 as vibe_rating,
    82 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-26T01:07:19.423Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    67 as price_rating,
    99 as vibe_rating,
    54 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-08-05T10:19:40.063Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    84 as price_rating,
    96 as vibe_rating,
    95 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-05-11T01:53:54.450Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    54 as price_rating,
    71 as vibe_rating,
    36 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-02-25T03:45:53.331Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    43 as quality_rating,
    78 as price_rating,
    79 as vibe_rating,
    76 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-21T22:20:06.249Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    82 as price_rating,
    67 as vibe_rating,
    65 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-04-18T04:31:19.072Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    81 as price_rating,
    73 as vibe_rating,
    94 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-07-26T10:27:31.196Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    31 as quality_rating,
    73 as price_rating,
    60 as vibe_rating,
    53 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    13 as queue_time,
    false as is_anonymous,
    '2025-06-27T09:26:43.745Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    88 as price_rating,
    80 as vibe_rating,
    80 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-17T16:39:14.906Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    100 as price_rating,
    68 as vibe_rating,
    66 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-05-13T00:38:51.030Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    80 as price_rating,
    80 as vibe_rating,
    72 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-07-15T22:53:49.047Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    67 as price_rating,
    98 as vibe_rating,
    32 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    16 as queue_time,
    true as is_anonymous,
    '2025-05-27T18:02:36.347Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    95 as price_rating,
    87 as vibe_rating,
    69 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    42 as queue_time,
    true as is_anonymous,
    '2025-03-24T07:27:39.839Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    84 as price_rating,
    62 as vibe_rating,
    67 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    31 as queue_time,
    true as is_anonymous,
    '2025-04-25T02:20:12.543Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    78 as price_rating,
    93 as vibe_rating,
    83 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-06-17T01:10:44.028Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    87 as price_rating,
    68 as vibe_rating,
    94 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-06-23T01:34:26.780Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    86 as price_rating,
    74 as vibe_rating,
    74 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-08-19T22:35:07.698Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    52 as price_rating,
    83 as vibe_rating,
    54 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-04-03T00:43:39.525Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    83 as price_rating,
    77 as vibe_rating,
    99 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    17 as queue_time,
    false as is_anonymous,
    '2025-05-25T20:58:46.062Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    60 as price_rating,
    69 as vibe_rating,
    86 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-14T01:46:57.604Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    86 as price_rating,
    81 as vibe_rating,
    100 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-13T18:47:20.884Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    56 as price_rating,
    100 as vibe_rating,
    65 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-05-13T19:55:27.080Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    83 as price_rating,
    87 as vibe_rating,
    35 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-26T10:49:12.445Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    36 as quality_rating,
    81 as price_rating,
    56 as vibe_rating,
    93 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-04-24T11:54:34.854Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    57 as price_rating,
    82 as vibe_rating,
    58 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-20T10:48:21.773Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    59 as price_rating,
    81 as vibe_rating,
    95 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    17 as queue_time,
    true as is_anonymous,
    '2025-05-19T17:01:59.722Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    95 as price_rating,
    50 as vibe_rating,
    84 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-08-11T10:18:03.727Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    44 as quality_rating,
    80 as price_rating,
    89 as vibe_rating,
    94 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    10 as queue_time,
    false as is_anonymous,
    '2025-03-02T12:32:53.759Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    48 as quality_rating,
    60 as price_rating,
    58 as vibe_rating,
    89 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    34 as queue_time,
    false as is_anonymous,
    '2025-05-19T14:35:55.599Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    51 as price_rating,
    83 as vibe_rating,
    42 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-08-02T15:06:56.891Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    91 as price_rating,
    82 as vibe_rating,
    59 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-06-22T10:41:46.188Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    87 as price_rating,
    73 as vibe_rating,
    88 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-03-18T15:39:42.737Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    82 as price_rating,
    92 as vibe_rating,
    81 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-27T07:10:50.561Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    83 as price_rating,
    71 as vibe_rating,
    72 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    35 as queue_time,
    false as is_anonymous,
    '2025-05-07T02:08:54.279Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    60 as price_rating,
    72 as vibe_rating,
    83 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    37 as queue_time,
    false as is_anonymous,
    '2025-04-29T09:46:10.663Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    58 as price_rating,
    93 as vibe_rating,
    49 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-06T23:07:49.972Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    78 as price_rating,
    72 as vibe_rating,
    30 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-03-25T06:50:22.994Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    36 as quality_rating,
    83 as price_rating,
    59 as vibe_rating,
    99 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    20 as queue_time,
    true as is_anonymous,
    '2025-06-11T09:40:33.525Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    82 as price_rating,
    68 as vibe_rating,
    59 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-14T19:16:52.277Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    41 as quality_rating,
    74 as price_rating,
    51 as vibe_rating,
    91 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    20 as queue_time,
    true as is_anonymous,
    '2025-05-12T19:40:31.647Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    85 as price_rating,
    100 as vibe_rating,
    60 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-11T01:32:22.955Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    53 as quality_rating,
    66 as price_rating,
    83 as vibe_rating,
    67 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-28T20:58:01.304Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    75 as price_rating,
    68 as vibe_rating,
    83 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-03-23T01:39:30.739Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    62 as price_rating,
    95 as vibe_rating,
    86 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-08-08T23:58:22.673Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    93 as price_rating,
    61 as vibe_rating,
    81 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-03-25T14:32:55.610Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    77 as price_rating,
    100 as vibe_rating,
    90 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-07-08T19:16:06.837Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    33 as quality_rating,
    89 as price_rating,
    65 as vibe_rating,
    85 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-07-16T00:17:53.732Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    64 as price_rating,
    69 as vibe_rating,
    83 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-12T16:06:34.341Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    60 as price_rating,
    30 as vibe_rating,
    71 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-06-07T13:44:53.777Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    97 as price_rating,
    66 as vibe_rating,
    39 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-08-09T04:08:16.889Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    92 as price_rating,
    84 as vibe_rating,
    75 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-23T19:12:21.539Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    49 as quality_rating,
    68 as price_rating,
    71 as vibe_rating,
    74 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-30T05:02:14.381Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    71 as price_rating,
    97 as vibe_rating,
    68 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-02T15:58:05.133Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    88 as price_rating,
    83 as vibe_rating,
    93 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-30T20:39:44.232Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    87 as price_rating,
    94 as vibe_rating,
    87 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-05-05T23:29:38.847Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
