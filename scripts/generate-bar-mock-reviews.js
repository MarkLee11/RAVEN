/**
 * RAVEN项目 - 生成1000条酒吧评论和评分模拟数据
 * 分为10个批次，每批次100条记录
 * 基于已有的districts和themes数据
 */

const fs = require('fs');
const path = require('path');

// 地区数据
const districts = [
  { id: 60, name: "Mitte" },
  { id: 61, name: "Friedrichshain" },
  { id: 62, name: "Kreuzberg" },
  { id: 63, name: "Prenzlauer Berg" },
  { id: 64, name: "Pankow" },
  { id: 65, name: "Schöneberg" },
  { id: 66, name: "Neukölln" },
  { id: 67, name: "Treptow" },
  { id: 68, name: "Charlottenburg-Wilmersdorf" },
  { id: 69, name: "Spandau" },
  { id: 70, name: "Steglitz-Zehlendorf" },
  { id: 71, name: "Marzahn-Hellersdorf" },
  { id: 72, name: "Lichtenberg" },
  { id: 73, name: "Reinickendorf" },
  { id: 74, name: "Köpenick" }
];

// 主题数据（仅包含有category的）
const themes = [
  // drinks category
  { id: 67, name: "cocktails", category: "drinks" },
  { id: 68, name: "beer", category: "drinks" },
  { id: 69, name: "wine", category: "drinks" },
  { id: 70, name: "shots", category: "drinks" },
  { id: 71, name: "whisky", category: "drinks" },
  { id: 72, name: "rum", category: "drinks" },
  { id: 73, name: "gin", category: "drinks" },
  { id: 74, name: "vodka", category: "drinks" },
  { id: 75, name: "tequila", category: "drinks" },
  { id: 76, name: "mocktails", category: "drinks" },
  
  // style category
  { id: 77, name: "upscale", category: "style" },
  { id: 78, name: "classic", category: "style" },
  { id: 79, name: "historic", category: "style" },
  { id: 80, name: "industrial", category: "style" },
  { id: 81, name: "minimalist", category: "style" },
  { id: 82, name: "alternative", category: "style" },
  { id: 83, name: "speakeasy", category: "style" },
  { id: 84, name: "art-bar", category: "style" },
  { id: 125, name: "traditional", category: "style" },
  
  // architecture category
  { id: 85, name: "outdoor", category: "architecture" },
  { id: 86, name: "rooftop", category: "architecture" },
  { id: 87, name: "stage", category: "architecture" },
  { id: 88, name: "smoking-area", category: "architecture" },
  { id: 89, name: "private-rooms", category: "architecture" },
  { id: 124, name: "beer-garden", category: "architecture" },
  
  // vibe category
  { id: 90, name: "straight-bar", category: "vibe" },
  { id: 91, name: "gay-bar", category: "vibe" },
  { id: 92, name: "lesbian-bar", category: "vibe" },
  { id: 93, name: "queer-bar", category: "vibe" },
  { id: 94, name: "lgbtq-friendly", category: "vibe" },
  { id: 95, name: "chill", category: "vibe" },
  { id: 96, name: "classy", category: "vibe" },
  { id: 97, name: "lively", category: "vibe" },
  { id: 98, name: "crowded", category: "vibe" },
  { id: 99, name: "cozy", category: "vibe" },
  { id: 100, name: "romantic", category: "vibe" },
  { id: 101, name: "wild", category: "vibe" },
  { id: 102, name: "underground", category: "vibe" },
  { id: 103, name: "artsy", category: "vibe" },
  { id: 104, name: "intimate", category: "vibe" },
  { id: 105, name: "touristy", category: "vibe" },
  { id: 106, name: "local", category: "vibe" },
  { id: 123, name: "late-night", category: "vibe" },
  
  // music category
  { id: 107, name: "jazz", category: "music" },
  { id: 108, name: "blues", category: "music" },
  { id: 109, name: "funk", category: "music" },
  { id: 110, name: "soul", category: "music" },
  { id: 111, name: "disco", category: "music" },
  { id: 112, name: "pop", category: "music" },
  { id: 113, name: "indie", category: "music" },
  { id: 114, name: "rock", category: "music" },
  { id: 115, name: "electronic", category: "music" },
  { id: 116, name: "latin", category: "music" },
  { id: 117, name: "live-music", category: "music" },
  { id: 121, name: "house", category: "music" }
];

