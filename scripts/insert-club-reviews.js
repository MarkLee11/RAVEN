const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Supabase配置
const supabaseUrl = 'https://gwwahjmagznitbsgtlid.supabase.co';
const supabaseServiceKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3d2Foam1hZ3puaXRic2d0bGlkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTEzMjEzMCwiZXhwIjoyMDcwNzA4MTMwfQ.jPzUuedhAfa0_1BCEbJxjmrOzPJ3YpkcCOZBrQ4fL-A';

// 创建Supabase客户端（使用service_role_key进行数据库操作）
const supabase = createClient(supabaseUrl, supabaseServiceKey);

// SQL文件列表
const sqlFiles = [
  'club_reviews_01.sql',
  'club_reviews_02.sql',
  'club_reviews_03.sql',
  'club_reviews_04.sql',
  'club_reviews_05.sql',
  'club_reviews_06.sql',
  'club_reviews_07.sql',
  'club_reviews_08.sql',
  'club_reviews_09.sql',
  'club_reviews_10.sql'
];

// 解析SQL文件中的INSERT语句并提取数据
function parseInsertData(sqlContent) {
  // 移除注释和空行
  const cleanSql = sqlContent
    .split('\n')
    .filter(line => !line.trim().startsWith('--') && line.trim() !== '')
    .join('\n');
  
  // 提取INSERT语句中的VALUES部分
  const insertMatch = cleanSql.match(/INSERT INTO club_reviews \(([^)]+)\) VALUES\s*([\s\S]+);?$/i);
  
  if (!insertMatch) {
    return { columns: [], rows: [] };
  }
  
  const columns = insertMatch[1].split(',').map(col => col.trim());
  const valuesSection = insertMatch[2].trim();
  
  // 解析每一行数据
  const rows = [];
  const valueMatches = valuesSection.match(/\([^)]+\)/g);
  
  if (valueMatches) {
    valueMatches.forEach(match => {
      // 移除括号
      const valueString = match.slice(1, -1);
      
      // 更智能的分割，处理引号内的逗号
      const values = [];
      let current = '';
      let inQuotes = false;
      let quoteChar = null;
      
      for (let i = 0; i < valueString.length; i++) {
        const char = valueString[i];
        
        if (!inQuotes && (char === "'" || char === '"')) {
          inQuotes = true;
          quoteChar = char;
          current += char;
        } else if (inQuotes && char === quoteChar) {
          // 检查是否是转义的引号
          if (i + 1 < valueString.length && valueString[i + 1] === quoteChar) {
            current += char + char;
            i++; // 跳过下一个引号
          } else {
            inQuotes = false;
            quoteChar = null;
            current += char;
          }
        } else if (!inQuotes && char === ',') {
          values.push(current.trim());
          current = '';
        } else {
          current += char;
        }
      }
      
      if (current.trim()) {
        values.push(current.trim());
      }
      
      // 清理值并移除引号
      const cleanValues = values.map(val => {
        val = val.trim();
        if ((val.startsWith("'") && val.endsWith("'")) || (val.startsWith('"') && val.endsWith('"'))) {
          val = val.slice(1, -1);
          // 处理转义的单引号
          val = val.replace(/''/g, "'");
        }
        return val;
      });
      
      // 创建数据对象，将单一rating转换为多个rating字段
      const rowData = {};
      
      // 手动映射字段，因为SQL文件的字段顺序是固定的
       // SQL格式: (club_id, user_id, rating, review_text, created_at)
       if (cleanValues.length >= 5) {
         const baseRating = parseFloat(cleanValues[2]); // rating字段
         
         rowData['club_id'] = parseInt(cleanValues[0]);
         rowData['user_id'] = cleanValues[1];
         rowData['review_text'] = cleanValues[3];
         rowData['created_at'] = cleanValues[4];
        
        // 将单一rating分解为多个rating字段（1-5范围）
        rowData['music_rating'] = Math.max(1, Math.min(5, baseRating + (Math.random() - 0.5) * 0.5));
        rowData['vibe_rating'] = Math.max(1, Math.min(5, baseRating + (Math.random() - 0.5) * 0.5));
        rowData['crowd_rating'] = Math.max(1, Math.min(5, baseRating + (Math.random() - 0.5) * 0.5));
        rowData['safety_rating'] = Math.max(1, Math.min(5, baseRating + (Math.random() - 0.5) * 0.5));
        
        // 添加photo_urls字段（空数组）
        rowData['photo_urls'] = [];
      }
      
      rows.push(rowData);
    });
  }
  
  return { columns, rows };
}

