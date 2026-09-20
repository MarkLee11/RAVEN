const fs = require('fs');
const path = require('path');

// 从review.txt获取的真实数据
const clubs = [
  { id: 41, name: "Berghain" },
  { id: 42, name: "Sisyphos" },
  { id: 44, name: "Tresor" },
  { id: 45, name: "SchwuZ" },
  { id: 46, name: "://about blank" },
  { id: 47, name: "KitKatClub" },
  { id: 48, name: "Kater Blau" },
  { id: 49, name: "Renate" },
  { id: 50, name: "RSO.Berlin" },
  { id: 51, name: "Club der Visionaere" },
  { id: 52, name: "OHM" },
  { id: 53, name: "Golden Gate" },
  { id: 54, name: "Crack Bellmer" },
  { id: 55, name: "Polygon Club" },
  { id: 56, name: "DSTRKT" },
  { id: 57, name: "Else" },
  { id: 58, name: "Lokschuppen Berlin" },
  { id: 59, name: "Paloma Bar" },
  { id: 60, name: "AVA Club" },
  { id: 61, name: "808 Berlin" },
  { id: 62, name: "ÆDEN" },
  { id: 63, name: "Arena Club" },
  { id: 64, name: "b-flat" },
  { id: 65, name: "Badehaus" },
  { id: 66, name: "Ballhaus Spandau" },
  { id: 67, name: "Bi Nuu" },
  { id: 68, name: "Birgit" },
  { id: 69, name: "Bohnengold" },
  { id: 70, name: "Bricks" },
  { id: 71, name: "Bulbul Berlin" },
  { id: 72, name: "Cassiopeia" },
  { id: 73, name: "Der Weiße Hase" },
  { id: 74, name: "Duncker Club" },
  { id: 75, name: "Frannz Club" },
  { id: 76, name: "Gretchen" },
  { id: 77, name: "Hafenbar" },
  { id: 78, name: "Havanna" },
  { id: 79, name: "Hoppetosse" },
  { id: 80, name: "Humboldthain Club" },
  { id: 81, name: "Insomnia" },
  { id: 82, name: "Lido" },
  { id: 83, name: "M01" },
  { id: 84, name: "Matrix" },
  { id: 85, name: "Maxxim Club" },
  { id: 86, name: "Metropol" },
  { id: 87, name: "MUENZE (Alte Münze)" },
  { id: 88, name: "OXI" },
  { id: 89, name: "Prinz Charles" },
  { id: 90, name: "Privatclub" },
  { id: 91, name: "Ritter Butzke" },
  { id: 92, name: "SO36" },
  { id: 93, name: "Teledisko" },
  { id: 94, name: "Trauma Bar und Kino" },
  { id: 95, name: "Void Club" },
  { id: 96, name: "Weekend Club" },
  { id: 97, name: "YAAM" },
  { id: 98, name: "Zita" },
  { id: 99, name: "Zur Klappe" },
  { id: 100, name: "Zig Zag" }
];

// 真实用户UUID样本（从review.txt获取）
const userIds = [
  "4898bf03-f12b-47dd-a123-03564b3ff94b",
  "06955549-c87f-4b74-ba54-fefbb09e22ba",
  "fe851f64-1a2d-4f89-84bf-393f27864c65",
  "38a83d44-13d7-4b47-8828-5d9d9bc5da5a",
  "6df2fa71-1f80-4878-ad65-8a0d6730b8f1",
  "2790f25c-ee7b-4aae-aece-bdf8ab99647d",
  "1d8d109c-9da9-40fc-976e-1913f843d5ce",
  "9f6492e4-daae-446b-9ac7-d724753434f7",
  "e0f1e3e8-be44-42ca-b7b6-f3cea88ea842",
  "717f00e8-ef5e-4d9f-a56a-611c53a2e144",
  "8368c6aa-d61d-42fc-8dcf-7f176456f698",
  "b30a247d-3a7c-490a-899f-cd5e3800dbd0",
  "2797861f-34ef-4c8f-b83d-f2e747a728f6",
  "92115d26-8de6-49f2-aee2-1bc1dfc75eb8",
  "4a1efe94-cf9f-4609-a793-f1479436e576",
  "38c8a0c6-1c8e-4295-bb85-4dacca18ed28",
  "c973c2b4-9016-4953-a488-2b25a4bd6846",
  "ed79cd9e-2edd-4b19-8bf7-36c2be494ac7",
  "a7ed85da-0318-4efc-936d-217f1c6ad9e0",
  "1379bcb5-24a2-4248-b642-cc1361cf0ab3"
];