// 酒吧名称生成器（Berlin风格）
const barNames = [
  "The Black Rose", "Zur Goldenen Krone", "Berlin Underground", "Cocktail Lounge 47", 
  "Das Blaue Wunder", "The Gin Palace", "Friedrichshain Social", "Kreuzberg Corner",
  "Mitte Midnight", "Prenzlauer Pint", "Neukölln Nights", "Charlottenburg Chic",
  "The Berlin Beat", "Rooftop Revolution", "Underground Union", "The Smoking Gun",
  "Whisky Wonderland", "Cocktail Cathedral", "The Jazz Joint", "Electronic Eden",
  "Vintage Vibes", "Modern Mixology", "The Art Bar", "Industrial Intrigue",
  "Classic Corner", "Historic Hideaway", "Minimalist Marvel", "Alternative Avenue",
  "The Speakeasy", "Traditional Tavern", "Outdoor Oasis", "Private Paradise",
  "Stage & Stories", "Garden Glory", "Intimate Indulgence", "Wild & Wonderful",
  "Romantic Rendezvous", "Crowded & Cool", "Lively & Local", "Classy & Chic",
  "Chill Chamber", "Underground Utopia", "Artsy Atmosphere", "Tourist Trap",
  "Local Legend", "Late Night Lounge", "LGBTQ+ Lounge", "Queer Quarter",
  "Gay Gathering", "Lesbian Lounge", "Straight & Simple", "Friendly Folk"
];

// 评论模板（中英混合）
const reviewTemplates = [
  // 正面评论 (80% 概率)
  "Amazing cocktails and great atmosphere! Definitely coming back.",
  "Perfect place for a night out with friends. Love the music!",
  "Excellent service and beautiful interior design. Highly recommended!",
  "Great drinks, friendly staff, and cool vibes. What more do you need?",
  "这里的鸡尾酒太棒了！氛围也很好，很适合约会。",
  "服务员很友好，音乐也很棒。会再来的！",
  "装修很有特色，饮品质量也很高。推荐给朋友们！",
  "Perfect for date night. Romantic atmosphere and excellent cocktails.",
  "Great music selection and the bartenders know their craft!",
  "Love the outdoor seating area. Perfect for summer evenings.",
  "Unique concept and fantastic drinks. A hidden gem in Berlin!",
  "The jazz music here is incredible. Great place to unwind.",
  "Fantastic beer selection and authentic German atmosphere.",
  "Modern and stylish bar with creative cocktails. Love it!",
  "Great place for after-work drinks. Professional crowd and good music.",
  
  // 中性评论 (15% 概率)
  "Decent bar, nothing special but okay for a quick drink.",
  "Average place, drinks are fine but atmosphere could be better.",
  "It's alright, might come back if in the area.",
  "还可以，但是没什么特别的。饮品一般般。",
  "地理位置不错，但是价格有点贵。",
  "Ok for a casual drink, but wouldn't go out of my way for it.",
  "Standard bar experience. Nothing to complain about but nothing exciting.",
  
  // 负面评论 (5% 概率)  
  "Too crowded and expensive for what you get.",
  "Service was slow and drinks were overpriced.",
  "Not impressed. Better options available nearby.",
  "太吵了，根本听不见朋友说话。不推荐。",
  "价格太贵了，而且服务态度不好。"
];

// 工具函数
function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomChoice(array) {
  return array[Math.floor(Math.random() * array.length)];
}

function randomChoices(array, count) {
  const shuffled = [...array].sort(() => 0.5 - Math.random());
  return shuffled.slice(0, count);
}

// 生成乐观的评分（偏向高分）
function generateOptimisticRating() {
  // 使用beta分布模拟，偏向高分
  const random = Math.random();
  if (random < 0.4) return randomInt(80, 100); // 40% 概率高分
  if (random < 0.7) return randomInt(65, 85);  // 30% 概率中上分
  if (random < 0.9) return randomInt(50, 75);  // 20% 概率中等分
  return randomInt(30, 60);                    // 10% 概率较低分
}

// 生成用户ID（模拟UUID格式）
function generateUserId() {
  // 生成类似UUID的字符串（简化版）
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  const segments = [8, 4, 4, 4, 12];
  return segments.map(len => 
    Array.from({length: len}, () => chars[Math.floor(Math.random() * chars.length)]).join('')
  ).join('-');
}

