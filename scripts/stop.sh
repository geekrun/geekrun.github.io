#!/bin/bash

# Hugo 本地开发环境停止脚本

echo "🛑 停止 Hugo 本地开发环境..."

# 停止并清理服务
docker-compose down

echo "✅ Hugo 服务器已停止！"
echo "🧹 容器已清理"
