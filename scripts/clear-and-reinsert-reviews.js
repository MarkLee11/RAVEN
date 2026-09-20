const { createClient } = require('@supabase/supabase-js');
const { insertClubReviews } = require('./insert-club-reviews');

// Supabase配置
const supabaseUrl = 'https://gwwahjmagznitbsgtlid.supabase.co';
const supabaseServiceKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3d2Foam1hZ3puaXRic2d0bGlkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTEzMjEzMCwiZXhwIjoyMDcwNzA4MTMwfQ.jPzUuedhAfa0_1BCEbJxjmrOzPJ3YpkcCOZBrQ4fL-A';

// 使用service_role_key来获得删除权限
const supabase = createClient(supabaseUrl, supabaseServiceKey);

// 清空club_reviews表数据
async function clearClubReviews() {
  console.log('🗑️  正在清空现有的club_reviews数据...');
  
  try {
    const { error } = await supabase
      .from('club_reviews')
      .delete()
      .neq('id', 0); // 删除所有记录
    
    if (error) {
      throw error;
    }
    
    console.log('✅ 成功清空club_reviews表数据');
    return true;
  } catch (error) {
    console.error('❌ 清空数据失败:', error.message);
    return false;
  }
}

// 验证清空结果
async function verifyCleared() {
  console.log('🔍 验证清空结果...');
  
  try {
    const { data, error } = await supabase
      .from('club_reviews')
      .select('id', { count: 'exact' });
    
    if (error) {
      throw error;
    }
    
    console.log(`📊 当前club_reviews记录数: ${data.length} 条`);
    return data.length === 0;
  } catch (error) {
    console.error('❌ 验证失败:', error.message);
    return false;
  }
}

// 主执行函数
async function clearAndReinsert() {
  console.log('🚀 开始清空并重新插入club评价数据...');
  console.log('=' .repeat(50));
  
  // 1. 清空现有数据
  const cleared = await clearClubReviews();
  if (!cleared) {
    console.error('💥 清空数据失败，停止执行');
    return;
  }
  
  // 2. 验证清空结果
  const isEmpty = await verifyCleared();
  if (!isEmpty) {
    console.error('💥 数据未完全清空，停止执行');
    return;
  }
  
  console.log('\n🔄 开始重新插入数据...');
  
  // 3. 重新插入数据
  await insertClubReviews();
  
  console.log('\n🎉 清空并重新插入操作完成！');
}

// 执行脚本
if (require.main === module) {
  clearAndReinsert()
    .then(() => {
      console.log('\n✨ 脚本执行完成！');
      process.exit(0);
    })
    .catch(error => {
      console.error('💥 脚本执行失败:', error.message);
      process.exit(1);
    });
}

module.exports = { clearAndReinsert };