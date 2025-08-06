# GeekRun Hugo Blog

A modern, fast personal blog built with Hugo and the PaperMod theme. Features include public and private posts, code highlighting, search functionality, and automatic deployment.

## Features

- ⚡ **Fast Performance**: Built with Hugo for lightning-fast build times
- 🎨 **Modern Design**: Clean PaperMod theme with dark/light mode
- 🔒 **Content Encryption**: Password-protect sensitive content
- 🔍 **Search Functionality**: Client-side search with Fuse.js
- 📱 **Mobile Optimized**: Responsive design for all devices
- 🚀 **Easy Deployment**: Automatic deployment to Vercel
- 📝 **Markdown Support**: Full Markdown with code highlighting
- 🏷️ **Taxonomies**: Tags, categories, and series support

## Quick Start

### Prerequisites

- [Hugo](https://gohugo.io/installation/) (Extended version recommended)
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (for optional npm packages)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/geekrun-hugo.git
   cd geekrun-hugo
   ```

2. **Install theme submodule**:
   ```bash
   git submodule update --init --recursive
   ```

3. **Start development server**:
   ```bash
   hugo server -D
   ```

4. **Visit your site**: http://localhost:1313

## Content Structure

```
content/
├── posts/          # Public blog posts
├── private/        # Private/encrypted posts
└── about/
    └── _index.md   # About page
```

### Creating Posts

**Public Posts**:
```bash
hugo new posts/my-new-post.md
```

**Private Posts**:
```bash
hugo new private/secret-post.md
```

### Post Front Matter

```yaml
---
title: "Post Title"
date: 2024-08-06
draft: false
description: "Post description"
tags: ["tag1", "tag2"]
categories: ["category1"]
toc: true
readingTime: true
---
```

## 🔐 Advanced Encryption Feature

### 强大的文章加密功能

本博客使用客户端JavaScript加密功能，提供安全的密码保护内容。

### 快速使用

#### 1. 使用默认密码（geekrun123）
```markdown
{{< encrypt >}}
这里是需要加密的内容
{{< /encrypt >}}
```

#### 2. 使用自定义密码
```markdown
{{< encrypt "自定义密码" >}}
这里是需要加密的内容
{{< /encrypt >}}
```

### 功能特性

- 🔐 **AES-256-GCM加密**：军用级加密标准
- 🎨 **现代化UI**：美观的密码输入界面  
- ⚡ **智能记忆**：会话期间记住密码
- 📱 **移动适配**：完美支持各种设备
- 🔄 **部分加密**：同一文章混合公开/加密内容
- 🌐 **SEO友好**：只加密指定内容

### 配置选项

在 `hugo.toml` 中自定义：
```toml
[params.encrypt]
  password = "your-default-password"  # 默认密码
  storage = "session"                 # session 或 local
```

## Configuration

### Site Configuration (`hugo.toml`)

Key settings:

```toml
baseURL = 'https://yourdomain.com/'
title = 'Your Blog Name'
theme = 'PaperMod'

[params]
  description = "Your blog description"
  author = "Your Name"
  ShowReadingTime = true
  ShowCodeCopyButtons = true
```

### Social Links

Update social links in `hugo.toml`:

```toml
[params.socialIcons]
  github = "https://github.com/yourusername"
  twitter = "https://twitter.com/yourusername"
  linkedin = "https://linkedin.com/in/yourusername"
  email = "mailto:your@email.com"
```

## Deployment

### Vercel Deployment (Recommended)

1. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. **Connect to Vercel**:
   - Go to [Vercel](https://vercel.com)
   - Import your GitHub repository
   - Configure build settings:
     - **Framework Preset**: Hugo
     - **Build Command**: `hugo --minify`
     - **Output Directory**: `public`
     - **Install Command**: Leave empty

3. **Environment Variables** (optional):
   - `HUGO_VERSION`: Set to your Hugo version
   - `HUGO_ENV`: Set to `production`

4. **Deploy**: Vercel will automatically deploy on every push

### GitHub Pages Alternative

1. **Create GitHub Action**:
   Create `.github/workflows/hugo.yml`:

   ```yaml
   name: Deploy Hugo site to Pages

   on:
     push:
       branches: ["main"]
     workflow_dispatch:

   permissions:
     contents: read
     pages: write
     id-token: write

   concurrency:
     group: "pages"
     cancel-in-progress: false

   defaults:
     run:
       shell: bash

   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - name: Install Hugo CLI
           run: |
             wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb
             sudo dpkg -i ${{ runner.temp }}/hugo.deb
           env:
             HUGO_VERSION: 0.115.0
         - name: Checkout
           uses: actions/checkout@v4
           with:
             submodules: recursive
             fetch-depth: 0
         - name: Setup Pages
           id: pages
           uses: actions/configure-pages@v4
         - name: Build with Hugo
           env:
             HUGO_ENVIRONMENT: production
             HUGO_ENV: production
           run: |
             hugo \
               --gc \
               --minify \
               --baseURL "${{ steps.pages.outputs.base_url }}/"
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
       steps:
         - name: Deploy to GitHub Pages
           id: deployment
           uses: actions/deploy-pages@v4
   ```

2. **Enable GitHub Pages**:
   - Go to repository Settings > Pages
   - Source: GitHub Actions

## Migration from Other Platforms

### From Hexo

1. **Export content**:
   ```bash
   # Copy your Hexo posts to Hugo content directory
   cp -r source/_posts/* content/posts/
   ```

2. **Update front matter**:
   - Convert Hexo front matter to Hugo format
   - Update image paths
   - Fix any broken links

3. **Update internal links**:
   ```bash
   # Find and replace Hexo-style links
   find content/ -name "*.md" -exec sed -i 's/\[.*\](\/.*\/.*\/)/[{{< ref "$1" >}}]/g' {} \;
   ```

### From WordPress

1. **Export WordPress content**:
   - Use WordPress export tool
   - Convert to Markdown using tools like `wordpress-to-markdown`

2. **Import to Hugo**:
   ```bash
   # Place exported Markdown files in content/posts/
   cp exported-posts/* content/posts/
   ```

### From Jekyll

1. **Copy content**:
   ```bash
   cp -r _posts/* content/posts/
   ```

2. **Update front matter**:
   - Convert YAML front matter to Hugo format
   - Update permalink structure if needed

## Customization

### Adding Custom CSS

Create `assets/css/custom.css`:

```css
/* Your custom styles */
.custom-class {
    color: #your-color;
}
```

### Adding Custom JavaScript

Create `static/js/custom.js`:

```javascript
// Your custom JavaScript
console.log('Custom script loaded');
```

### Custom Shortcodes

Create shortcodes in `layouts/shortcodes/`:

```html
<!-- layouts/shortcodes/custom.html -->
<div class="custom-shortcode">
    {{ .Inner }}
</div>
```

## Performance Optimization

### Build Optimization

```bash
# Production build with optimizations
hugo --minify --gc --cleanDestinationDir
```

### Image Optimization

Use Hugo's image processing:

```markdown
{{< image src="image.jpg" alt="Description" width="800" height="600" >}}
```

### Caching

Enable browser caching in your hosting provider or CDN.

## Troubleshooting

### Common Issues

1. **Theme not loading**:
   ```bash
   git submodule update --init --recursive
   ```

2. **Build errors**:
   ```bash
   hugo --verbose
   ```

3. **Missing content**:
   - Check file permissions
   - Verify front matter syntax
   - Check Hugo version compatibility

### Debug Mode

```bash
hugo server --verbose --log
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: [Hugo Docs](https://gohugo.io/documentation/)
- **Theme Docs**: [PaperMod](https://github.com/adityatelange/hugo-PaperMod)
- **Issues**: Create an issue on GitHub

---

Built with ❤️ using [Hugo](https://gohugo.io/) and [PaperMod](https://github.com/adityatelange/hugo-PaperMod) 