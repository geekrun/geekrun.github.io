# Deployment Guide

This guide provides step-by-step instructions for deploying your Hugo blog to Vercel (recommended) or GitHub Pages.

## Option 1: Vercel Deployment (Recommended)

### Step 1: Prepare Your Repository

1. **Initialize Git and push to GitHub**:
   ```bash
   cd geekrun-hugo
   git add .
   git commit -m "Initial Hugo blog setup"
   git branch -M main
   git remote add origin https://github.com/yourusername/geekrun-hugo.git
   git push -u origin main
   ```

2. **Update your GitHub repository settings**:
   - Go to your repository on GitHub
   - Update the repository description
   - Add topics: `hugo`, `blog`, `static-site`

### Step 2: Connect to Vercel

1. **Sign up/Login to Vercel**:
   - Go to [vercel.com](https://vercel.com)
   - Sign up with your GitHub account

2. **Import your repository**:
   - Click "New Project"
   - Import your GitHub repository
   - Select the repository: `yourusername/geekrun-hugo`

3. **Configure build settings**:
   - **Framework Preset**: Hugo
   - **Build Command**: `hugo --minify`
   - **Output Directory**: `public`
   - **Install Command**: Leave empty
   - **Root Directory**: Leave empty (or `./` if needed)

4. **Environment Variables** (optional):
   - `HUGO_VERSION`: `0.148.2` (or your Hugo version)
   - `HUGO_ENV`: `production`

5. **Deploy**:
   - Click "Deploy"
   - Vercel will automatically build and deploy your site

### Step 3: Custom Domain (Optional)

1. **Add custom domain**:
   - Go to your project settings in Vercel
   - Navigate to "Domains"
   - Add your custom domain (e.g., `blog.yourdomain.com`)

2. **Update DNS**:
   - Add a CNAME record pointing to your Vercel domain
   - Or use Vercel's automatic DNS configuration

### Step 4: Update Configuration

After deployment, update your `hugo.toml`:

```toml
baseURL = 'https://your-vercel-domain.vercel.app/'
# or your custom domain
# baseURL = 'https://blog.yourdomain.com/'
```

## Option 2: GitHub Pages Deployment

### Step 1: Enable GitHub Pages

1. **Go to repository settings**:
   - Navigate to your repository on GitHub
   - Go to Settings > Pages

2. **Configure Pages**:
   - **Source**: Deploy from a branch
   - **Branch**: `main`
   - **Folder**: `/ (root)`
   - Click "Save"

### Step 2: Update GitHub Actions

The workflow file `.github/workflows/hugo.yml` is already configured. It will:

1. Install Hugo on GitHub Actions
2. Build your site with optimizations
3. Deploy to GitHub Pages automatically

### Step 3: Update Configuration

Update your `hugo.toml`:

```toml
baseURL = 'https://yourusername.github.io/geekrun-hugo/'
```

## Post-Deployment Steps

### 1. Test Your Site

- Visit your deployed site
- Test all features:
  - Navigation menu
  - Search functionality
  - Encrypted content (password: `secret123`)
  - Code highlighting
  - Mobile responsiveness

### 2. Update Content

1. **Add your own posts**:
   ```bash
   hugo new posts/my-first-post.md
   ```

2. **Update personal information**:
   - Edit `content/about/_index.md`
   - Update social links in `hugo.toml`
   - Add your avatar image to `static/images/avatar.jpg`

3. **Customize the theme**:
   - Modify colors in `hugo.toml`
   - Add custom CSS in `assets/css/custom.css`
   - Add custom JavaScript in `static/js/custom.js`

### 3. SEO Optimization

1. **Add meta tags**:
   - Update description in `hugo.toml`
   - Add Open Graph tags
   - Configure Twitter Cards

2. **Submit to search engines**:
   - Submit your sitemap to Google Search Console
   - Submit to Bing Webmaster Tools

### 4. Analytics (Optional)

1. **Google Analytics**:
   - Add your GA4 tracking ID to `hugo.toml`
   - Configure privacy settings

2. **Alternative analytics**:
   - Plausible Analytics
   - Fathom Analytics
   - Simple Analytics

## Continuous Deployment

### Automatic Updates

Both Vercel and GitHub Pages will automatically redeploy when you:

1. **Push changes to GitHub**:
   ```bash
   git add .
   git commit -m "Update blog content"
   git push origin main
   ```

2. **Create new posts**:
   ```bash
   hugo new posts/new-post.md
   # Edit the post
   git add .
   git commit -m "Add new post"
   git push origin main
   ```

### Local Development

1. **Start development server**:
   ```bash
   hugo server -D
   ```

2. **Preview changes**:
   - Visit http://localhost:1313
   - Changes are reflected in real-time

3. **Build for production**:
   ```bash
   hugo --minify
   ```

## Troubleshooting

### Common Issues

1. **Build fails on Vercel**:
   - Check Hugo version compatibility
   - Verify theme submodule is included
   - Check for syntax errors in `hugo.toml`

2. **Theme not loading**:
   ```bash
   git submodule update --init --recursive
   ```

3. **Missing content**:
   - Verify front matter syntax
   - Check file permissions
   - Ensure files are in correct directories

4. **Encryption not working**:
   - Check JavaScript console for errors
   - Verify `static/js/encrypt.js` is loaded
   - Test with correct password

### Performance Optimization

1. **Enable compression**:
   - Vercel: Automatic
   - GitHub Pages: Add to `.github/workflows/hugo.yml`

2. **Optimize images**:
   - Use WebP format
   - Compress images before uploading
   - Use Hugo's image processing

3. **Minify assets**:
   ```bash
   hugo --minify
   ```

## Security Considerations

### For Encrypted Content

1. **Use strong passwords**:
   - Avoid common passwords
   - Use unique passwords for each post
   - Consider using a password manager

2. **Client-side limitations**:
   - Remember that encryption is client-side
   - Content is visible in HTML source
   - Use for low-security content only

3. **Alternative for high-security**:
   - Consider server-side authentication
   - Use external password-protected services
   - Implement proper authentication systems

## Monitoring and Maintenance

### Regular Tasks

1. **Update Hugo**:
   ```bash
   brew upgrade hugo  # macOS
   ```

2. **Update theme**:
   ```bash
   git submodule update --remote themes/PaperMod
   ```

3. **Backup content**:
   - Regular Git commits
   - Consider external backups
   - Export content periodically

### Performance Monitoring

1. **Page speed**:
   - Use Google PageSpeed Insights
   - Monitor Core Web Vitals
   - Optimize based on results

2. **Uptime monitoring**:
   - Set up uptime monitoring
   - Configure alerts for downtime
   - Monitor error rates

## Next Steps

1. **Add more content**:
   - Write regular blog posts
   - Add project pages
   - Create tutorials

2. **Enhance features**:
   - Add comments system
   - Implement newsletter signup
   - Add social sharing buttons

3. **Customize design**:
   - Modify theme colors
   - Add custom fonts
   - Create custom layouts

4. **SEO improvements**:
   - Add structured data
   - Optimize for keywords
   - Create internal linking strategy

---

Your Hugo blog is now ready for production! 🚀 