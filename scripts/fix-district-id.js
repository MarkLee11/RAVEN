const fs = require('fs');

// 读取原始SQL文件
const sqlFile = 'e:\\RAVEN\\supabase\\migrations\\bars-import-v2.sql';
let content = fs.readFileSync(sqlFile, 'utf8');

// 使用正则表达式替换所有的 ', 1,' 为 ', NULL,'
content = content.replace(/', 1,'/g, ', NULL,');

// 写回文件
fs.writeFileSync(sqlFile, content);

console.log('已修复所有district_id值为NULL');

// 验证修复结果
const matches = content.match(/', 1,'/g);
if (matches) {
    console.log(`警告：仍有 ${matches.length} 个未修复的 district_id=1`);
} else {
    console.log('✓ 所有district_id已成功修复为NULL');
}