// 批量插入数据到Supabase
async function insertBatchData(rows) {
  try {
    const { data, error } = await supabase
      .from('club_reviews')
      .insert(rows);
    
    if (error) {
      throw error;
    }
    
    return { success: true, insertedCount: rows.length };
  } catch (error) {
    return { success: false, error: error.message, insertedCount: 0 };
  }
}

// 执行单个SQL文件
async function executeSqlFile(filename) {
  const filePath = path.join(__dirname, filename);
  
  if (!fs.existsSync(filePath)) {
    console.error(`❌ 文件不存在: ${filename}`);
    return { success: false, insertedCount: 0 };
  }
  
  console.log(`📄 正在处理文件: ${filename}`);
  
  try {
    const sqlContent = fs.readFileSync(filePath, 'utf8');
    const { columns, rows } = parseInsertData(sqlContent);
    
    console.log(`   发现 ${rows.length} 条记录`);
    
    if (rows.length === 0) {
      console.log(`   ⚠️  没有找到有效的数据记录`);
      return { success: false, insertedCount: 0 };
    }
    
    // 批量插入数据
    const result = await insertBatchData(rows);
    
    if (result.success) {
      console.log(`   ✅ 成功插入 ${result.insertedCount} 条记录`);
    } else {
      console.log(`   ❌ 插入失败: ${result.error}`);
    }
    
    return result;
  } catch (error) {
    console.error(`   ❌ 处理文件时出错: ${error.message}`);
    return { success: false, insertedCount: 0 };
  }
}

// 主执行函数
async function insertClubReviews() {
  console.log('🚀 开始插入club评价数据到Supabase数据库...');
  console.log(`📊 计划执行 ${sqlFiles.length} 个SQL文件`);
  console.log('=' .repeat(50));
  
  let totalInserted = 0;
  let successfulFiles = 0;
  
  for (let i = 0; i < sqlFiles.length; i++) {
    const filename = sqlFiles[i];
    console.log(`\n[${i + 1}/${sqlFiles.length}] 执行文件: ${filename}`);
    
    const result = await executeSqlFile(filename);
    
    if (result.success) {
      successfulFiles++;
      totalInserted += result.insertedCount;
    }
    
    // 添加小延迟避免过快请求
    await new Promise(resolve => setTimeout(resolve, 500));
  }
  
  console.log('\n' + '=' .repeat(50));
  console.log('📈 执行总结:');
  console.log(`   ✅ 成功执行文件: ${successfulFiles}/${sqlFiles.length}`);
  console.log(`   📝 总计插入记录: ${totalInserted} 条`);
  
  if (successfulFiles === sqlFiles.length) {
    console.log('🎉 所有club评价数据插入完成！');
  } else {
    console.log('⚠️  部分文件执行失败，请检查错误信息');
  }
}

// 验证插入结果
async function verifyInsertedData() {
  console.log('\n🔍 验证插入的数据...');
  
  try {
    const { data, error } = await supabase
      .from('club_reviews')
      .select('id', { count: 'exact' });
    
    if (error) {
      console.error('❌ 验证失败:', error.message);
      return;
    }
    
    console.log(`✅ 数据库中现有club_reviews记录总数: ${data.length} 条`);
  } catch (error) {
    console.error('❌ 验证过程出错:', error.message);
  }
}

// 执行脚本
if (require.main === module) {
  insertClubReviews()
    .then(() => verifyInsertedData())
    .then(() => {
      console.log('\n✨ 脚本执行完成！');
      process.exit(0);
    })
    .catch(error => {
      console.error('💥 脚本执行失败:', error.message);
      process.exit(1);
    });
}

module.exports = { insertClubReviews, verifyInsertedData };