-- RAVEN项目 - 酒吧评论数据 (批次 3)
-- 生成时间: 2025-08-23T06:00:20.187Z
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
    75 as quality_rating,
    59 as price_rating,
    98 as vibe_rating,
    83 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-03-28T11:47:55.545Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    51 as price_rating,
    91 as vibe_rating,
    37 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-10T13:14:04.257Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    41 as quality_rating,
    64 as price_rating,
    81 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-03-03T06:55:05.949Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    98 as price_rating,
    84 as vibe_rating,
    67 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-07-26T00:35:16.261Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    81 as price_rating,
    86 as vibe_rating,
    96 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-06-27T12:21:49.569Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    57 as price_rating,
    83 as vibe_rating,
    93 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    41 as queue_time,
    true as is_anonymous,
    '2025-07-07T06:08:05.663Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    87 as price_rating,
    99 as vibe_rating,
    80 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-27T22:34:21.254Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    89 as price_rating,
    69 as vibe_rating,
    67 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-20T08:18:25.397Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    94 as price_rating,
    59 as vibe_rating,
    81 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    33 as queue_time,
    true as is_anonymous,
    '2025-06-20T01:57:23.057Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    72 as price_rating,
    97 as vibe_rating,
    46 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-22T05:15:13.300Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    97 as price_rating,
    100 as vibe_rating,
    97 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-07-29T17:01:31.326Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    53 as price_rating,
    98 as vibe_rating,
    91 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-07-24T00:44:36.121Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    80 as price_rating,
    48 as vibe_rating,
    59 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-16T16:29:52.007Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    65 as price_rating,
    85 as vibe_rating,
    44 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    40 as queue_time,
    false as is_anonymous,
    '2025-03-07T01:51:34.214Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    79 as price_rating,
    88 as vibe_rating,
    87 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-25T02:40:43.766Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    31 as quality_rating,
    99 as price_rating,
    67 as vibe_rating,
    89 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-07-27T10:23:19.597Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    98 as quality_rating,
    66 as price_rating,
    77 as vibe_rating,
    66 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    13 as queue_time,
    false as is_anonymous,
    '2025-03-15T21:46:58.333Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    47 as price_rating,
    51 as vibe_rating,
    67 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-30T06:02:10.971Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    98 as price_rating,
    74 as vibe_rating,
    94 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    39 as queue_time,
    true as is_anonymous,
    '2025-06-12T11:28:48.626Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    94 as price_rating,
    99 as vibe_rating,
    60 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-16T04:12:03.038Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    87 as price_rating,
    70 as vibe_rating,
    75 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-04T14:11:05.153Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    71 as price_rating,
    66 as vibe_rating,
    85 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-06-23T00:21:48.169Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    75 as price_rating,
    100 as vibe_rating,
    89 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-24T20:28:26.464Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    65 as price_rating,
    85 as vibe_rating,
    84 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-04-09T00:30:41.767Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    62 as price_rating,
    81 as vibe_rating,
    74 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-02-24T09:00:53.531Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    54 as price_rating,
    80 as vibe_rating,
    57 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    18 as queue_time,
    false as is_anonymous,
    '2025-07-26T11:10:02.037Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    46 as price_rating,
    66 as vibe_rating,
    76 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-21T05:48:51.784Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    97 as price_rating,
    80 as vibe_rating,
    65 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    40 as queue_time,
    false as is_anonymous,
    '2025-04-02T17:20:51.761Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    74 as quality_rating,
    78 as price_rating,
    70 as vibe_rating,
    54 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-07-25T08:06:28.818Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    71 as price_rating,
    82 as vibe_rating,
    94 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-07-20T04:57:58.949Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    94 as price_rating,
    77 as vibe_rating,
    81 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    4 as queue_time,
    false as is_anonymous,
    '2025-05-03T22:53:43.607Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    79 as price_rating,
    82 as vibe_rating,
    65 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-08-15T10:52:22.329Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    97 as price_rating,
    82 as vibe_rating,
    71 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-06-30T02:43:46.322Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    81 as price_rating,
    87 as vibe_rating,
    87 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-05-31T17:54:23.387Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    92 as price_rating,
    41 as vibe_rating,
    60 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    44 as queue_time,
    true as is_anonymous,
    '2025-05-23T01:46:29.345Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    67 as price_rating,
    73 as vibe_rating,
    95 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    22 as queue_time,
    true as is_anonymous,
    '2025-04-27T07:19:56.348Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    53 as price_rating,
    74 as vibe_rating,
    80 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    41 as queue_time,
    false as is_anonymous,
    '2025-04-24T02:17:36.982Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    71 as price_rating,
    71 as vibe_rating,
    92 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    20 as queue_time,
    true as is_anonymous,
    '2025-04-05T23:20:23.754Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    88 as price_rating,
    45 as vibe_rating,
    88 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    44 as queue_time,
    false as is_anonymous,
    '2025-06-17T11:53:39.964Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    69 as price_rating,
    72 as vibe_rating,
    92 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-05T10:26:01.245Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    84 as price_rating,
    83 as vibe_rating,
    71 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-04-22T05:24:44.163Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    57 as price_rating,
    77 as vibe_rating,
    75 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-13T02:50:02.566Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    63 as quality_rating,
    68 as price_rating,
    52 as vibe_rating,
    73 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    1 as queue_time,
    false as is_anonymous,
    '2025-08-03T04:31:14.910Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    58 as price_rating,
    46 as vibe_rating,
    35 as friendliness_rating,
    'Too crowded and expensive for what you get.' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-07-20T13:36:55.974Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    88 as quality_rating,
    87 as price_rating,
    99 as vibe_rating,
    70 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-15T16:15:57.643Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    61 as price_rating,
    31 as vibe_rating,
    85 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-06-30T23:28:02.100Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    81 as price_rating,
    68 as vibe_rating,
    91 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-03-16T19:59:24.848Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    56 as price_rating,
    75 as vibe_rating,
    77 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-03-17T07:07:09.511Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    85 as price_rating,
    83 as vibe_rating,
    81 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-04-15T11:50:44.505Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    47 as quality_rating,
    82 as price_rating,
    85 as vibe_rating,
    41 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-06-07T12:00:15.106Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    57 as price_rating,
    85 as vibe_rating,
    91 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    3 as queue_time,
    false as is_anonymous,
    '2025-03-29T09:02:20.836Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    35 as price_rating,
    62 as vibe_rating,
    85 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-07-26T06:56:04.059Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    96 as price_rating,
    53 as vibe_rating,
    99 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    33 as queue_time,
    true as is_anonymous,
    '2025-07-01T02:32:25.494Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    85 as price_rating,
    81 as vibe_rating,
    58 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-14T14:34:39.542Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    55 as price_rating,
    71 as vibe_rating,
    84 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    24 as queue_time,
    true as is_anonymous,
    '2025-03-14T05:25:32.836Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    30 as price_rating,
    90 as vibe_rating,
    61 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    13 as queue_time,
    false as is_anonymous,
    '2025-03-01T11:49:25.627Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    36 as price_rating,
    65 as vibe_rating,
    34 as friendliness_rating,
    '价格太贵了，而且服务态度不好。' as review_text,
    3 as queue_time,
    true as is_anonymous,
    '2025-08-03T12:23:14.140Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    79 as price_rating,
    69 as vibe_rating,
    67 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-07-17T20:36:41.478Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    95 as price_rating,
    52 as vibe_rating,
    57 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-04-10T01:55:09.108Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    59 as price_rating,
    75 as vibe_rating,
    95 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    12 as queue_time,
    false as is_anonymous,
    '2025-03-09T08:14:33.035Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    58 as price_rating,
    90 as vibe_rating,
    93 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-03-30T13:21:08.712Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    42 as price_rating,
    76 as vibe_rating,
    80 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-24T14:02:41.994Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    72 as price_rating,
    54 as vibe_rating,
    71 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-07-30T06:43:51.044Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    99 as price_rating,
    96 as vibe_rating,
    71 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    8 as queue_time,
    false as is_anonymous,
    '2025-08-10T10:03:40.477Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    99 as price_rating,
    67 as vibe_rating,
    55 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    9 as queue_time,
    false as is_anonymous,
    '2025-06-25T04:41:17.331Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    57 as quality_rating,
    100 as price_rating,
    81 as vibe_rating,
    66 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-30T04:17:56.687Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    62 as price_rating,
    74 as vibe_rating,
    75 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-05-22T10:28:56.455Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    78 as price_rating,
    84 as vibe_rating,
    66 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-07-25T04:21:57.794Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    53 as price_rating,
    91 as vibe_rating,
    65 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-04-30T05:09:05.417Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    57 as price_rating,
    77 as vibe_rating,
    96 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-06-30T17:14:40.334Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    84 as price_rating,
    54 as vibe_rating,
    47 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-29T19:05:31.245Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    91 as price_rating,
    84 as vibe_rating,
    75 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-05-18T00:27:34.938Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    80 as price_rating,
    95 as vibe_rating,
    72 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-22T22:21:34.712Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    47 as quality_rating,
    90 as price_rating,
    87 as vibe_rating,
    84 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-09T15:33:42.888Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    83 as price_rating,
    84 as vibe_rating,
    82 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-08-12T06:59:12.808Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    68 as price_rating,
    46 as vibe_rating,
    67 as friendliness_rating,
    'Service was slow and drinks were overpriced.' as review_text,
    27 as queue_time,
    false as is_anonymous,
    '2025-06-08T10:04:30.862Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    36 as quality_rating,
    84 as price_rating,
    84 as vibe_rating,
    67 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-06-10T17:45:38.135Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    60 as quality_rating,
    95 as price_rating,
    39 as vibe_rating,
    62 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    7 as queue_time,
    true as is_anonymous,
    '2025-08-16T19:23:20.345Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    72 as quality_rating,
    80 as price_rating,
    83 as vibe_rating,
    86 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    13 as queue_time,
    true as is_anonymous,
    '2025-04-05T23:45:53.403Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    97 as price_rating,
    97 as vibe_rating,
    80 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    2 as queue_time,
    true as is_anonymous,
    '2025-05-21T15:51:43.962Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    53 as price_rating,
    87 as vibe_rating,
    39 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    27 as queue_time,
    false as is_anonymous,
    '2025-07-29T08:30:24.870Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    40 as quality_rating,
    71 as price_rating,
    90 as vibe_rating,
    94 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    19 as queue_time,
    false as is_anonymous,
    '2025-08-09T16:06:56.058Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    93 as quality_rating,
    85 as price_rating,
    52 as vibe_rating,
    54 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    14 as queue_time,
    false as is_anonymous,
    '2025-06-29T15:25:21.127Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    84 as price_rating,
    82 as vibe_rating,
    72 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-06-20T19:11:22.319Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    80 as price_rating,
    41 as vibe_rating,
    91 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    28 as queue_time,
    true as is_anonymous,
    '2025-03-21T10:57:43.661Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    96 as price_rating,
    51 as vibe_rating,
    86 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    2 as queue_time,
    true as is_anonymous,
    '2025-05-23T00:11:58.933Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    84 as price_rating,
    69 as vibe_rating,
    75 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-20T20:51:35.060Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    89 as quality_rating,
    83 as price_rating,
    70 as vibe_rating,
    69 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-03-17T10:52:00.191Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    66 as price_rating,
    41 as vibe_rating,
    95 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    41 as queue_time,
    true as is_anonymous,
    '2025-05-25T06:31:00.095Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    95 as price_rating,
    54 as vibe_rating,
    99 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    9 as queue_time,
    false as is_anonymous,
    '2025-03-23T22:16:44.156Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    94 as price_rating,
    66 as vibe_rating,
    93 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-09T22:13:54.759Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    38 as price_rating,
    66 as vibe_rating,
    60 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-02T14:23:43.998Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    62 as price_rating,
    97 as vibe_rating,
    85 as friendliness_rating,
    'Unique concept and fantastic drinks. A hidden gem in Berlin!' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-08-08T17:09:57.135Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    81 as price_rating,
    84 as vibe_rating,
    97 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-06-14T10:42:28.980Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    67 as price_rating,
    52 as vibe_rating,
    62 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-03-16T05:03:40.674Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    69 as price_rating,
    89 as vibe_rating,
    96 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-05T08:53:00.439Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    72 as price_rating,
    90 as vibe_rating,
    78 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-05-22T02:20:47.262Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    38 as quality_rating,
    94 as price_rating,
    99 as vibe_rating,
    95 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-31T18:08:52.406Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    90 as price_rating,
    71 as vibe_rating,
    85 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-19T10:48:38.327Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    65 as price_rating,
    62 as vibe_rating,
    80 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-08-17T10:52:51.961Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
