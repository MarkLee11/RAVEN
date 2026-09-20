const fs = require('fs');
const path = require('path');

// 配置
const CONFIG = {
  INPUT_FILE: path.join(__dirname, 'berlin-bars-data.json'),
  OUTPUT_FILE: path.join(__dirname, 'bars-import.sql'),
  BATCH_SIZE: 50, // 每批处理50条记录
  DEFAULT_DISTRICT_ID: 1 // 默认区域ID，可以根据实际情况调整
};

// 工具函数：转义SQL字符串
function escapeSqlString(str) {
  if (!str) return 'NULL';
  return "'" + str.replace(/'/g, "''").replace(/\\/g, '\\\\') + "'";
}

// 工具函数：生成简单描述
function generateDescription(bar) {
  const parts = [];
  
  if (bar.rating && bar.total_ratings) {
    parts.push(`评分 ${bar.rating}/5 (${bar.total_ratings} 条评价)`);
  }
  
  if (bar.price_level) {
    const priceText = ['经济实惠', '中等价位', '较高价位', '高端消费'][bar.price_level - 1] || '价位未知';
    parts.push(priceText);
  }
  
  if (bar.types && bar.types.length > 0) {
    const typeText = bar.types.filter(t => !['establishment', 'point_of_interest'].includes(t)).join(', ');
    if (typeText) parts.push(`类型: ${typeText}`);
  }
  
  return parts.join(' | ') || '柏林特色酒吧';
}

// 工具函数：映射类型到主题
function mapTypesToThemes(types) {
  const typeMapping = {
    'bar': 'cocktails',
    'night_club': 'electronic',
    'restaurant': 'food',
    'establishment': null,
    'point_of_interest': null,
    'food': 'food',
    'liquor_store': 'spirits'
  };
  
  const themes = [];
  if (types && Array.isArray(types)) {
    types.forEach(type => {
      const theme = typeMapping[type];
      if (theme && !themes.includes(theme)) {
        themes.push(theme);
      }
    });
  }
  
  // 如果没有映射到任何主题，默认添加cocktails
  if (themes.length === 0) {
    themes.push('cocktails');
  }
  
  return themes;
}

// 生成bars表插入语句
function generateBarsInsert(bars, startIndex = 0) {
  const values = bars.map((bar, index) => {
    const barId = startIndex + index + 1;
    const name = escapeSqlString(bar.name);
    const districtId = CONFIG.DEFAULT_DISTRICT_ID;
    const description = escapeSqlString(generateDescription(bar));
    
    return `(${barId}, ${name}, ${districtId}, ${description}, false, false)`;
  }).join(',\n    ');
  
  return `-- 插入bars表数据\nINSERT INTO public.bars (id, name, district_id, description, cash_only, card_accepted) VALUES\n    ${values};\n\n`;
}

// 生成bar_locations表插入语句
function generateBarLocationsInsert(bars, startIndex = 0) {
  const values = bars.map((bar, index) => {
    const barId = startIndex + index + 1;
    const addressLine = escapeSqlString(bar.address);
    const latitude = bar.latitude || 'NULL';
    const longitude = bar.longitude || 'NULL';
    
    // 从地址中提取邮政编码
    let postalCode = 'NULL';
    if (bar.address) {
      const postalMatch = bar.address.match(/\b(\d{5})\b/);
      if (postalMatch) {
        postalCode = escapeSqlString(postalMatch[1]);
      }
    }
    
    return `(${barId}, ${addressLine}, ${postalCode}, ${latitude}, ${longitude})`;
  }).join(',\n    ');
  
  return `-- 插入bar_locations表数据\nINSERT INTO public.bar_locations (bar_id, address_line, postal_code, latitude, longitude) VALUES\n    ${values};\n\n`;
}

// 生成bar_themes表插入语句
function generateBarThemesInsert(bars, startIndex = 0) {
  const values = [];
  
  bars.forEach((bar, index) => {
    const barId = startIndex + index + 1;
    const themes = mapTypesToThemes(bar.types);
    
    themes.forEach(theme => {
      values.push(`(${barId}, (SELECT id FROM public.themes WHERE name = '${theme}' LIMIT 1))`);
    });
  });
  
  if (values.length === 0) return '';
  
  return `-- 插入bar_themes表数据\nINSERT INTO public.bar_themes (bar_id, theme_id) VALUES\n    ${values.join(',\n    ')};\n\n`;
}

// 主函数
async function importBarsData() {
  try {
    console.log('开始读取JSON数据...');
    
    // 读取JSON文件
    const jsonData = fs.readFileSync(CONFIG.INPUT_FILE, 'utf8');
    const bars = JSON.parse(jsonData);
    
    console.log(`共找到 ${bars.length} 条酒吧记录`);
    
    // 创建输出SQL文件
    let sqlContent = `-- RAVEN项目 - 柏林酒吧数据导入脚本\n-- 生成时间: ${new Date().toISOString()}\n-- 数据来源: ${CONFIG.INPUT_FILE}\n-- 总记录数: ${bars.length}\n\n`;
    
    // 添加序列重置语句
    sqlContent += `-- 重置序列以避免ID冲突\nSELECT setval('public.bars_id_seq', (SELECT COALESCE(MAX(id), 0) FROM public.bars));\nSELECT setval('public.bar_locations_id_seq', (SELECT COALESCE(MAX(id), 0) FROM public.bar_locations));\nSELECT setval('public.bar_themes_id_seq', (SELECT COALESCE(MAX(id), 0) FROM public.bar_themes));\n\n`;
    
    // 分批处理数据
    const totalBatches = Math.ceil(bars.length / CONFIG.BATCH_SIZE);
    
    for (let batchIndex = 0; batchIndex < totalBatches; batchIndex++) {
      const startIndex = batchIndex * CONFIG.BATCH_SIZE;
      const endIndex = Math.min(startIndex + CONFIG.BATCH_SIZE, bars.length);
      const batchBars = bars.slice(startIndex, endIndex);
      
      console.log(`处理批次 ${batchIndex + 1}/${totalBatches} (记录 ${startIndex + 1}-${endIndex})`);
      
      sqlContent += `-- 批次 ${batchIndex + 1}: 记录 ${startIndex + 1}-${endIndex}\n`;
      sqlContent += `BEGIN;\n\n`;
      
      // 生成各表的插入语句
      sqlContent += generateBarsInsert(batchBars, startIndex);
      sqlContent += generateBarLocationsInsert(batchBars, startIndex);
      sqlContent += generateBarThemesInsert(batchBars, startIndex);
      
      sqlContent += `COMMIT;\n\n`;
    }
    
    // 添加数据验证查询
    sqlContent += `-- 数据验证查询\nSELECT 'bars' as table_name, COUNT(*) as record_count FROM public.bars\nUNION ALL\nSELECT 'bar_locations' as table_name, COUNT(*) as record_count FROM public.bar_locations\nUNION ALL\nSELECT 'bar_themes' as table_name, COUNT(*) as record_count FROM public.bar_themes;\n\n`;
    
    sqlContent += `-- 查看导入的酒吧数据示例\nSELECT \n    b.id,\n    b.name,\n    b.description,\n    bl.address_line,\n    bl.latitude,\n    bl.longitude,\n    array_agg(t.name) as themes\nFROM public.bars b\nLEFT JOIN public.bar_locations bl ON b.id = bl.bar_id\nLEFT JOIN public.bar_themes bt ON b.id = bt.bar_id\nLEFT JOIN public.themes t ON bt.theme_id = t.id\nWHERE b.id > (SELECT COALESCE(MAX(id), 0) FROM public.bars WHERE id < ${bars.length + 1})\nGROUP BY b.id, b.name, b.description, bl.address_line, bl.latitude, bl.longitude\nORDER BY b.id\nLIMIT 10;`;
    
    // 写入SQL文件
    fs.writeFileSync(CONFIG.OUTPUT_FILE, sqlContent, 'utf8');
    
    console.log(`\n✅ 数据导入脚本生成完成!`);
    console.log(`📁 输出文件: ${CONFIG.OUTPUT_FILE}`);
    console.log(`📊 统计信息:`);
    console.log(`   - 总记录数: ${bars.length}`);
    console.log(`   - 批次数量: ${totalBatches}`);
    console.log(`   - 每批大小: ${CONFIG.BATCH_SIZE}`);
    console.log(`\n🚀 请在Supabase中执行生成的SQL文件来导入数据`);
    
  } catch (error) {
    console.error('❌ 数据导入脚本生成失败:', error.message);
    process.exit(1);
  }
}

// 执行脚本
if (require.main === module) {
  importBarsData();
}

module.exports = { importBarsData };