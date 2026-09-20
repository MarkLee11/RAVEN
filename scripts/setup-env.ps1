# RAVEN项目 - 环境变量设置脚本
# 用于设置Supabase连接信息

Write-Host "🔧 RAVEN项目 - Supabase环境变量设置" -ForegroundColor Green
Write-Host ""

# 提示用户输入Supabase信息
Write-Host "请输入你的Supabase项目信息:" -ForegroundColor Yellow
Write-Host ""

$supabaseUrl = Read-Host "Supabase URL (例如: https://your-project.supabase.co)"
$supabaseServiceKey = Read-Host "Supabase Service Key (或 Anon Key)"

if (-not $supabaseUrl -or -not $supabaseServiceKey) {
    Write-Host "❌ 错误: 必须提供Supabase URL和Service Key" -ForegroundColor Red
    exit 1
}

# 设置环境变量
$env:SUPABASE_URL = $supabaseUrl
$env:SUPABASE_SERVICE_KEY = $supabaseServiceKey

Write-Host ""
Write-Host "✅ 环境变量设置成功!" -ForegroundColor Green
Write-Host "SUPABASE_URL: $supabaseUrl" -ForegroundColor Cyan
Write-Host "SUPABASE_SERVICE_KEY: [已设置]" -ForegroundColor Cyan
Write-Host ""
Write-Host "现在可以运行导入脚本:" -ForegroundColor Yellow
Write-Host "node import-mock-data-supabase.js" -ForegroundColor White
Write-Host ""
Write-Host "或者手动设置环境变量后运行:" -ForegroundColor Yellow
Write-Host '$env:SUPABASE_URL="' + $supabaseUrl + '"' -ForegroundColor White
Write-Host '$env:SUPABASE_SERVICE_KEY="your-service-key"' -ForegroundColor White
Write-Host "node import-mock-data-supabase.js" -ForegroundColor White

