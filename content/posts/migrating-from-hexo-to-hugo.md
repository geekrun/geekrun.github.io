---
title: "Migrating from Hexo to Hugo: A Complete Guide"
date: 2024-08-06
draft: false
description: "A comprehensive guide to migrating your blog from Hexo to Hugo with modern features and deployment"
tags: ["hugo", "hexo", "migration", "blogging", "static-site"]
categories: ["tutorials", "development"]
toc: true
readingTime: true
---

# Migrating from Hexo to Hugo: A Complete Guide

After using Hexo for several years, I decided to migrate to Hugo for better performance and more modern features. Here's my complete migration guide.

## Why Hugo?

Hugo offers several advantages over Hexo:

- **Faster build times**: Hugo is written in Go and builds sites incredibly fast
- **Better performance**: Generated sites are more optimized
- **Rich ecosystem**: Excellent themes and plugins
- **Active development**: Regular updates and improvements

## Migration Steps

### 1. Install Hugo

```bash
# macOS
brew install hugo

# Windows
choco install hugo

# Linux
sudo apt-get install hugo
```

### 2. Create New Hugo Site

```bash
hugo new site my-blog
cd my-blog
```

### 3. Install Theme

I chose PaperMod for its clean, modern design:

```bash
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
```

### 4. Configure Hugo

The configuration is straightforward in TOML format:

```toml
baseURL = 'https://yourdomain.com/'
languageCode = 'en-us'
title = 'Your Blog'
theme = 'PaperMod'

[params]
  description = "Your blog description"
  author = "Your Name"
  ShowReadingTime = true
  ShowCodeCopyButtons = true
```

## Content Migration

### Directory Structure

Hugo uses a simple content structure:

```
content/
├── posts/          # Public posts
├── private/        # Private/encrypted posts
└── about/
    └── _index.md   # About page
```

### Front Matter

Hugo front matter is similar to Hexo but more flexible:

```yaml
---
title: "Post Title"
date: 2024-08-06
draft: false
tags: ["tag1", "tag2"]
categories: ["category1"]
toc: true
readingTime: true
---
```

## Advanced Features

### Code Highlighting

Hugo has excellent built-in syntax highlighting:

```toml
[markup]
  [markup.highlight]
    style = "dracula"
    lineNos = true
    lineNumbersInTable = true
```

### Search Functionality

PaperMod includes Fuse.js for client-side search:

```toml
[params.fuseOpts]
  isCaseSensitive = false
  shouldSort = true
  keys = ["title", "permalink", "summary", "content"]
```

## Deployment

### Vercel Deployment

1. **Connect GitHub Repository**:
   - Push your Hugo site to GitHub
   - Connect the repository to Vercel

2. **Configure Build Settings**:
   - Build Command: `hugo --minify`
   - Output Directory: `public`
   - Install Command: `npm install` (if using npm packages)

3. **Environment Variables** (if needed):
   - `HUGO_VERSION`: Set to your Hugo version
   - `HUGO_ENV`: Set to `production`

### GitHub Pages Alternative

For GitHub Pages deployment:

```bash
# Create a GitHub Action
mkdir -p .github/workflows
```

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

## Private/Encrypted Posts

For sensitive content, I implemented a simple password protection system:

### 1. Create Encryption Shortcode

Create `layouts/shortcodes/encrypt.html`:

```html
{{ if .IsPage }}
<div class="encrypted-content" data-password="{{ .Get 0 }}">
  <div class="encrypt-form">
    <input type="password" placeholder="Enter password" class="encrypt-input">
    <button class="encrypt-button">Decrypt</button>
  </div>
  <div class="encrypted-text" style="display: none;">
    {{ .Inner | markdownify }}
  </div>
</div>
{{ end }}
```

### 2. Add JavaScript

Create `static/js/encrypt.js`:

```javascript
document.addEventListener('DOMContentLoaded', function() {
  const encryptedContents = document.querySelectorAll('.encrypted-content');
  
  encryptedContents.forEach(content => {
    const password = content.dataset.password;
    const form = content.querySelector('.encrypt-form');
    const input = content.querySelector('.encrypt-input');
    const button = content.querySelector('.encrypt-button');
    const text = content.querySelector('.encrypted-text');
    
    button.addEventListener('click', function() {
      if (input.value === password) {
        form.style.display = 'none';
        text.style.display = 'block';
      } else {
        alert('Incorrect password');
      }
    });
    
    input.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        button.click();
      }
    });
  });
});
```

### 3. Use in Posts

```markdown
{{< encrypt "mysecretpassword" >}}
This content is encrypted and requires a password to view.
{{< /encrypt >}}
```

## Performance Optimization

### 1. Enable Compression

```toml
[server]
  [server.headers]
    for = "/*"
    [server.headers.values]
      X-Content-Type-Options = "nosniff"
      X-Frame-Options = "DENY"
      X-XSS-Protection = "1; mode=block"
```

### 2. Image Optimization

Use Hugo's image processing:

```markdown
{{< image src="image.jpg" alt="Description" width="800" height="600" >}}
```

### 3. Minification

```bash
hugo --minify
```

## Conclusion

The migration from Hexo to Hugo was smooth and rewarding. The improved performance, better developer experience, and modern features make Hugo an excellent choice for static site generation.

**Key Benefits:**
- ⚡ Faster build times
- 🎨 Better themes and customization
- 🔍 Built-in search functionality
- 📱 Better mobile optimization
- 🔒 Easy content encryption
- 🚀 Simple deployment

The migration process took about a day, and the results were well worth the effort. Hugo's simplicity and power make it an excellent choice for modern blogging.

---

*This post was migrated from my old Hexo blog. The new Hugo setup provides a much better experience for both writing and reading.* 