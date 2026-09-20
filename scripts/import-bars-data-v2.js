const fs = require('fs');
const path = require('path');

// 读取JSON数据
const dataPath = path.join(__dirname, 'berlin-bars-data.json');
const barsData = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

console.log(`读取到 ${barsData.length} 条酒吧数据`);

// SQL字符串转义函数
function escapeSql(str) {
    if (!str) return 'NULL';
    return "'" + str.replace(/'/g, "''") + "'";
}

// 生成描述
function generateDescription(bar) {
    let desc = '';
    if (bar.rating && bar.total_ratings) {
        desc += `评分 ${bar.rating}/5 (${bar.total_ratings} 条评价)`;
    }
    if (bar.price_level) {
        const priceMap = {
            'PRICE_LEVEL_INEXPENSIVE': '经济实惠',
            'PRICE_LEVEL_MODERATE': '中等价位',
            'PRICE_LEVEL_EXPENSIVE': '较高价位',
            'PRICE_LEVEL_VERY_EXPENSIVE': '高端消费'
        };
        if (desc) desc += ' | ';
        desc += priceMap[bar.price_level] || bar.price_level;
    }
    if (bar.types && bar.types.length > 0) {
        if (desc) desc += ' | ';
        desc += '类型: ' + bar.types.join(', ');
    }
    return desc || '柏林酒吧';
}

// 类型到主题的映射
function mapTypeToTheme(type) {
    const typeMap = {
        'bar': 'cocktails',
        'night_club': 'electronic',
        'restaurant': 'food',
        'food': 'food',
        'cafe': 'food',
        'meal_takeaway': 'food',
        'liquor_store': 'spirits',
        'store': 'spirits',
        'tourist_attraction': 'cocktails'
    };
    return typeMap[type] || 'cocktails';
}

// 生成SQL文件
function generateSql() {
    let sql = `-- RAVEN项目 - 柏林酒吧数据导入脚本 (版本2)
-- 生成时间: ${new Date().toISOString()}
-- 数据来源: ${dataPath}
-- 总记录数: ${barsData.length}

-- 清理现有柏林酒吧数据以避免冲突
DELETE FROM public.bar_themes WHERE bar_id IN (
    SELECT id FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%'
);
DELETE FROM public.bar_locations WHERE bar_id IN (
    SELECT id FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%'
);
DELETE FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%';

`;

    const batchSize = 50;
    const totalBatches = Math.ceil(barsData.length / batchSize);

    for (let batch = 0; batch < totalBatches; batch++) {
        const startIdx = batch * batchSize;
        const endIdx = Math.min(startIdx + batchSize, barsData.length);
        const batchData = barsData.slice(startIdx, endIdx);
        
        sql += `-- 批次 ${batch + 1}: 记录 ${startIdx + 1}-${endIdx}\nBEGIN;\n\n`;
        
        // 插入bars表数据 (不指定ID，使用自动生成)
        sql += '-- 插入bars表数据\n';
        sql += 'INSERT INTO public.bars (name, district_id, description, cash_only, card_accepted) VALUES\n';
        
        const barValues = batchData.map(bar => {
            const name = escapeSql(bar.name);
            const description = escapeSql(generateDescription(bar));
            return `    (${name}, 1, ${description}, false, false)`;
        });
        
        sql += barValues.join(',\n') + ';\n\n';
        
        // 插入bar_locations表数据
        sql += '-- 插入bar_locations表数据\n';
        sql += 'WITH inserted_bars AS (\n';
        sql += '    SELECT id, name FROM public.bars WHERE name IN (\n';
        
        const nameList = batchData.map(bar => escapeSql(bar.name)).join(',\n        ');
        sql += `        ${nameList}\n    )\n)\n`;
        
        sql += 'INSERT INTO public.bar_locations (bar_id, address_line, postal_code, latitude, longitude)\n';
        sql += 'SELECT ib.id, loc.address_line, loc.postal_code, loc.latitude, loc.longitude\n';
        sql += 'FROM inserted_bars ib\n';
        sql += 'JOIN (VALUES\n';
        
        const locationValues = batchData.map(bar => {
            const name = escapeSql(bar.name);
            const address = escapeSql(bar.address);
            const postalCode = bar.address && bar.address.match(/\d{5}/) ? escapeSql(bar.address.match(/\d{5}/)[0]) : 'NULL';
            const lat = bar.latitude || 'NULL';
            const lng = bar.longitude || 'NULL';
            return `    (${name}, ${address}, ${postalCode}, ${lat}, ${lng})`;
        });
        
        sql += locationValues.join(',\n') + '\n';
        sql += ') AS loc(name, address_line, postal_code, latitude, longitude) ON ib.name = loc.name;\n\n';
        
        // 插入bar_themes表数据
        sql += '-- 插入bar_themes表数据\n';
        sql += 'WITH inserted_bars AS (\n';
        sql += '    SELECT id, name FROM public.bars WHERE name IN (\n';
        sql += `        ${nameList}\n    )\n)\n`;
        
        sql += 'INSERT INTO public.bar_themes (bar_id, theme_id)\n';
        sql += 'SELECT ib.id, t.id\n';
        sql += 'FROM inserted_bars ib\n';
        sql += 'JOIN (VALUES\n';
        
        const themeValues = [];
        batchData.forEach(bar => {
            if (bar.types && bar.types.length > 0) {
                const uniqueThemes = [...new Set(bar.types.map(mapTypeToTheme))];
                uniqueThemes.forEach(theme => {
                    themeValues.push(`    (${escapeSql(bar.name)}, '${theme}')`);
                });
            } else {
                themeValues.push(`    (${escapeSql(bar.name)}, 'cocktails')`);
            }
        });
        
        sql += themeValues.join(',\n') + '\n';
        sql += ') AS bt(bar_name, theme_name) ON ib.name = bt.bar_name\n';
        sql += 'JOIN public.themes t ON t.name = bt.theme_name;\n\n';
        
        sql += 'COMMIT;\n\n';
    }
    
    // 添加数据验证查询
    sql += `-- 数据验证查询\n`;
    sql += `SELECT 'bars' as table_name, COUNT(*) as count FROM public.bars WHERE description LIKE '%柏林%' OR description LIKE '%Berlin%'\n`;
    sql += `UNION ALL\n`;
    sql += `SELECT 'bar_locations' as table_name, COUNT(*) as count FROM public.bar_locations bl\n`;
    sql += `JOIN public.bars b ON bl.bar_id = b.id WHERE b.description LIKE '%柏林%' OR b.description LIKE '%Berlin%'\n`;
    sql += `UNION ALL\n`;
    sql += `SELECT 'bar_themes' as table_name, COUNT(*) as count FROM public.bar_themes bt\n`;
    sql += `JOIN public.bars b ON bt.bar_id = b.id WHERE b.description LIKE '%柏林%' OR b.description LIKE '%Berlin%';\n\n`;
    
    // 添加示例查询
    sql += `-- 导入数据示例查询\n`;
    sql += `SELECT b.name, b.description, bl.address_line, bl.latitude, bl.longitude,\n`;
    sql += `       STRING_AGG(t.name, ', ') as themes\n`;
    sql += `FROM public.bars b\n`;
    sql += `LEFT JOIN public.bar_locations bl ON b.id = bl.bar_id\n`;
    sql += `LEFT JOIN public.bar_themes bt ON b.id = bt.bar_id\n`;
    sql += `LEFT JOIN public.themes t ON bt.theme_id = t.id\n`;
    sql += `WHERE b.description LIKE '%柏林%' OR b.description LIKE '%Berlin%'\n`;
    sql += `GROUP BY b.id, b.name, b.description, bl.address_line, bl.latitude, bl.longitude\n`;
    sql += `ORDER BY b.name\n`;
    sql += `LIMIT 10;`;
    
    return sql;
}

// 生成并保存SQL文件
const sqlContent = generateSql();
const outputPath = path.join(__dirname, 'bars-import-v2.sql');
fs.writeFileSync(outputPath, sqlContent, 'utf8');

console.log(`SQL导入文件已生成: ${outputPath}`);
console.log(`文件大小: ${(fs.statSync(outputPath).size / 1024).toFixed(2)} KB`);
console.log(`总批次数: ${Math.ceil(barsData.length / 50)}`);