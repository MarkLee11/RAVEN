const fs = require('fs');
const path = require('path');

// 读取JSON数据
const jsonFile = path.join(__dirname, 'berlin-bars-data.json');
const barsData = JSON.parse(fs.readFileSync(jsonFile, 'utf8'));

console.log(`读取到 ${barsData.length} 条酒吧数据`);

// 生成SQL文件
let sql = `-- RAVEN Project - Berlin Bars Data Import Script (Version 3)
-- Generated: ${new Date().toISOString()}
-- Source: ${jsonFile}
-- Total Records: ${barsData.length}

`;

// 分批处理数据
const batchSize = 50;
const batches = [];
for (let i = 0; i < barsData.length; i += batchSize) {
    batches.push(barsData.slice(i, i + batchSize));
}

console.log(`数据将分为 ${batches.length} 个批次处理`);

// 为每个批次生成SQL
batches.forEach((batch, batchIndex) => {
    const batchNum = batchIndex + 1;
    const startRecord = batchIndex * batchSize + 1;
    const endRecord = Math.min(startRecord + batchSize - 1, barsData.length);
    
    sql += `-- Batch ${batchNum}: Records ${startRecord}-${endRecord}\nBEGIN;\n\n`;
    
    // 插入bars表数据
    sql += `-- Insert bars table data\nINSERT INTO public.bars (name, district_id, description, cash_only, card_accepted) VALUES\n`;
    
    const barValues = batch.map(bar => {
        const name = bar.name.replace(/'/g, "''"); // 转义单引号
        const rating = bar.rating || 'N/A';
        const totalRatings = bar.total_ratings || 0;
        const priceLevel = bar.price_level || '';
        const types = (bar.types || []).join(', ');
        const description = `Rating ${rating}/5 (${totalRatings} reviews) | Price: ${priceLevel} | Types: ${types}`.replace(/'/g, "''");
        
        return `    ('${name}', NULL, '${description}', false, false)`;
    }).join(',\n');
    
    sql += barValues + ';\n\n';
    
    // 插入bar_locations表数据
    sql += `-- Insert bar_locations table data\nWITH inserted_bars AS (\n`;
    sql += `    SELECT id, name FROM public.bars WHERE name IN (\n`;
    
    const barNames = batch.map(bar => `        '${bar.name.replace(/'/g, "''")}'`).join(',\n');
    sql += barNames + '\n    )\n)\n';
    
    sql += `INSERT INTO public.bar_locations (bar_id, address_line, postal_code, latitude, longitude)\n`;
    sql += `SELECT ib.id, loc.address_line, loc.postal_code, loc.latitude, loc.longitude\n`;
    sql += `FROM inserted_bars ib\n`;
    sql += `JOIN (VALUES\n`;
    
    const locationValues = batch.map(bar => {
        const name = bar.name.replace(/'/g, "''");
        const address = (bar.address || '').replace(/'/g, "''");
        const postalCode = extractPostalCode(bar.address || '');
        const lat = bar.latitude || 0;
        const lng = bar.longitude || 0;
        
        return `    ('${name}', '${address}', '${postalCode}', ${lat}, ${lng})`;
    }).join(',\n');
    
    sql += locationValues + '\n) AS loc(name, address_line, postal_code, latitude, longitude) ON ib.name = loc.name;\n\n';
    
    // 插入bar_themes表数据
    sql += `-- Insert bar_themes table data\nWITH inserted_bars AS (\n`;
    sql += `    SELECT id, name FROM public.bars WHERE name IN (\n`;
    sql += barNames + '\n    )\n),\n';
    sql += `theme_mapping AS (\n`;
    sql += `    SELECT ib.id as bar_id, t.id as theme_id\n`;
    sql += `    FROM inserted_bars ib\n`;
    sql += `    CROSS JOIN public.themes t\n`;
    sql += `    WHERE t.name = 'Bar' -- Default theme for all bars\n`;
    sql += `)\n`;
    sql += `INSERT INTO public.bar_themes (bar_id, theme_id)\n`;
    sql += `SELECT DISTINCT bar_id, theme_id FROM theme_mapping;\n\n`;
    
    sql += `COMMIT;\n\n`;
});

// 提取邮政编码的辅助函数
function extractPostalCode(address) {
    const match = address.match(/\b(\d{5})\b/);
    return match ? match[1] : '';
}

// 写入SQL文件
const outputFile = path.join(__dirname, '..', 'supabase', 'migrations', 'bars-import-v3.sql');
fs.writeFileSync(outputFile, sql, 'utf8');

console.log(`SQL文件已生成: ${outputFile}`);
console.log(`文件大小: ${(fs.statSync(outputFile).size / 1024).toFixed(2)} KB`);
console.log(`共 ${batches.length} 个批次`);