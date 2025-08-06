# GitHub Pages 设置指南

## 使用 GitHub Actions 部署

### 步骤 1: 配置 GitHub Pages

1. **进入仓库设置**:
   - 访问: https://github.com/geekrun/geekrun.github.io/settings/pages

2. **配置部署源**:
   - **Source**: 选择 "GitHub Actions"
   - 这将启用 GitHub Actions 部署

3. **验证配置**:
   - 确保 "Build and deployment" 部分显示 "GitHub Actions"
   - 确保 "Branch" 部分显示 "Deploy from a branch"

### 步骤 2: 检查 GitHub Actions 工作流

我们的 `.github/workflows/hugo.yml` 已经配置好：

```yaml
name: Deploy Hugo site to Pages

on:
  push:
    branches: ["main", "master"]
  pull_request:
    branches: ["main", "master"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
      
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.148.2'
          extended: true
      
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v4
      
      - name: Build with Hugo
        run: hugo --gc --minify
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/master'
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 步骤 3: 触发部署

1. **推送更改** (已完成):
   ```bash
   git push origin master
   ```

2. **检查 Actions**:
   - 访问: https://github.com/geekrun/geekrun.github.io/actions
   - 应该看到 "Deploy Hugo site to Pages" 工作流正在运行

### 步骤 4: 验证部署

1. **等待部署完成**:
   - 查看 Actions 页面，等待绿色勾号
   - 通常需要 2-5 分钟

2. **访问网站**:
   - 部署完成后，访问: https://geekrun.github.io/geekrun.github.io/
   - 或者检查 Actions 输出中的 URL

### 步骤 5: 更新 baseURL

部署成功后，更新 `hugo.toml`:

```toml
baseURL = 'https://geekrun.github.io/geekrun.github.io/'
```

然后推送更改:
```bash
git add hugo.toml
git commit -m "Update baseURL for GitHub Pages"
git push origin master
```

## 故障排除

### 常见问题

1. **Actions 没有运行**:
   - 检查 `.github/workflows/hugo.yml` 文件是否存在
   - 确保文件语法正确

2. **构建失败**:
   - 检查 Actions 日志
   - 确保 Hugo 版本兼容
   - 验证主题子模块

3. **部署失败**:
   - 检查 Pages 设置是否正确
   - 确保仓库有正确的权限

4. **网站无法访问**:
   - 等待几分钟让 DNS 传播
   - 检查 Pages 设置中的 URL

### 手动触发部署

如果需要手动触发部署:

1. 访问 Actions 页面
2. 点击 "Deploy Hugo site to Pages"
3. 点击 "Run workflow"
4. 选择分支 (master)
5. 点击 "Run workflow"

## 监控部署

### 有用的链接

- **Actions**: https://github.com/geekrun/geekrun.github.io/actions
- **Pages 设置**: https://github.com/geekrun/geekrun.github.io/settings/pages
- **网站**: https://geekrun.github.io/geekrun.github.io/

### 部署状态

- ✅ GitHub Actions 工作流已配置
- ✅ Hugo 构建脚本已优化
- ✅ 子模块支持已启用
- ✅ 自动部署已设置

---

**下一步**: 推送任何更改，GitHub Actions 将自动构建和部署你的网站！ 