// 生成日期（最近6个月内）
function generateRecentDate() {
  const now = new Date();
  const sixMonthsAgo = new Date(now.getTime() - (6 * 30 * 24 * 60 * 60 * 1000));
  const randomTime = sixMonthsAgo.getTime() + Math.random() * (now.getTime() - sixMonthsAgo.getTime());
  return new Date(randomTime).toISOString();
}

// 生成单个酒吧数据
function generateBar(id) {
  const district = randomChoice(districts);
  const name = randomChoice(barNames);
  const description = `A ${randomChoice(['cozy', 'modern', 'traditional', 'stylish', 'unique'])} bar in ${district.name} with ${randomChoice(['great', 'excellent', 'amazing', 'fantastic'])} ${randomChoice(['cocktails', 'beer selection', 'atmosphere', 'music'])}.`;
  
  // 随机选择2-5个主题
  const selectedThemes = randomChoices(themes, randomInt(2, 5));
  
  return {
    id,
    name: `${name} ${id}`, // 加上ID确保唯一性
    district_id: district.id,
    description,
    cash_only: Math.random() < 0.3, // 30% 概率只收现金
    card_accepted: Math.random() < 0.8, // 80% 概率收卡
    themes: selectedThemes
  };
}

// 生成bar_ratings数据
function generateBarRating(barId) {
  return {
    bar_id: barId,
    quality_rating: generateOptimisticRating(),
    price_rating: generateOptimisticRating(),
    vibe_rating: generateOptimisticRating(),
    friendliness_rating: generateOptimisticRating()
  };
}

// 生成bar_reviews数据
function generateBarReview(barId) {
  const ratings = {
    quality_rating: generateOptimisticRating(),
    price_rating: generateOptimisticRating(), 
    vibe_rating: generateOptimisticRating(),
    friendliness_rating: generateOptimisticRating()
  };
  
  // 根据评分选择合适的评论
  const avgRating = (ratings.quality_rating + ratings.price_rating + ratings.vibe_rating + ratings.friendliness_rating) / 4;
  let reviewText;
  
  if (avgRating >= 75) {
    // 高分选择正面评论
    reviewText = randomChoice(reviewTemplates.slice(0, 15));
  } else if (avgRating >= 60) {
    // 中等分选择中性评论
    reviewText = randomChoice(reviewTemplates.slice(15, 22));
  } else {
    // 低分选择负面评论
    reviewText = randomChoice(reviewTemplates.slice(22));
  }
  
  return {
    bar_id: barId,
    user_id: generateUserId(),
    ...ratings,
    review_text: reviewText,
    queue_time: Math.random() < 0.7 ? randomInt(0, 45) : null, // 70% 概率有排队时间
    is_anonymous: Math.random() < 0.6, // 60% 概率匿名
    created_at: generateRecentDate()
  };
}

// 生成SQL插入语句
function generateBarsSQL(bars) {
  let sql = `-- RAVEN项目 - 酒吧数据插入脚本\n`;
  sql += `-- 生成时间: ${new Date().toISOString()}\n\n`;
  
  // 插入bars数据
  sql += `-- 插入bars数据\n`;
  bars.forEach(bar => {
    sql += `INSERT INTO public.bars (id, name, district_id, description, cash_only, card_accepted) VALUES\n`;
    sql += `(${bar.id}, '${bar.name.replace(/'/g, "''")}', ${bar.district_id}, '${bar.description.replace(/'/g, "''")}', ${bar.cash_only}, ${bar.card_accepted});\n\n`;
  });
  
  // 插入bar_themes关联
  sql += `-- 插入bar_themes关联数据\n`;
  bars.forEach(bar => {
    bar.themes.forEach(theme => {
      sql += `INSERT INTO public.bar_themes (bar_id, theme_id) VALUES (${bar.id}, ${theme.id}) ON CONFLICT (bar_id, theme_id) DO NOTHING;\n`;
    });
  });
  
  return sql;
}

