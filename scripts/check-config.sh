#!/bin/bash

echo "🔍 Checking Hugo Configuration..."
echo "=================================="

# Check Hugo version
echo "📦 Hugo Version:"
hugo version

# Check if theme exists
echo -e "\n🎨 Theme Check:"
if [ -d "themes/PaperMod" ]; then
    echo "✅ PaperMod theme found"
else
    echo "❌ PaperMod theme not found"
    echo "Running: git submodule update --init --recursive"
    git submodule update --init --recursive
fi

# Check configuration
echo -e "\n⚙️  Configuration Check:"
if hugo config > /dev/null 2>&1; then
    echo "✅ Hugo configuration is valid"
else
    echo "❌ Hugo configuration has errors"
    hugo config
fi

# Test build
echo -e "\n🏗️  Build Test:"
if hugo --gc --minify > /dev/null 2>&1; then
    echo "✅ Site builds successfully"
    echo "📊 Build stats:"
    hugo --gc --minify --quiet | grep -E "(Pages|Total)"
else
    echo "❌ Build failed"
    echo "Running build with verbose output:"
    hugo --gc --minify
fi

# Check generated files
echo -e "\n📁 Generated Files:"
if [ -d "public" ]; then
    echo "✅ Public directory exists"
    echo "📄 Files generated:"
    find public -type f | wc -l | sed 's/^/   /'
else
    echo "❌ Public directory not found"
fi

# Check GitHub Actions
echo -e "\n🚀 GitHub Actions:"
if [ -f ".github/workflows/hugo.yml" ]; then
    echo "✅ Hugo workflow found"
else
    echo "❌ Hugo workflow not found"
fi

if [ -f ".github/workflows/vercel.yml" ]; then
    echo "✅ Vercel workflow found"
else
    echo "❌ Vercel workflow not found"
fi

echo -e "\n✨ Configuration check complete!" 