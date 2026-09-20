/**
 * RAVEN项目 - 通过Supabase客户端导入模拟数据
 * 使用@supabase/supabase-js进行数据导入
 */

import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 请在运行前设置你的Supabase项目信息
const SUPABASE_URL = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY || process.env.VITE_SUPABASE_ANON_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('❌ 错误: 缺少Supabase环境变量');
  console.log('请设置以下环境变量:');
  console.log('- SUPABASE_URL: 你的Supabase项目URL');
  console.log('- SUPABASE_SERVICE_KEY: 你的Supabase Service Key（用于管理操作）');
  console.log('');
  console.log('或者在命令行中设置:');
  console.log('$env:SUPABASE_URL="https://your-project.supabase.co"');
  console.log('$env:SUPABASE_SERVICE_KEY="your-service-key"');
  console.log('node import-mock-data-supabase.js');
  process.exit(1);
}

// 创建Supabase客户端（使用service key进行管理操作）
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

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

// 睡眠函数（避免API限制）
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// 批量插入数据的函数
async function insertBatch(table, data, batchSize = 100) {
  const results = [];
  
  for (let i = 0; i < data.length; i += batchSize) {
    const batch = data.slice(i, i + batchSize);
    
    try {
      const { data: result, error } = await supabase
        .from(table)
        .insert(batch);
      
      if (error) {
        console.error(`❌ 批次 ${Math.floor(i/batchSize) + 1} 插入失败:`, error);
        throw error;
      }
      
      results.push(...(result || []));
      console.log(`✅ ${table} 批次 ${Math.floor(i/batchSize) + 1} 插入成功 (${batch.length} 条记录)`);
      
      // 防止API限制，稍微延迟
      await sleep(500);
      
    } catch (error) {
      console.error(`❌ ${table} 批次插入失败:`, error);
      throw error;
    }
  }
  
  return results;
}

// 主导入函数
async function importMockData() {
  console.log('🚀 开始导入RAVEN项目模拟数据...');
  console.log(`📡 Supabase URL: ${SUPABASE_URL}`);
  
  try {
    // 1. 测试连接
    console.log('\n🔍 测试数据库连接...');
    const { data: testData, error: testError } = await supabase
      .from('districts')
      .select('count')
      .limit(1);
    
    if (testError) {
      console.error('❌ 数据库连接失败:', testError);
      return;
    }
    
    console.log('✅ 数据库连接成功');
    
    // 2. 生成酒吧数据
    console.log('\n📊 生成1000个酒吧数据...');
    const bars = [];
    const allBarThemes = [];
    
    for (let i = 1; i <= 1000; i++) {
      const bar = generateBar(i);
      const { themes, ...barData } = bar;
      
      bars.push(barData);
      
      // 准备主题关联数据
      themes.forEach(theme => {
        allBarThemes.push({
          bar_id: i,
          theme_id: theme.id
        });
      });
      
      if (i % 100 === 0) {
        console.log(`生成进度: ${i}/1000`);
      }
    }
    
    // 3. 插入酒吧数据
    console.log('\n🏢 插入酒吧数据...');
    await insertBatch('bars', bars, 50);
    console.log(`✅ 成功插入 ${bars.length} 个酒吧`);
    
    // 4. 插入主题关联数据
    console.log('\n🏷️ 插入主题关联数据...');
    await insertBatch('bar_themes', allBarThemes, 100);
    console.log(`✅ 成功插入 ${allBarThemes.length} 条主题关联`);
    
    // 5. 生成并插入评分数据
    console.log('\n⭐ 生成并插入评分数据...');
    const ratings = [];
    for (let i = 1; i <= 1000; i++) {
      ratings.push(generateBarRating(i));
    }
    
    await insertBatch('bar_ratings', ratings, 50);
    console.log(`✅ 成功插入 ${ratings.length} 条评分记录`);
    
    // 6. 生成并插入评论数据
    console.log('\n💬 生成并插入评论数据...');
    const reviews = [];
    for (let i = 0; i < 1000; i++) {
      const barId = randomInt(1, 1000); // 随机选择酒吧ID
      reviews.push(generateBarReview(barId));
    }
    
    await insertBatch('bar_reviews', reviews, 50);
    console.log(`✅ 成功插入 ${reviews.length} 条评论记录`);
    
    // 7. 数据完整性检查
    console.log('\n🔍 进行数据完整性检查...');
    
    const { data: barsCount } = await supabase
      .from('bars')
      .select('id', { count: 'exact' })
      .gte('id', 1)
      .lte('id', 1000);
    
    const { data: ratingsCount } = await supabase
      .from('bar_ratings')
      .select('bar_id', { count: 'exact' })
      .gte('bar_id', 1)
      .lte('bar_id', 1000);
    
    const { data: reviewsCount } = await supabase
      .from('bar_reviews')
      .select('bar_id', { count: 'exact' })
      .gte('bar_id', 1)
      .lte('bar_id', 1000);
    
    const { data: themesCount } = await supabase
      .from('bar_themes')
      .select('bar_id', { count: 'exact' })
      .gte('bar_id', 1)
      .lte('bar_id', 1000);
    
    console.log('\n📈 数据统计:');
    console.log(`  酒吧数量: ${barsCount?.length || 0}`);
    console.log(`  评分记录: ${ratingsCount?.length || 0}`);
    console.log(`  评论记录: ${reviewsCount?.length || 0}`);
    console.log(`  主题关联: ${themesCount?.length || 0}`);
    
    if (barsCount?.length === 1000 && ratingsCount?.length === 1000 && reviewsCount?.length === 1000) {
      console.log('\n🎉 所有数据导入成功！');
    } else {
      console.log('\n⚠️  数据导入可能不完整，请检查！');
    }
    
  } catch (error) {
    console.error('\n❌ 导入过程中发生错误:', error);
    process.exit(1);
  }
}

// 执行导入
if (import.meta.url === `file://${process.argv[1]}`) {
  importMockData();
}

export { importMockData };
