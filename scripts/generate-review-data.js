const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

// Supabase配置 - 需要从环境变量获取
const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('请设置VITE_SUPABASE_URL和VITE_SUPABASE_ANON_KEY环境变量');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// 中文评价文本模板
const clubReviewTemplates = {
  positive: [
    '音乐超棒，DJ的选曲很有品味，氛围特别好！',
    '这里的vibe真的很赞，人群素质也很高，安全感满满。',
    '音响效果一流，灯光设计很用心，是个放松的好地方。',
    '工作人员很友善，环境干净整洁，会再来的！',
    '音乐风格很对我胃口，人不会太挤，体验很棒。',
    '装修很有格调，音乐质量高，适合和朋友一起来嗨。',
    'DJ现场mix很厉害，氛围营造得很好，推荐！',
    '这里的电子音乐选择很棒，人群很友好，玩得很开心。'
  ],
  neutral: [
    '整体还可以，音乐一般般，人有点多。',
    '环境还行，但是音乐风格不太适合我。',
    '地方不错，就是有点吵，适合年轻人。',
    '服务态度还可以，音乐质量中等水平。',
    '氛围还行，但是人太多了，有点挤。',
    '音乐还可以，但是灯光有点刺眼。'
  ],
  negative: [
    '音乐太吵了，而且选曲不太好，人群比较混杂。',
    '环境一般，音响效果不好，不会再来了。',
    '人太多太挤，音乐也不怎么样，体验不佳。',
    '服务态度不好，音乐声音太大，头疼。',
    '氛围不太好，感觉不太安全，不推荐。'
  ]
};

const barReviewTemplates = {
  positive: [
    '酒的品质很好，调酒师技术一流，环境很棒！',
    '这里的鸡尾酒很有创意，服务员很友善，推荐！',
    '氛围很温馨，酒的价格合理，适合和朋友聊天。',
    '装修很有特色，酒单选择丰富，服务很贴心。',
    '调酒师很专业，推荐的酒都很好喝，会再来的。',
    '环境很舒适，音乐不会太吵，适合约会。',
    '这里的威士忌选择很棒，工作人员很专业。',
    '氛围很好，酒的质量高，价格也合理。'
  ],
  neutral: [
    '酒还可以，但是价格有点贵，环境一般。',
    '服务还行，酒的选择不多，氛围还可以。',
    '地方不错，但是人有点多，需要等位。',
    '酒的质量中等，服务态度还可以。',
    '环境还行，但是音乐有点吵。'
  ],
  negative: [
    '酒的质量不好，价格还很贵，服务态度差。',
    '环境嘈杂，酒单选择少，不会再来了。',
    '等位时间太长，酒的味道一般，体验不佳。',
    '服务员态度不好，酒的价格偏高。',
    '氛围不好，感觉不值这个价钱。'
  ]
};

// 生成随机评分
function generateRating(type) {
  switch (type) {
    case 'positive':
      return Math.floor(Math.random() * 20) + 80; // 80-100
    case 'neutral':
      return Math.floor(Math.random() * 30) + 50; // 50-80
    case 'negative':
      return Math.floor(Math.random() * 30) + 20; // 20-50
    default:
      return Math.floor(Math.random() * 100); // 0-100
  }
}

// 生成随机日期（过去一年内）
function generateRandomDate() {
  const now = new Date();
  const oneYearAgo = new Date(now.getFullYear() - 1, now.getMonth(), now.getDate());
  const randomTime = oneYearAgo.getTime() + Math.random() * (now.getTime() - oneYearAgo.getTime());
  return new Date(randomTime).toISOString();
}

// 获取评价类型（正面、中性、负面）
function getReviewType() {
  const rand = Math.random();
  if (rand < 0.6) return 'positive'; // 60%正面
  if (rand < 0.85) return 'neutral'; // 25%中性
  return 'negative'; // 15%负面
}

// 生成夜店评价
function generateClubReview(clubId, userId) {
  const reviewType = getReviewType();
  const reviewText = clubReviewTemplates[reviewType][Math.floor(Math.random() * clubReviewTemplates[reviewType].length)];
  
  return {
    club_id: clubId,
    user_id: userId,
    review_text: reviewText,
    music_rating: generateRating(reviewType),
    vibe_rating: generateRating(reviewType),
    crowd_rating: generateRating(reviewType),
    safety_rating: generateRating(reviewType),
    photo_urls: '{}', // 空数组
    created_at: generateRandomDate()
  };
}

