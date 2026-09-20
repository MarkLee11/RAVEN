const { createClient } = require('@supabase/supabase-js');
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL || 'https://gwwahjmagznitbsgtlid.supabase.co';
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3d2Foam1hZ3puaXRic2d0bGlkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTEzMjEzMCwiZXhwIjoyMDcwNzA4MTMwfQ.jPzUuedhAfa0_1BCEbJxjmrOzPJ3YpkcCOZBrQ4fL-A';

const supabase = createClient(supabaseUrl, supabaseServiceKey);

// 德语和英语评论模板
const reviewTemplates = {
  positive: [
    "Tolle Atmosphäre und freundliches Personal. Die Drinks sind erstklassig!",
    "Great atmosphere and friendly staff. The drinks are top-notch!",
    "Perfekter Ort für einen entspannten Abend. Sehr zu empfehlen!",
    "Perfect place for a relaxed evening. Highly recommended!",
    "Die Musik war großartig und die Stimmung war fantastisch.",
    "The music was great and the vibe was fantastic.",
    "Ausgezeichnete Cocktails und eine wunderbare Einrichtung.",
    "Excellent cocktails and wonderful decor.",
    "Sehr gute Preise für die Qualität der Getränke.",
    "Very good prices for the quality of drinks."
  ],
  neutral: [
    "Ganz okay, aber nichts Besonderes. Durchschnittliche Erfahrung.",
    "Quite okay, but nothing special. Average experience.",
    "Die Bar ist in Ordnung, könnte aber besser sein.",
    "The bar is alright, but could be better.",
    "Mittelmäßige Drinks, aber die Lage ist gut.",
    "Mediocre drinks, but the location is good.",
    "Nicht schlecht, aber auch nicht herausragend.",
    "Not bad, but not outstanding either.",
    "Durchschnittlicher Service und durchschnittliche Preise.",
    "Average service and average prices."
  ],
  negative: [
    "Enttäuschend. Überteuert und schlechter Service.",
    "Disappointing. Overpriced and poor service.",
    "Die Wartezeit war viel zu lang und die Drinks waren schwach.",
    "The wait time was way too long and the drinks were weak.",
    "Unfreundliches Personal und schlechte Atmosphäre.",
    "Unfriendly staff and poor atmosphere.",
    "Zu laut und zu überfüllt. Nicht empfehlenswert.",
    "Too loud and too crowded. Not recommended.",
    "Die Qualität entspricht nicht dem Preis.",
    "The quality doesn't match the price."
  ]
};

// 主函数
async function main() {
  try {
    console.log('🚀 开始基于现有bar_reviews数据生成bar_ratings...');
    
    // 1. 只删除现有的bar_ratings数据，保留bar_reviews
    await clearExistingRatings();
    
    // 2. 基于现有reviews数据计算每个酒吧的平均评分并生成bar_ratings
    console.log('计算每个酒吧的平均评分并生成bar_ratings数据...');
    await generateBarRatingsFromReviews();
    
    console.log('✅ bar_ratings数据生成完成!');
  } catch (error) {
    console.error('❌ 错误:', error);
    process.exit(1);
  }
}

// 删除现有数据
async function clearExistingData() {
  console.log('🗑️ 删除现有的bar_ratings和bar_reviews数据...');
  
  // 删除bar_ratings
  const { error: ratingsError } = await supabase
    .from('bar_ratings')
    .delete()
    .neq('id', 0); // 删除所有记录
  
  if (ratingsError) {
    throw new Error(`删除bar_ratings失败: ${ratingsError.message}`);
  }
  
  // 删除bar_reviews
  const { error: reviewsError } = await supabase
    .from('bar_reviews')
    .delete()
    .neq('id', 0); // 删除所有记录
  
  if (reviewsError) {
    throw new Error(`删除bar_reviews失败: ${reviewsError.message}`);
  }
  
  console.log('✅ 现有数据删除完成');
}

// 只删除现有的bar_ratings数据
async function clearExistingRatings() {
  console.log('🗑️ 删除现有的bar_ratings数据...');
  
  // 删除bar_ratings
  const { error: ratingsError } = await supabase
    .from('bar_ratings')
    .delete()
    .neq('id', 0); // 删除所有记录
  
  if (ratingsError) {
    throw new Error(`删除bar_ratings失败: ${ratingsError.message}`);
  }
  
  console.log('✅ 现有bar_ratings数据删除完成');
}

