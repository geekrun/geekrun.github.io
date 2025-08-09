# 使用官方 Hugo 镜像作为基础镜像
FROM hugomods/hugo:latest

# 设置工作目录
WORKDIR /src

# 暴露端口
EXPOSE 1313

# 设置环境变量（用于本地测试）
ENV HUGO_ENVIRONMENT=development
ENV HUGO_ENV=development

# 复制项目文件
COPY . .

# 启动 Hugo 服务器
CMD ["server", "--bind", "0.0.0.0", "--port", "1313", "--disableFastRender"]