// 生成酒吧评价
function generateBarReview(barId, userId) {
  const reviewType = getReviewType();
  const reviewText = barReviewTemplates[reviewType][Math.floor(Math.random() * barReviewTemplates[reviewType].length)];
  
  return {
    bar_id: barId,
    user_id: userId,
    quality_rating: generateRating(reviewType),
    price_rating: generateRating(reviewType),
    vibe_rating: generateRating(reviewType),
    friendliness_rating: generateRating(reviewType),
    review_text: reviewText,
    queue_time: Math.floor(Math.random() * 60), // 0-60分钟
    is_anonymous: Math.random() < 0.3, // 30%匿名
    created_at: generateRandomDate()
  };
}

// 主函数
async function generateReviewData() {
  try {
    console.log('正在获取现有数据...');
    
    // 获取所有用户ID - 使用rpc调用或者直接查询auth.users
    // 由于auth.users不能直接查询，我们先生成一些UUID作为用户ID
    const users = [];
    for (let i = 0; i < 1000; i++) {
      users.push({ id: crypto.randomUUID() });
    }
    const usersError = null;
    
    if (usersError) {
      console.error('获取用户数据失败:', usersError);
      return;
    }
    
    // 获取所有夜店ID
    const { data: clubs, error: clubsError } = await supabase
      .from('clubs')
      .select('id');
    
    if (clubsError) {
      console.error('获取夜店数据失败:', clubsError);
      return;
    }
    
    // 获取所有酒吧ID
    const { data: bars, error: barsError } = await supabase
      .from('bars')
      .select('id');
    
    if (barsError) {
      console.error('获取酒吧数据失败:', barsError);
      return;
    }
    
    console.log(`找到 ${users.length} 个用户, ${clubs.length} 个夜店, ${bars.length} 个酒吧`);
    
    const userIds = users.map(u => u.id);
    const clubIds = clubs.map(c => c.id);
    const barIds = bars.map(b => b.id);
    
    // 生成评价数据
    const clubReviews = [];
    const barReviews = [];
    const totalReviews = 12000; // 生成12000条评价
    const clubReviewRatio = 0.8; // 80%是夜店评价，20%是酒吧评价
    
    console.log('正在生成评价数据...');
    
    for (let i = 0; i < totalReviews; i++) {
      const randomUserId = userIds[Math.floor(Math.random() * userIds.length)];
      
      if (Math.random() < clubReviewRatio && clubIds.length > 0) {
        // 生成夜店评价
        const randomClubId = clubIds[Math.floor(Math.random() * clubIds.length)];
        clubReviews.push(generateClubReview(randomClubId, randomUserId));
      } else if (barIds.length > 0) {
        // 生成酒吧评价
        const randomBarId = barIds[Math.floor(Math.random() * barIds.length)];
        barReviews.push(generateBarReview(randomBarId, randomUserId));
      }
      
      if ((i + 1) % 1000 === 0) {
        console.log(`已生成 ${i + 1} 条评价...`);
      }
    }
    
    console.log(`生成完成: ${clubReviews.length} 条夜店评价, ${barReviews.length} 条酒吧评价`);
    
    // 生成SQL插入语句
    let clubSql = 'INSERT INTO club_reviews (club_id, user_id, review_text, music_rating, vibe_rating, crowd_rating, safety_rating, photo_urls, created_at) VALUES\n';
    const clubValues = clubReviews.map(review => 
      `(${review.club_id}, '${review.user_id}', '${review.review_text.replace(/'/g, "''")}', ${review.music_rating}, ${review.vibe_rating}, ${review.crowd_rating}, ${review.safety_rating}, '${review.photo_urls}', '${review.created_at}')`
    );
    clubSql += clubValues.join(',\n') + ';\n\n';
    
    let barSql = 'INSERT INTO bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at) VALUES\n';
    const barValues = barReviews.map(review => 
      `(${review.bar_id}, '${review.user_id}', ${review.quality_rating}, ${review.price_rating}, ${review.vibe_rating}, ${review.friendliness_rating}, '${review.review_text.replace(/'/g, "''")}', ${review.queue_time}, ${review.is_anonymous}, '${review.created_at}')`
    );
    barSql += barValues.join(',\n') + ';';
    
    // 保存到文件
    const outputPath = path.join(__dirname, '..', 'supabase', 'migrations', 'insert_review_data.sql');
    const fullSql = `-- 生成的评价数据插入脚本\n-- 生成时间: ${new Date().toISOString()}\n-- 夜店评价: ${clubReviews.length} 条\n-- 酒吧评价: ${barReviews.length} 条\n\n${clubSql}${barSql}`;
    
    fs.writeFileSync(outputPath, fullSql, 'utf8');
    console.log(`SQL文件已保存到: ${outputPath}`);
    
  } catch (error) {
    console.error('生成数据时出错:', error);
  }
}

// 运行脚本
if (require.main === module) {
  generateReviewData();
}

module.exports = { generateReviewData };