// 获取基础数据
async function fetchBaseData() {
  console.log('📊 获取基础数据...');
  
  // 获取bars数据
  const { data: bars, error: barsError } = await supabase
    .from('bars')
    .select('id, name, district_id');
  
  if (barsError) {
    throw new Error(`获取bars数据失败: ${barsError.message}`);
  }
  
  // Get users from auth.users table using RPC function
  const { data: users, error: usersError } = await supabase
    .rpc('get_auth_users_for_reviews');
  
  if (usersError) {
    console.error('Error fetching users:', usersError);
    // Fallback: create a simple RPC function or use service role to query
    console.log('Attempting alternative method to get users...');
    
    // Alternative: Use raw SQL query with service role
    const { data: authUsers, error: authError } = await supabase
      .from('profiles')
      .select('id, email')
      .limit(100);
    
    if (authError || !authUsers || authUsers.length === 0) {
      console.log('No users found in profiles table, using mock data');
      // Generate some mock user IDs that exist in auth.users
      const mockUsers = [
        { id: '00000000-0000-0000-0000-000000000001', email: 'user1@example.com' },
        { id: '00000000-0000-0000-0000-000000000002', email: 'user2@example.com' },
        { id: '00000000-0000-0000-0000-000000000003', email: 'user3@example.com' },
        { id: '00000000-0000-0000-0000-000000000004', email: 'user4@example.com' },
        { id: '00000000-0000-0000-0000-000000000005', email: 'user5@example.com' }
      ];
      
      console.log(`Using ${mockUsers.length} mock users`);
      return { bars, users: mockUsers, themes };
    }
    
    const mappedUsers = authUsers.map(user => ({
      id: user.id,
      username: user.email ? user.email.split('@')[0] : `user_${user.id.slice(0, 8)}`
    }));
    
    console.log(`Found ${mappedUsers.length} users from profiles table`);
    return { bars, users: mappedUsers, themes };
  }
  
  console.log(`Found ${users.length} users from RPC function`);
  
  // 获取themes数据
  const { data: themes, error: themesError } = await supabase
    .from('themes')
    .select('id, name, category');
  
  if (themesError) {
    throw new Error(`获取themes数据失败: ${themesError.message}`);
  }
  
  console.log(`✅ 获取到 ${bars.length} 个bars, ${users.length} 个users, ${themes.length} 个themes`);
  
  return { bars, users, themes };
}

// 生成随机评分 (0-100)
function generateRandomRating() {
  return Math.floor(Math.random() * 101);
}

// 生成随机评论文本
function generateRandomReviewText(averageRating) {
  let category;
  if (averageRating >= 70) {
    category = 'positive';
  } else if (averageRating >= 40) {
    category = 'neutral';
  } else {
    category = 'negative';
  }
  
  const templates = reviewTemplates[category];
  return templates[Math.floor(Math.random() * templates.length)];
}

// 生成随机队列时间 (0-60分钟)
function generateRandomQueueTime() {
  return Math.floor(Math.random() * 61);
}

// 生成单条review数据
function generateReviewData(bars, users) {
  const bar = bars[Math.floor(Math.random() * bars.length)];
  const user = users[Math.floor(Math.random() * users.length)];
  
  const qualityRating = generateRandomRating();
  const priceRating = generateRandomRating();
  const vibeRating = generateRandomRating();
  const friendlinessRating = generateRandomRating();
  
  const averageRating = (qualityRating + priceRating + vibeRating + friendlinessRating) / 4;
  
  return {
    bar_id: bar.id,
    user_id: user.id,
    quality_rating: qualityRating,
    price_rating: priceRating,
    vibe_rating: vibeRating,
    friendliness_rating: friendlinessRating,
    review_text: generateRandomReviewText(averageRating),
    queue_time: generateRandomQueueTime(),
    is_anonymous: Math.random() > 0.5,
    created_at: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000).toISOString() // 随机过去一年内的时间
  };
}

