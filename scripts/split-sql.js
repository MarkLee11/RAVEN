const fs = require('fs');
const path = require('path');

// 读取原始SQL文件
const sqlFile = 'e:\\RAVEN\\supabase\\migrations\\bars-import-v2.sql';
const content = fs.readFileSync(sqlFile, 'utf8');

// 按批次分割（每个BEGIN...COMMIT为一个批次）
const batches = content.split('BEGIN;').filter(batch => batch.trim().length > 0);

console.log(`找到 ${batches.length} 个批次`);

// 为每个批次创建单独的SQL文件
batches.forEach((batch, index) => {
    if (index === 0) {
        // 第一个部分包含注释和序列重置
        const fileName = `e:\\RAVEN\\supabase\\migrations\\bars-import-batch-${index + 1}.sql`;
        fs.writeFileSync(fileName, batch.trim());
        console.log(`创建文件: ${fileName}`);
    } else {
        // 其他批次需要添加BEGIN
        const fileName = `e:\\RAVEN\\supabase\\migrations\\bars-import-batch-${index + 1}.sql`;
        const batchContent = 'BEGIN;' + batch;
        fs.writeFileSync(fileName, batchContent);
        console.log(`创建文件: ${fileName} (${Math.round(batchContent.length / 1024)}KB)`);
    }
});

console.log('SQL文件分割完成！');