#!/bin/bash

# Hugo Docker 本地开发环境启动脚本

echo "🚀 启动 Hugo Docker 本地开发环境..."

# 检查 Docker 是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行，请先启动 Docker"
    exit 1
fi

# 停止并删除旧容器
echo "🧹 清理旧容器..."
docker stop hugo-local 2>/dev/null || true
docker rm hugo-local 2>/dev/null || true

# 构建镜像
echo "📦 构建 Docker 镜像..."
docker build -t hugo-dev .

# 启动容器
echo "🌐 启动 Hugo 服务器..."
docker run -d \
    --name hugo-local \
    -p 1313:1313 \
    -v "$(pwd):/src" \
    -e HUGO_ENVIRONMENT=development \
    -e HUGO_ENV=development \
    -e HUGO_PARAMS_ADMIN_PASSWORD_SHA256=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 \
    -e HUGO_PARAMS_ADMIN_PASSWORD_PERSIST=local \
    -e HUGO_PARAMS_OAUTH_BASE_URL=http://localhost:3000 \
    hugo-dev

# 等待容器启动
sleep 3

# 检查容器状态
if docker ps | grep -q hugo-local; then
    echo "✅ Hugo 服务器已启动！"
    echo "📖 访问地址: http://localhost:1313"
    echo "🔐 Admin 页面: http://localhost:1313/admin"
    echo ""
    echo "🔑 Admin 密码: admin123 (本地测试用)"
    echo ""
    echo "📝 管理命令:"
    echo "  查看日志: docker logs -f hugo-local"
    echo "  停止服务: docker stop hugo-local"
    echo "  重启服务: docker restart hugo-local"
else
    echo "❌ 容器启动失败，查看日志:"
    docker logs hugo-local
fi