// English review text templates
const reviewTemplates = {
  positive: [
    "Amazing music and great atmosphere! The DJ's selection is tasteful and the crowd is friendly.",
    "The electronic music here is mesmerizing, lighting effects are awesome, perfect place to unwind.",
    "Great club environment, top-notch sound system, and the staff attitude is excellent.",
    "Strong beats and incredible atmosphere, had an amazing time with friends.",
    "DJ skills are impressive, diverse music styles, overall experience was very satisfying.",
    "Authentic techno music here, high-quality crowd, feels very safe.",
    "Unique interior design, high-quality music, this is the essence of Berlin nightlife.",
    "High energy on the dancefloor, music makes you lose track of time, definitely coming back.",
    "Great music selection, lively but not overwhelming atmosphere, very comfortable.",
    "Authentic underground music scene, this is the real Berlin club experience."
  ],
  neutral: [
    "Music is okay, bit crowded, overall experience is average.",
    "Nice club environment, but the music style doesn't really suit me.",
    "Reasonable prices, decent music quality, good for occasional visits.",
    "Good location, music is alright, crowd is quite mixed.",
    "Decent interior, average sound system, service is ordinary.",
    "Music style is quite limited, but the atmosphere is not bad.",
    "Medium-sized club, music quality is okay, nothing particularly exciting.",
    "Environment is fairly clean, music is a bit loud, overall it's acceptable.",
    "Wide age range in the crowd, music style leans commercial.",
    "Convenient location, music is fine, but lacks character."
  ],
  negative: [
    "Music is too loud, way too crowded and cramped, terrible experience.",
    "DJ skills are mediocre, poor music selection, atmosphere is also lacking.",
    "Overpriced, music quality doesn't match the cost, won't be coming back.",
    "Noisy environment, low-quality crowd, doesn't feel safe.",
    "Poor sound system, music keeps cutting out, really kills the mood.",
    "Chaotic club management, poor sound control, awful experience.",
    "Outdated interior, old-fashioned music style, very disappointing overall.",
    "Too crowded, music is terrible, waiting time is way too long.",
    "Music is too monotonous, dead atmosphere on the dancefloor, very boring.",
    "Poor service attitude, low music quality, wouldn't recommend this place."
  ]
};

// 生成随机评分（根据情感倾向）
function generateRating(sentiment) {
  let rating;
  switch(sentiment) {
    case 'positive':
      rating = 4.0 + Math.random() * 1.0; // 4.0-5.0
      break;
    case 'neutral':
      rating = 2.5 + Math.random() * 1.5; // 2.5-4.0
      break;
    case 'negative':
      rating = 1.0 + Math.random() * 1.5; // 1.0-2.5
      break;
    default:
      rating = 1.0 + Math.random() * 4.0; // 1.0-5.0
  }
  return Math.round(rating * 10) / 10; // 保留一位小数
}

// 生成随机时间戳（过去一年内）
function generateRandomTimestamp() {
  const now = new Date();
  const oneYearAgo = new Date(now.getFullYear() - 1, now.getMonth(), now.getDate());
  const randomTime = oneYearAgo.getTime() + Math.random() * (now.getTime() - oneYearAgo.getTime());
  return new Date(randomTime).toISOString();
}