// 基于reviews数据生成bar_ratings
async function generateBarRatingsFromReviews() {
  try {
    // 查询所有reviews数据，按bar_id分组计算平均值
    const { data: reviewsData, error: reviewsError } = await supabase
      .from('bar_reviews')
      .select('bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating');
    
    if (reviewsError) {
      console.error('查询reviews数据时出错:', reviewsError);
      throw reviewsError;
    }
    
    console.log(`找到 ${reviewsData.length} 条reviews记录`);
    
    // 按bar_id分组并计算平均值
    const barRatingsMap = new Map();
    
    reviewsData.forEach(review => {
      const barId = review.bar_id;
      
      if (!barRatingsMap.has(barId)) {
        barRatingsMap.set(barId, {
          bar_id: barId,
          quality_ratings: [],
          price_ratings: [],
          vibe_ratings: [],
          friendliness_ratings: []
        });
      }
      
      const barData = barRatingsMap.get(barId);
      barData.quality_ratings.push(review.quality_rating);
      barData.price_ratings.push(review.price_rating);
      barData.vibe_ratings.push(review.vibe_rating);
      barData.friendliness_ratings.push(review.friendliness_rating);
    });
    
    // 计算平均值并生成bar_ratings数据
    const ratingsData = [];
    
    barRatingsMap.forEach((barData, barId) => {
      const avgQuality = barData.quality_ratings.reduce((sum, rating) => sum + rating, 0) / barData.quality_ratings.length;
      const avgPrice = barData.price_ratings.reduce((sum, rating) => sum + rating, 0) / barData.price_ratings.length;
      const avgVibe = barData.vibe_ratings.reduce((sum, rating) => sum + rating, 0) / barData.vibe_ratings.length;
      const avgFriendliness = barData.friendliness_ratings.reduce((sum, rating) => sum + rating, 0) / barData.friendliness_ratings.length;
      
      ratingsData.push({
        bar_id: barId,
        quality_rating: Math.round(avgQuality), // 转换为整数
        price_rating: Math.round(avgPrice),
        vibe_rating: Math.round(avgVibe),
        friendliness_rating: Math.round(avgFriendliness),
        created_at: new Date().toISOString()
      });
    });
    
    console.log(`为 ${ratingsData.length} 个酒吧生成平均评分数据`);
    
    // 插入bar_ratings数据
    const { error: ratingsError } = await supabase
      .from('bar_ratings')
      .insert(ratingsData);
    
    if (ratingsError) {
      console.error('插入 ratings 数据时出错:', ratingsError);
      throw ratingsError;
    }
    
    console.log('bar_ratings数据插入成功！');
    
  } catch (error) {
    console.error('生成bar_ratings数据时出错:', error);
    throw error;
  }
}

// 生成并插入数据的主函数
async function generateAndInsertData(bars, users, themes) {
  console.log('开始生成并插入数据...');
  
  // 第一步：生成1000条bar_reviews数据
  console.log('第一步：生成1000条bar_reviews数据...');
  const totalReviews = 1000;
  const batchSize = 100;
  const totalBatches = Math.ceil(totalReviews / batchSize);
  
  for (let batch = 0; batch < totalBatches; batch++) {
    const currentBatchSize = Math.min(batchSize, totalReviews - batch * batchSize);
    console.log(`正在处理第 ${batch + 1}/${totalBatches} 批次reviews，包含 ${currentBatchSize} 条记录...`);
    
    const reviewsData = [];
    
    for (let i = 0; i < currentBatchSize; i++) {
      const reviewData = generateReviewData(bars, users, themes);
      reviewsData.push(reviewData);
    }
    
    try {
      // 插入 reviews 数据
      const { error: reviewsError } = await supabase
        .from('bar_reviews')
        .insert(reviewsData);
      
      if (reviewsError) {
        console.error('插入 reviews 数据时出错:', reviewsError);
        throw reviewsError;
      }
      
      console.log(`第 ${batch + 1} 批次reviews数据插入成功`);
    } catch (error) {
      console.error(`第 ${batch + 1} 批次reviews数据插入失败:`, error);
      throw error;
    }
  }
  
  console.log('所有reviews数据插入完成！');
  
  // 第二步：基于reviews数据计算每个酒吧的平均评分并生成bar_ratings
  console.log('第二步：计算每个酒吧的平均评分并生成bar_ratings数据...');
  await generateBarRatingsFromReviews();
  
  console.log('所有数据生成完成！');
}

// 运行脚本
if (require.main === module) {
  main();
}

module.exports = {
  main,
  clearExistingData,
  fetchBaseData,
  generateAndInsertData
};