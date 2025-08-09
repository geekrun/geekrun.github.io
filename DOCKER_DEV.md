# Docker 本地开发环境

## 快速开始

### 1. 启动开发环境
```bash
# 使用脚本启动（推荐）
./scripts/docker-dev.sh

# 或手动启动
docker build -t hugo-dev .
docker run -d --name hugo-local -p 1313:1313 -v $(pwd):/src hugo-dev
```

### 2. 访问网站
- 主站: http://localhost:1313
- Admin 页面: http://localhost:1313/admin
- Admin 密码: `admin123` (仅本地测试用)

### 3. 停止开发环境
```bash
# 使用脚本停止
./scripts/docker-stop.sh

# 或手动停止
docker stop hugo-local && docker rm hugo-local
```

## 环境变量说明

本地开发环境使用以下默认配置：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `HUGO_PARAMS_ADMIN_PASSWORD_SHA256` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` | Admin 密码的 SHA256 哈希 (admin123) |
| `HUGO_PARAMS_ADMIN_PASSWORD_PERSIST` | `local` | 密码持久化方式 (local/session) |
| `HUGO_PARAMS_OAUTH_BASE_URL` | `http://localhost:3000` | OAuth 代理地址 (本地测试用) |

## 常用命令

```bash
# 查看日志
docker logs -f hugo-local

# 重启服务
docker restart hugo-local

# 重新构建镜像
docker build -t hugo-dev .

# 进入容器
docker exec -it hugo-local sh

# 查看容器状态
docker ps
```

## 文件结构

```
.
├── Dockerfile              # Docker 镜像定义
├── docker-compose.yml      # Docker Compose 配置
├── .dockerignore          # Docker 忽略文件
├── scripts/
│   ├── dev.sh            # 启动脚本
│   └── stop.sh           # 停止脚本
└── DOCKER_DEV.md         # 本文档
```

## 注意事项

1. **端口冲突**: 确保 1313 端口未被占用
2. **文件权限**: WSL 中可能需要调整文件权限
3. **热重载**: 修改源代码后会自动重新加载
4. **Admin 功能**: 本地测试时 OAuth 功能不可用，仅用于界面测试

## 故障排除

### 端口被占用
```bash
# 查看端口占用
netstat -tulpn | grep 1313

# 修改端口
# 编辑 docker-compose.yml 中的 ports 部分
```

### 权限问题
```bash
# 修复文件权限
chmod -R 755 .
chmod +x scripts/*.sh
```

### 容器启动失败
```bash
# 查看详细错误
docker-compose logs

# 清理并重新构建
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```
