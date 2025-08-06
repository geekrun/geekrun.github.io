#!/bin/bash

echo "🚀 检查部署状态..."
echo "=================="

# 检查本地构建
echo "📦 本地构建检查:"
if hugo --gc --minify --quiet > /dev/null 2>&1; then
    echo "✅ 本地构建成功"
else
    echo "❌ 本地构建失败"
    exit 1
fi

# 检查Git状态
echo -e "\n📝 Git状态:"
git_status=$(git status --porcelain)
if [ -z "$git_status" ]; then
    echo "✅ 工作目录干净"
else
    echo "⚠️  有未提交的更改:"
    echo "$git_status"
fi

# 检查远程分支
echo -e "\n🌐 远程分支状态:"
current_branch=$(git branch --show-current)
echo "当前分支: $current_branch"

# 检查GitHub Actions URL
echo -e "\n🔗 GitHub Actions链接:"
echo "https://github.com/geekrun/geekrun.github.io/actions"

# 检查GitHub Pages URL
echo -e "\n🌍 GitHub Pages链接:"
echo "https://geekrun.github.io/geekrun.github.io/"

# 检查配置文件
echo -e "\n⚙️  配置文件检查:"
if [ -f ".github/workflows/hugo.yml" ]; then
    echo "✅ Hugo Actions工作流存在"
else
    echo "❌ Hugo Actions工作流不存在"
fi

if [ -f "hugo.toml" ]; then
    echo "✅ Hugo配置文件存在"
else
    echo "❌ Hugo配置文件不存在"
fi

# 检查主题
echo -e "\n🎨 主题检查:"
if [ -d "themes/PaperMod" ]; then
    echo "✅ PaperMod主题已安装"
else
    echo "❌ PaperMod主题未安装"
fi

echo -e "\n✨ 部署状态检查完成!"
echo -e "\n📋 下一步操作:"
echo "1. 访问 GitHub Actions: https://github.com/geekrun/geekrun.github.io/actions"
echo "2. 配置 GitHub Pages: https://github.com/geekrun/geekrun.github.io/settings/pages"
echo "3. 选择 'GitHub Actions' 作为部署源"
echo "4. 等待部署完成"
echo "5. 访问网站: https://geekrun.github.io/geekrun.github.io/" 