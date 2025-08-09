#!/bin/bash

# Hugo Docker 本地开发环境停止脚本

echo "🛑 停止 Hugo Docker 本地开发环境..."

# 停止并删除容器
docker stop hugo-local 2>/dev/null || true
docker rm hugo-local 2>/dev/null || true

echo "✅ Hugo 服务器已停止！"
echo "🧹 容器已清理"
