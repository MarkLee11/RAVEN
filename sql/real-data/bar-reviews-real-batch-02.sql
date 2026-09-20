-- RAVEN项目 - 酒吧评论数据 (批次 2)
-- 生成时间: 2025-08-23T06:00:20.182Z
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
    64 as quality_rating,
    79 as price_rating,
    67 as vibe_rating,
    97 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-08-17T04:24:13.707Z'::timestamptz as created_at
  FROM random_combinations OFFSET 0 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    85 as quality_rating,
    66 as price_rating,
    95 as vibe_rating,
    58 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-31T18:46:50.653Z'::timestamptz as created_at
  FROM random_combinations OFFSET 1 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    90 as price_rating,
    81 as vibe_rating,
    98 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-03-29T04:13:33.544Z'::timestamptz as created_at
  FROM random_combinations OFFSET 2 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    66 as price_rating,
    100 as vibe_rating,
    100 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-08-21T03:38:14.779Z'::timestamptz as created_at
  FROM random_combinations OFFSET 3 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    54 as quality_rating,
    73 as price_rating,
    59 as vibe_rating,
    61 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-04-19T12:59:45.859Z'::timestamptz as created_at
  FROM random_combinations OFFSET 4 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    82 as quality_rating,
    35 as price_rating,
    84 as vibe_rating,
    81 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-12T13:18:03.533Z'::timestamptz as created_at
  FROM random_combinations OFFSET 5 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    78 as price_rating,
    95 as vibe_rating,
    84 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-05-23T12:46:45.733Z'::timestamptz as created_at
  FROM random_combinations OFFSET 6 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    70 as quality_rating,
    93 as price_rating,
    50 as vibe_rating,
    54 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    21 as queue_time,
    true as is_anonymous,
    '2025-04-30T21:32:40.912Z'::timestamptz as created_at
  FROM random_combinations OFFSET 7 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    82 as price_rating,
    79 as vibe_rating,
    48 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-01T10:16:06.923Z'::timestamptz as created_at
  FROM random_combinations OFFSET 8 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    80 as quality_rating,
    47 as price_rating,
    72 as vibe_rating,
    80 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    36 as queue_time,
    false as is_anonymous,
    '2025-05-29T05:34:15.671Z'::timestamptz as created_at
  FROM random_combinations OFFSET 9 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    71 as price_rating,
    67 as vibe_rating,
    51 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-02-25T20:41:33.507Z'::timestamptz as created_at
  FROM random_combinations OFFSET 10 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    84 as price_rating,
    68 as vibe_rating,
    69 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-04-23T13:44:07.228Z'::timestamptz as created_at
  FROM random_combinations OFFSET 11 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    44 as price_rating,
    88 as vibe_rating,
    77 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-04-26T15:17:13.152Z'::timestamptz as created_at
  FROM random_combinations OFFSET 12 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    82 as price_rating,
    73 as vibe_rating,
    65 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    14 as queue_time,
    false as is_anonymous,
    '2025-07-30T15:50:55.061Z'::timestamptz as created_at
  FROM random_combinations OFFSET 13 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    69 as price_rating,
    69 as vibe_rating,
    70 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-06-02T19:54:47.629Z'::timestamptz as created_at
  FROM random_combinations OFFSET 14 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    62 as quality_rating,
    89 as price_rating,
    59 as vibe_rating,
    55 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    32 as queue_time,
    true as is_anonymous,
    '2025-04-15T19:30:50.912Z'::timestamptz as created_at
  FROM random_combinations OFFSET 15 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    50 as quality_rating,
    65 as price_rating,
    54 as vibe_rating,
    72 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-17T18:13:56.445Z'::timestamptz as created_at
  FROM random_combinations OFFSET 16 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    39 as price_rating,
    30 as vibe_rating,
    85 as friendliness_rating,
    '太吵了，根本听不见朋友说话。不推荐。' as review_text,
    15 as queue_time,
    true as is_anonymous,
    '2025-04-14T07:29:12.321Z'::timestamptz as created_at
  FROM random_combinations OFFSET 17 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    70 as price_rating,
    75 as vibe_rating,
    66 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    29 as queue_time,
    true as is_anonymous,
    '2025-06-05T20:55:51.319Z'::timestamptz as created_at
  FROM random_combinations OFFSET 18 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    100 as price_rating,
    75 as vibe_rating,
    83 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-04-24T13:13:37.227Z'::timestamptz as created_at
  FROM random_combinations OFFSET 19 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    42 as quality_rating,
    99 as price_rating,
    73 as vibe_rating,
    84 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    26 as queue_time,
    true as is_anonymous,
    '2025-04-16T11:09:33.406Z'::timestamptz as created_at
  FROM random_combinations OFFSET 20 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    97 as price_rating,
    95 as vibe_rating,
    99 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    42 as queue_time,
    true as is_anonymous,
    '2025-05-07T10:13:11.748Z'::timestamptz as created_at
  FROM random_combinations OFFSET 21 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    66 as price_rating,
    67 as vibe_rating,
    45 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    24 as queue_time,
    false as is_anonymous,
    '2025-06-11T20:17:31.093Z'::timestamptz as created_at
  FROM random_combinations OFFSET 22 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    65 as price_rating,
    48 as vibe_rating,
    50 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-07-31T06:19:36.339Z'::timestamptz as created_at
  FROM random_combinations OFFSET 23 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    73 as price_rating,
    65 as vibe_rating,
    99 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-07-27T18:59:42.821Z'::timestamptz as created_at
  FROM random_combinations OFFSET 24 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    59 as price_rating,
    85 as vibe_rating,
    85 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-06-09T02:32:06.205Z'::timestamptz as created_at
  FROM random_combinations OFFSET 25 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    50 as price_rating,
    94 as vibe_rating,
    61 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    30 as queue_time,
    false as is_anonymous,
    '2025-07-16T16:19:20.459Z'::timestamptz as created_at
  FROM random_combinations OFFSET 26 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    32 as quality_rating,
    58 as price_rating,
    75 as vibe_rating,
    71 as friendliness_rating,
    'Not impressed. Better options available nearby.' as review_text,
    26 as queue_time,
    true as is_anonymous,
    '2025-03-13T09:38:16.722Z'::timestamptz as created_at
  FROM random_combinations OFFSET 27 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    74 as price_rating,
    51 as vibe_rating,
    57 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-08-08T11:07:32.017Z'::timestamptz as created_at
  FROM random_combinations OFFSET 28 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    64 as quality_rating,
    95 as price_rating,
    98 as vibe_rating,
    66 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-08-13T21:37:16.710Z'::timestamptz as created_at
  FROM random_combinations OFFSET 29 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    68 as price_rating,
    75 as vibe_rating,
    93 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    6 as queue_time,
    true as is_anonymous,
    '2025-08-15T15:55:13.449Z'::timestamptz as created_at
  FROM random_combinations OFFSET 30 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    52 as price_rating,
    93 as vibe_rating,
    82 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    30 as queue_time,
    true as is_anonymous,
    '2025-04-16T08:55:15.796Z'::timestamptz as created_at
  FROM random_combinations OFFSET 31 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    69 as price_rating,
    95 as vibe_rating,
    84 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-08-16T19:42:16.715Z'::timestamptz as created_at
  FROM random_combinations OFFSET 32 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    45 as quality_rating,
    76 as price_rating,
    75 as vibe_rating,
    97 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-12T06:33:04.754Z'::timestamptz as created_at
  FROM random_combinations OFFSET 33 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    76 as price_rating,
    91 as vibe_rating,
    71 as friendliness_rating,
    '装修很有特色，饮品质量也很高。推荐给朋友们！' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-02T17:26:25.886Z'::timestamptz as created_at
  FROM random_combinations OFFSET 34 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    93 as price_rating,
    66 as vibe_rating,
    89 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-05-10T15:02:11.116Z'::timestamptz as created_at
  FROM random_combinations OFFSET 35 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    66 as price_rating,
    85 as vibe_rating,
    80 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    36 as queue_time,
    false as is_anonymous,
    '2025-03-04T02:48:28.050Z'::timestamptz as created_at
  FROM random_combinations OFFSET 36 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    55 as quality_rating,
    87 as price_rating,
    91 as vibe_rating,
    67 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    27 as queue_time,
    true as is_anonymous,
    '2025-03-05T19:26:40.879Z'::timestamptz as created_at
  FROM random_combinations OFFSET 37 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    59 as quality_rating,
    34 as price_rating,
    43 as vibe_rating,
    50 as friendliness_rating,
    '价格太贵了，而且服务态度不好。' as review_text,
    15 as queue_time,
    false as is_anonymous,
    '2025-04-16T06:48:55.736Z'::timestamptz as created_at
  FROM random_combinations OFFSET 38 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    48 as quality_rating,
    79 as price_rating,
    68 as vibe_rating,
    81 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    11 as queue_time,
    true as is_anonymous,
    '2025-06-20T02:32:43.161Z'::timestamptz as created_at
  FROM random_combinations OFFSET 39 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    33 as price_rating,
    84 as vibe_rating,
    54 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-02-26T14:22:46.359Z'::timestamptz as created_at
  FROM random_combinations OFFSET 40 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    39 as price_rating,
    75 as vibe_rating,
    76 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    14 as queue_time,
    true as is_anonymous,
    '2025-04-24T18:27:16.953Z'::timestamptz as created_at
  FROM random_combinations OFFSET 41 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    68 as price_rating,
    57 as vibe_rating,
    84 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-04-14T02:29:45.974Z'::timestamptz as created_at
  FROM random_combinations OFFSET 42 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    67 as price_rating,
    80 as vibe_rating,
    57 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    11 as queue_time,
    false as is_anonymous,
    '2025-08-01T05:14:09.716Z'::timestamptz as created_at
  FROM random_combinations OFFSET 43 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    75 as quality_rating,
    83 as price_rating,
    85 as vibe_rating,
    57 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    38 as queue_time,
    true as is_anonymous,
    '2025-05-15T20:17:48.516Z'::timestamptz as created_at
  FROM random_combinations OFFSET 44 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    39 as price_rating,
    99 as vibe_rating,
    89 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-08-21T09:26:52.311Z'::timestamptz as created_at
  FROM random_combinations OFFSET 45 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    91 as price_rating,
    33 as vibe_rating,
    98 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-07-22T03:07:59.355Z'::timestamptz as created_at
  FROM random_combinations OFFSET 46 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    85 as price_rating,
    100 as vibe_rating,
    95 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    17 as queue_time,
    false as is_anonymous,
    '2025-03-08T20:26:02.309Z'::timestamptz as created_at
  FROM random_combinations OFFSET 47 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    58 as quality_rating,
    61 as price_rating,
    81 as vibe_rating,
    68 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    29 as queue_time,
    false as is_anonymous,
    '2025-02-24T14:16:36.425Z'::timestamptz as created_at
  FROM random_combinations OFFSET 48 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    80 as price_rating,
    94 as vibe_rating,
    100 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-06-12T17:25:14.685Z'::timestamptz as created_at
  FROM random_combinations OFFSET 49 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    99 as quality_rating,
    61 as price_rating,
    94 as vibe_rating,
    85 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-04T06:30:23.678Z'::timestamptz as created_at
  FROM random_combinations OFFSET 50 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    72 as price_rating,
    80 as vibe_rating,
    73 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    18 as queue_time,
    true as is_anonymous,
    '2025-07-13T07:48:02.013Z'::timestamptz as created_at
  FROM random_combinations OFFSET 51 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    68 as price_rating,
    81 as vibe_rating,
    88 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    45 as queue_time,
    true as is_anonymous,
    '2025-03-30T14:17:09.745Z'::timestamptz as created_at
  FROM random_combinations OFFSET 52 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    32 as price_rating,
    84 as vibe_rating,
    88 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    6 as queue_time,
    false as is_anonymous,
    '2025-08-06T00:33:25.206Z'::timestamptz as created_at
  FROM random_combinations OFFSET 53 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    78 as quality_rating,
    85 as price_rating,
    83 as vibe_rating,
    74 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    33 as queue_time,
    false as is_anonymous,
    '2025-07-07T03:58:20.332Z'::timestamptz as created_at
  FROM random_combinations OFFSET 54 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    79 as quality_rating,
    93 as price_rating,
    72 as vibe_rating,
    72 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    12 as queue_time,
    true as is_anonymous,
    '2025-07-20T22:27:00.229Z'::timestamptz as created_at
  FROM random_combinations OFFSET 55 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    97 as price_rating,
    61 as vibe_rating,
    80 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-06T16:31:58.639Z'::timestamptz as created_at
  FROM random_combinations OFFSET 56 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    90 as price_rating,
    59 as vibe_rating,
    71 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    23 as queue_time,
    true as is_anonymous,
    '2025-03-09T22:01:24.748Z'::timestamptz as created_at
  FROM random_combinations OFFSET 57 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    88 as price_rating,
    100 as vibe_rating,
    31 as friendliness_rating,
    'Average place, drinks are fine but atmosphere could be better.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-01T20:15:39.343Z'::timestamptz as created_at
  FROM random_combinations OFFSET 58 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    32 as quality_rating,
    83 as price_rating,
    66 as vibe_rating,
    86 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-05T16:58:30.623Z'::timestamptz as created_at
  FROM random_combinations OFFSET 59 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    66 as price_rating,
    75 as vibe_rating,
    77 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-05-21T10:06:41.538Z'::timestamptz as created_at
  FROM random_combinations OFFSET 60 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    90 as price_rating,
    44 as vibe_rating,
    95 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-03-30T15:55:42.946Z'::timestamptz as created_at
  FROM random_combinations OFFSET 61 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    66 as price_rating,
    63 as vibe_rating,
    66 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    16 as queue_time,
    false as is_anonymous,
    '2025-06-23T18:22:45.261Z'::timestamptz as created_at
  FROM random_combinations OFFSET 62 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    76 as quality_rating,
    90 as price_rating,
    74 as vibe_rating,
    93 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    10 as queue_time,
    true as is_anonymous,
    '2025-04-01T13:25:28.927Z'::timestamptz as created_at
  FROM random_combinations OFFSET 63 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    61 as price_rating,
    77 as vibe_rating,
    86 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    17 as queue_time,
    false as is_anonymous,
    '2025-06-11T00:39:57.724Z'::timestamptz as created_at
  FROM random_combinations OFFSET 64 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    68 as price_rating,
    81 as vibe_rating,
    89 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    25 as queue_time,
    true as is_anonymous,
    '2025-03-30T14:49:56.297Z'::timestamptz as created_at
  FROM random_combinations OFFSET 65 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    75 as price_rating,
    74 as vibe_rating,
    97 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-18T20:39:04.101Z'::timestamptz as created_at
  FROM random_combinations OFFSET 66 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    84 as price_rating,
    70 as vibe_rating,
    80 as friendliness_rating,
    'Perfect place for a night out with friends. Love the music!' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-07-17T10:09:59.218Z'::timestamptz as created_at
  FROM random_combinations OFFSET 67 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    90 as quality_rating,
    79 as price_rating,
    41 as vibe_rating,
    92 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    39 as queue_time,
    false as is_anonymous,
    '2025-08-09T12:49:26.221Z'::timestamptz as created_at
  FROM random_combinations OFFSET 68 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    30 as quality_rating,
    68 as price_rating,
    89 as vibe_rating,
    80 as friendliness_rating,
    'Decent bar, nothing special but okay for a quick drink.' as review_text,
    18 as queue_time,
    false as is_anonymous,
    '2025-05-16T11:30:30.045Z'::timestamptz as created_at
  FROM random_combinations OFFSET 69 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    34 as quality_rating,
    92 as price_rating,
    48 as vibe_rating,
    70 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    32 as queue_time,
    false as is_anonymous,
    '2025-03-03T11:24:30.804Z'::timestamptz as created_at
  FROM random_combinations OFFSET 70 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    65 as price_rating,
    83 as vibe_rating,
    71 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-04-16T03:19:08.924Z'::timestamptz as created_at
  FROM random_combinations OFFSET 71 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    71 as quality_rating,
    90 as price_rating,
    75 as vibe_rating,
    94 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-05-20T09:25:39.032Z'::timestamptz as created_at
  FROM random_combinations OFFSET 72 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    100 as quality_rating,
    71 as price_rating,
    85 as vibe_rating,
    70 as friendliness_rating,
    'Amazing cocktails and great atmosphere! Definitely coming back.' as review_text,
    5 as queue_time,
    false as is_anonymous,
    '2025-06-10T02:15:44.426Z'::timestamptz as created_at
  FROM random_combinations OFFSET 73 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    66 as quality_rating,
    86 as price_rating,
    78 as vibe_rating,
    82 as friendliness_rating,
    'Great place for after-work drinks. Professional crowd and good music.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-08-17T14:03:18.880Z'::timestamptz as created_at
  FROM random_combinations OFFSET 74 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    90 as price_rating,
    63 as vibe_rating,
    77 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-05-17T14:19:01.053Z'::timestamptz as created_at
  FROM random_combinations OFFSET 75 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    95 as quality_rating,
    37 as price_rating,
    88 as vibe_rating,
    42 as friendliness_rating,
    'Standard bar experience. Nothing to complain about but nothing exciting.' as review_text,
    35 as queue_time,
    true as is_anonymous,
    '2025-05-20T08:45:40.064Z'::timestamptz as created_at
  FROM random_combinations OFFSET 76 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    73 as quality_rating,
    94 as price_rating,
    73 as vibe_rating,
    67 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-07-07T00:11:54.747Z'::timestamptz as created_at
  FROM random_combinations OFFSET 77 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    81 as quality_rating,
    82 as price_rating,
    33 as vibe_rating,
    81 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    36 as queue_time,
    true as is_anonymous,
    '2025-07-27T15:02:14.262Z'::timestamptz as created_at
  FROM random_combinations OFFSET 78 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    61 as quality_rating,
    75 as price_rating,
    84 as vibe_rating,
    66 as friendliness_rating,
    'Ok for a casual drink, but wouldn''t go out of my way for it.' as review_text,
    9 as queue_time,
    true as is_anonymous,
    '2025-03-20T00:57:40.722Z'::timestamptz as created_at
  FROM random_combinations OFFSET 79 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    91 as price_rating,
    60 as vibe_rating,
    72 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    43 as queue_time,
    true as is_anonymous,
    '2025-03-17T13:06:18.115Z'::timestamptz as created_at
  FROM random_combinations OFFSET 80 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    65 as quality_rating,
    86 as price_rating,
    94 as vibe_rating,
    99 as friendliness_rating,
    'Great music selection and the bartenders know their craft!' as review_text,
    19 as queue_time,
    true as is_anonymous,
    '2025-05-05T11:22:31.217Z'::timestamptz as created_at
  FROM random_combinations OFFSET 81 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    52 as quality_rating,
    58 as price_rating,
    66 as vibe_rating,
    91 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    20 as queue_time,
    false as is_anonymous,
    '2025-06-02T01:02:09.696Z'::timestamptz as created_at
  FROM random_combinations OFFSET 82 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    77 as quality_rating,
    99 as price_rating,
    86 as vibe_rating,
    65 as friendliness_rating,
    'Love the outdoor seating area. Perfect for summer evenings.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-06T05:25:59.786Z'::timestamptz as created_at
  FROM random_combinations OFFSET 83 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    97 as quality_rating,
    74 as price_rating,
    90 as vibe_rating,
    67 as friendliness_rating,
    '这里的鸡尾酒太棒了！氛围也很好，很适合约会。' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-08-16T00:35:12.813Z'::timestamptz as created_at
  FROM random_combinations OFFSET 84 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    91 as quality_rating,
    58 as price_rating,
    79 as vibe_rating,
    53 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    12 as queue_time,
    false as is_anonymous,
    '2025-05-12T08:02:11.778Z'::timestamptz as created_at
  FROM random_combinations OFFSET 85 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    87 as quality_rating,
    70 as price_rating,
    90 as vibe_rating,
    68 as friendliness_rating,
    'Perfect for date night. Romantic atmosphere and excellent cocktails.' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-05-07T07:22:05.815Z'::timestamptz as created_at
  FROM random_combinations OFFSET 86 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    91 as price_rating,
    53 as vibe_rating,
    67 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    7 as queue_time,
    false as is_anonymous,
    '2025-06-02T05:43:52.510Z'::timestamptz as created_at
  FROM random_combinations OFFSET 87 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    84 as quality_rating,
    58 as price_rating,
    79 as vibe_rating,
    63 as friendliness_rating,
    '还可以，但是没什么特别的。饮品一般般。' as review_text,
    43 as queue_time,
    false as is_anonymous,
    '2025-05-04T19:12:19.205Z'::timestamptz as created_at
  FROM random_combinations OFFSET 88 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    65 as price_rating,
    78 as vibe_rating,
    83 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    NULL as queue_time,
    true as is_anonymous,
    '2025-07-20T17:04:34.253Z'::timestamptz as created_at
  FROM random_combinations OFFSET 89 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    83 as quality_rating,
    79 as price_rating,
    100 as vibe_rating,
    83 as friendliness_rating,
    'Great drinks, friendly staff, and cool vibes. What more do you need?' as review_text,
    1 as queue_time,
    true as is_anonymous,
    '2025-08-10T07:48:53.992Z'::timestamptz as created_at
  FROM random_combinations OFFSET 90 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    92 as quality_rating,
    86 as price_rating,
    96 as vibe_rating,
    56 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    4 as queue_time,
    true as is_anonymous,
    '2025-04-30T00:43:40.820Z'::timestamptz as created_at
  FROM random_combinations OFFSET 91 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    56 as quality_rating,
    85 as price_rating,
    84 as vibe_rating,
    88 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    14 as queue_time,
    false as is_anonymous,
    '2025-06-06T08:15:10.585Z'::timestamptz as created_at
  FROM random_combinations OFFSET 92 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    94 as quality_rating,
    71 as price_rating,
    65 as vibe_rating,
    75 as friendliness_rating,
    '服务员很友好，音乐也很棒。会再来的！' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-08-13T05:54:59.532Z'::timestamptz as created_at
  FROM random_combinations OFFSET 93 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    86 as quality_rating,
    47 as price_rating,
    76 as vibe_rating,
    75 as friendliness_rating,
    'It''s alright, might come back if in the area.' as review_text,
    2 as queue_time,
    false as is_anonymous,
    '2025-04-29T03:31:22.967Z'::timestamptz as created_at
  FROM random_combinations OFFSET 94 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    96 as quality_rating,
    48 as price_rating,
    76 as vibe_rating,
    100 as friendliness_rating,
    'Excellent service and beautiful interior design. Highly recommended!' as review_text,
    23 as queue_time,
    false as is_anonymous,
    '2025-07-24T04:20:38.082Z'::timestamptz as created_at
  FROM random_combinations OFFSET 95 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    67 as quality_rating,
    74 as price_rating,
    51 as vibe_rating,
    87 as friendliness_rating,
    '地理位置不错，但是价格有点贵。' as review_text,
    34 as queue_time,
    true as is_anonymous,
    '2025-05-17T21:24:09.825Z'::timestamptz as created_at
  FROM random_combinations OFFSET 96 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    51 as quality_rating,
    66 as price_rating,
    91 as vibe_rating,
    93 as friendliness_rating,
    'Modern and stylish bar with creative cocktails. Love it!' as review_text,
    NULL as queue_time,
    false as is_anonymous,
    '2025-07-30T11:49:14.569Z'::timestamptz as created_at
  FROM random_combinations OFFSET 97 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    68 as quality_rating,
    85 as price_rating,
    78 as vibe_rating,
    92 as friendliness_rating,
    'Fantastic beer selection and authentic German atmosphere.' as review_text,
    21 as queue_time,
    false as is_anonymous,
    '2025-07-13T19:23:28.902Z'::timestamptz as created_at
  FROM random_combinations OFFSET 98 LIMIT 1
  UNION ALL
  SELECT bar_id, user_id,
    69 as quality_rating,
    75 as price_rating,
    96 as vibe_rating,
    69 as friendliness_rating,
    'The jazz music here is incredible. Great place to unwind.' as review_text,
    40 as queue_time,
    true as is_anonymous,
    '2025-03-29T20:26:15.702Z'::timestamptz as created_at
  FROM random_combinations OFFSET 99 LIMIT 1
)
INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at)
SELECT * FROM review_data;
