# RAVEN项目 - 导入模拟数据PowerShell脚本
# 生成时间: 2025-08-23T05:36:34.551Z

param(
    [Parameter(Mandatory=$true)]
    [string]$ConnectionString,
    
    [Parameter(Mandatory=$false)]
    [switch]$Help
)

if ($Help) {
    Write-Host "RAVEN项目 - 酒吧模拟数据导入脚本" -ForegroundColor Green
    Write-Host ""
    Write-Host "用法:" -ForegroundColor Yellow
    Write-Host "  .\import-mock-data.ps1 -ConnectionString 'your_connection_string'"
    Write-Host ""
    Write-Host "参数:" -ForegroundColor Yellow
    Write-Host "  -ConnectionString : PostgreSQL数据库连接字符串"
    Write-Host "  -Help            : 显示此帮助信息"
    Write-Host ""
    Write-Host "示例:" -ForegroundColor Yellow
    Write-Host "  .\import-mock-data.ps1 -ConnectionString 'postgresql://user:pass@localhost:5432/raven'"
    Write-Host ""
    Write-Host "数据包含:" -ForegroundColor Cyan
    Write-Host "  - 1000个模拟酒吧"
    Write-Host "  - 1000条评分记录"
    Write-Host "  - 1000条评论记录"
    Write-Host "  - 2000-5000条主题关联记录"
    exit
}

if (-not $ConnectionString) {
    Write-Host "错误: 必须提供数据库连接字符串" -ForegroundColor Red
    Write-Host "使用 -Help 参数查看使用说明"
    exit 1
}

Write-Host "🚀 开始导入RAVEN项目模拟数据..." -ForegroundColor Green
Write-Host "连接字符串: $ConnectionString" -ForegroundColor Cyan

# 检查psql是否可用
try {
    $null = Get-Command psql -ErrorAction Stop
} catch {
    Write-Host "错误: 未找到psql命令。请确保PostgreSQL客户端已安装并在PATH中。" -ForegroundColor Red
    exit 1
}

# 检查文件是否存在
$sqlFiles = @(
    "bars-mock-data.sql",
    "bar-ratings-batch-01.sql", "bar-ratings-batch-02.sql", "bar-ratings-batch-03.sql", 
    "bar-ratings-batch-04.sql", "bar-ratings-batch-05.sql", "bar-ratings-batch-06.sql",
    "bar-ratings-batch-07.sql", "bar-ratings-batch-08.sql", "bar-ratings-batch-09.sql", 
    "bar-ratings-batch-10.sql",
    "bar-reviews-batch-01.sql", "bar-reviews-batch-02.sql", "bar-reviews-batch-03.sql",
    "bar-reviews-batch-04.sql", "bar-reviews-batch-05.sql", "bar-reviews-batch-06.sql", 
    "bar-reviews-batch-07.sql", "bar-reviews-batch-08.sql", "bar-reviews-batch-09.sql", 
    "bar-reviews-batch-10.sql"
)

foreach ($file in $sqlFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "错误: 找不到文件 $file" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ 所有SQL文件已找到" -ForegroundColor Green

# 导入数据函数
function Import-SqlFile {
    param([string]$FilePath, [string]$Description)
    
    Write-Host "正在导入: $Description" -ForegroundColor Yellow
    try {
        $result = psql $ConnectionString -f $FilePath 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ $Description 导入成功" -ForegroundColor Green
        } else {
            Write-Host "❌ $Description 导入失败" -ForegroundColor Red
            Write-Host $result -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "❌ $Description 导入失败: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    return $true
}

# 开始导入
$startTime = Get-Date

Write-Host ""
Write-Host "📊 开始导入数据..." -ForegroundColor Cyan

# 1. 导入酒吧基础数据
if (-not (Import-SqlFile "bars-mock-data.sql" "酒吧基础数据 (1000条)")) { exit 1 }

# 2. 导入评分数据
Write-Host ""
Write-Host "📈 导入评分数据..." -ForegroundColor Cyan
for ($i = 1; $i -le 10; $i++) {
    $batchStr = $i.ToString().PadLeft(2, '0')
    $filename = "bar-ratings-batch-$batchStr.sql"
    if (-not (Import-SqlFile $filename "评分数据批次 $i (100条)")) { exit 1 }
}

# 3. 导入评论数据
Write-Host ""
Write-Host "💬 导入评论数据..." -ForegroundColor Cyan
for ($i = 1; $i -le 10; $i++) {
    $batchStr = $i.ToString().PadLeft(2, '0')
    $filename = "bar-reviews-batch-$batchStr.sql"
    if (-not (Import-SqlFile $filename "评论数据批次 $i (100条)")) { exit 1 }
}

# 4. 数据完整性检查
Write-Host ""
Write-Host "🔍 进行数据完整性检查..." -ForegroundColor Cyan

$checkSql = @"
SELECT 
    (SELECT COUNT(*) FROM public.bars WHERE id BETWEEN 1 AND 1000) as bars_count,
    (SELECT COUNT(*) FROM public.bar_ratings WHERE bar_id BETWEEN 1 AND 1000) as ratings_count,
    (SELECT COUNT(*) FROM public.bar_reviews WHERE bar_id BETWEEN 1 AND 1000) as reviews_count,
    (SELECT COUNT(*) FROM public.bar_themes WHERE bar_id BETWEEN 1 AND 1000) as themes_count;
"@

try {
    $counts = psql $ConnectionString -t -c $checkSql
    Write-Host "数据统计: $counts" -ForegroundColor Cyan
    
    # 解析结果
    $parts = $counts.Trim() -split '\|'
    $barsCount = [int]$parts[0].Trim()
    $ratingsCount = [int]$parts[1].Trim()
    $reviewsCount = [int]$parts[2].Trim()
    $themesCount = [int]$parts[3].Trim()
    
    Write-Host ""
    Write-Host "📈 数据导入统计:" -ForegroundColor Green
    Write-Host "  酒吧数量: $barsCount" -ForegroundColor White
    Write-Host "  评分记录: $ratingsCount" -ForegroundColor White
    Write-Host "  评论记录: $reviewsCount" -ForegroundColor White
    Write-Host "  主题关联: $themesCount" -ForegroundColor White
    
    if ($barsCount -eq 1000 -and $ratingsCount -eq 1000 -and $reviewsCount -eq 1000) {
        Write-Host ""
        Write-Host "🎉 所有数据导入成功！" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "⚠️  数据导入可能不完整，请检查！" -ForegroundColor Yellow
    }
} catch {
    Write-Host "数据完整性检查失败: $($_.Exception.Message)" -ForegroundColor Red
}

$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host ""
Write-Host "⏱️  导入耗时: $($duration.TotalSeconds.ToString('F2')) 秒" -ForegroundColor Cyan
Write-Host "🏁 导入完成！" -ForegroundColor Green