// 生成评价数据
function generateReviews(count = 1000) {
  const reviews = [];
  const sentiments = ['positive', 'neutral', 'negative'];
  const sentimentWeights = [0.5, 0.3, 0.2]; // 50%正面，30%中性，20%负面
  
  for (let i = 0; i < count; i++) {
    // 随机选择情感倾向
    const rand = Math.random();
    let sentiment;
    if (rand < sentimentWeights[0]) {
      sentiment = 'positive';
    } else if (rand < sentimentWeights[0] + sentimentWeights[1]) {
      sentiment = 'neutral';
    } else {
      sentiment = 'negative';
    }
    
    // 随机选择club和用户
    const club = clubs[Math.floor(Math.random() * clubs.length)];
    const userId = userIds[Math.floor(Math.random() * userIds.length)];
    
    // 随机选择评价文本
    const reviewText = reviewTemplates[sentiment][Math.floor(Math.random() * reviewTemplates[sentiment].length)];
    
    const review = {
      club_id: club.id,
      user_id: userId,
      rating: generateRating(sentiment),
      review_text: reviewText,
      created_at: generateRandomTimestamp()
    };
    
    reviews.push(review);
  }
  
  return reviews;
}

// 将评价数据分割成多个SQL文件
function splitIntoSQLFiles(reviews, filesCount = 10) {
  const reviewsPerFile = Math.ceil(reviews.length / filesCount);
  
  for (let i = 0; i < filesCount; i++) {
    const startIndex = i * reviewsPerFile;
    const endIndex = Math.min(startIndex + reviewsPerFile, reviews.length);
    const fileReviews = reviews.slice(startIndex, endIndex);
    
    if (fileReviews.length === 0) continue;
    
    const fileName = `club_reviews_${String(i + 1).padStart(2, '0')}.sql`;
    const filePath = path.join(__dirname, fileName);
    
    let sqlContent = `-- Club Reviews Data (Part ${i + 1}/${filesCount})\n`;
    sqlContent += `-- Generated on ${new Date().toISOString()}\n`;
    sqlContent += `-- Records: ${fileReviews.length}\n\n`;
    
    sqlContent += `INSERT INTO club_reviews (club_id, user_id, rating, review_text, created_at) VALUES\n`;
    
    const values = fileReviews.map(review => {
      const escapedText = review.review_text.replace(/'/g, "''");
      return `(${review.club_id}, '${review.user_id}', ${review.rating}, '${escapedText}', '${review.created_at}')`;
    });
    
    sqlContent += values.join(',\n');
    sqlContent += ';\n';
    
    fs.writeFileSync(filePath, sqlContent, 'utf8');
    console.log(`Generated ${fileName} with ${fileReviews.length} records`);
  }
}

// 主函数
function main() {
  try {
    console.log('Generating club reviews data...');
    console.log(`Clubs: ${clubs.length}`);
    console.log(`User IDs: ${userIds.length}`);
    
    const reviews = generateReviews(1000);
    console.log(`Generated ${reviews.length} reviews`);
    
    splitIntoSQLFiles(reviews, 10);
    console.log('All SQL files generated successfully!');
    
    // 统计信息
    const stats = {
      positive: reviews.filter(r => r.rating >= 4.0).length,
      neutral: reviews.filter(r => r.rating >= 2.5 && r.rating < 4.0).length,
      negative: reviews.filter(r => r.rating < 2.5).length
    };
    
    console.log('\nStatistics:');
    console.log(`Positive reviews (4.0-5.0): ${stats.positive}`);
    console.log(`Neutral reviews (2.5-4.0): ${stats.neutral}`);
    console.log(`Negative reviews (1.0-2.5): ${stats.negative}`);
    
  } catch (error) {
    console.error('Error generating reviews:', error);
    process.exit(1);
  }
}

// 运行脚本
if (require.main === module) {
  main();
}