#!/bin/bash

# Hugo 本地开发环境启动脚本

echo "🚀 启动 Hugo 本地开发环境..."

# 检查 Docker 是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行，请先启动 Docker"
    exit 1
fi

# 构建并启动服务
echo "📦 构建 Docker 镜像..."
docker-compose build

echo "🌐 启动 Hugo 服务器..."
docker-compose up -d

echo "✅ Hugo 服务器已启动！"
echo "📖 访问地址: http://localhost:1313"
echo "🔐 Admin 页面: http://localhost:1313/admin"
echo ""
echo "📝 管理命令:"
echo "  查看日志: docker-compose logs -f"
echo "  停止服务: docker-compose down"
echo "  重启服务: docker-compose restart"
echo ""
echo "🔑 Admin 密码: admin123 (本地测试用)"