function generateRatingsSQL(ratings, batchNum) {
  let sql = `-- RAVEN项目 - 酒吧评分数据插入脚本 (批次 ${batchNum})\n`;
  sql += `-- 生成时间: ${new Date().toISOString()}\n`;
  sql += `-- 记录数: ${ratings.length}\n\n`;
  
  sql += `INSERT INTO public.bar_ratings (bar_id, quality_rating, price_rating, vibe_rating, friendliness_rating) VALUES\n`;
  
  const values = ratings.map(rating => 
    `(${rating.bar_id}, ${rating.quality_rating}, ${rating.price_rating}, ${rating.vibe_rating}, ${rating.friendliness_rating})`
  );
  
  sql += values.join(',\n');
  sql += `\nON CONFLICT (bar_id) DO UPDATE SET\n`;
  sql += `  quality_rating = EXCLUDED.quality_rating,\n`;
  sql += `  price_rating = EXCLUDED.price_rating,\n`;
  sql += `  vibe_rating = EXCLUDED.vibe_rating,\n`;
  sql += `  friendliness_rating = EXCLUDED.friendliness_rating,\n`;
  sql += `  updated_at = NOW();\n`;
  
  return sql;
}

function generateReviewsSQL(reviews, batchNum) {
  let sql = `-- RAVEN项目 - 酒吧评论数据插入脚本 (批次 ${batchNum})\n`;
  sql += `-- 生成时间: ${new Date().toISOString()}\n`;
  sql += `-- 记录数: ${reviews.length}\n\n`;
  
  sql += `INSERT INTO public.bar_reviews (bar_id, user_id, quality_rating, price_rating, vibe_rating, friendliness_rating, review_text, queue_time, is_anonymous, created_at) VALUES\n`;
  
  const values = reviews.map(review => {
    const queueTime = review.queue_time !== null ? review.queue_time : 'NULL';
    return `(${review.bar_id}, '${review.user_id}', ${review.quality_rating}, ${review.price_rating}, ${review.vibe_rating}, ${review.friendliness_rating}, '${review.review_text.replace(/'/g, "''")}', ${queueTime}, ${review.is_anonymous}, '${review.created_at}')`;
  });
  
  sql += values.join(',\n');
  sql += ';\n';
  
  return sql;
}

// 主函数
function generateMockData() {
  console.log('开始生成1000条酒吧评论和评分模拟数据...');
  
  // 确保输出目录存在
  const outputDir = path.join(__dirname, '..', 'sql', 'mock-data');
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  // 生成1000个酒吧（如果需要的话）
  const bars = [];
  for (let i = 1; i <= 1000; i++) {
    bars.push(generateBar(i));
  }
  
  // 生成酒吧数据SQL
  const barsSQL = generateBarsSQL(bars);
  fs.writeFileSync(path.join(outputDir, 'bars-mock-data.sql'), barsSQL);
  console.log('生成酒吧数据完成: bars-mock-data.sql');
  
  // 生成1000条评分和评论数据，分为10个批次
  const batchSize = 100;
  
  for (let batch = 1; batch <= 10; batch++) {
    const ratings = [];
    const reviews = [];
    
    for (let i = 0; i < batchSize; i++) {
      const barId = randomInt(1, 1000); // 随机选择酒吧ID
      
      // 生成评分数据
      ratings.push(generateBarRating(barId));
      
      // 生成评论数据  
      reviews.push(generateBarReview(barId));
    }
    
    // 生成SQL文件
    const ratingsSQL = generateRatingsSQL(ratings, batch);
    const reviewsSQL = generateReviewsSQL(reviews, batch);
    
    const ratingFileName = `bar-ratings-batch-${batch.toString().padStart(2, '0')}.sql`;
    const reviewFileName = `bar-reviews-batch-${batch.toString().padStart(2, '0')}.sql`;
    
    fs.writeFileSync(path.join(outputDir, ratingFileName), ratingsSQL);
    fs.writeFileSync(path.join(outputDir, reviewFileName), reviewsSQL);
    
    console.log(`生成批次 ${batch} 完成: ${ratingFileName}, ${reviewFileName}`);
  }
  
  console.log('所有模拟数据生成完成！');
  console.log(`输出目录: ${outputDir}`);
  console.log('文件清单:');
  console.log('- bars-mock-data.sql (1000个酒吧数据)');
  console.log('- bar-ratings-batch-01.sql 到 bar-ratings-batch-10.sql (1000条评分数据)');
  console.log('- bar-reviews-batch-01.sql 到 bar-reviews-batch-10.sql (1000条评论数据)');
}

// 执行生成
if (require.main === module) {
  generateMockData();
}

module.exports = { generateMockData };
