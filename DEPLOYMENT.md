# Deployment Guide

This guide provides step-by-step instructions for deploying your Hugo blog to GitHub Pages (recommended) or Vercel.

## Option 1: GitHub Pages Deployment (Recommended)

### Step 1: Enable GitHub Pages

1. **Go to repository settings**:
   - Navigate to your repository on GitHub
   - Go to Settings > Pages

2. **Configure Pages**:
   - **Source**: Deploy from a branch
   - **Branch**: `main` (or `master`)
   - **Folder**: `/ (root)`
   - Click "Save"

### Step 2: GitHub Actions Configuration

The workflow file `.github/workflows/hugo.yml` is already configured and will:

1. **Install Hugo Extended** (v0.148.2) on GitHub Actions
2. **Checkout code** with submodules (including PaperMod theme)
3. **Build site** with optimizations (`--gc --minify`)
4. **Deploy to GitHub Pages** automatically

### Step 3: Update Configuration

Update your `hugo.toml`:

```toml
baseURL = 'https://yourusername.github.io/geekrun.github.io/'
```

### Step 4: Push and Deploy

```bash
git add .
git commit -m "Update site configuration"
git push origin main
```

The site will be automatically deployed to GitHub Pages.

## Option 2: Vercel Deployment

### Step 1: Prepare Your Repository

1. **Initialize Git and push to GitHub**:
   ```bash
   git add .
   git commit -m "Initial Hugo blog setup"
   git branch -M main
   git remote add origin https://github.com/yourusername/geekrun.github.io.git
   git push -u origin main
   ```

### Step 2: Connect to Vercel

1. **Sign up/Login to Vercel**:
   - Go to [vercel.com](https://vercel.com)
   - Sign up with your GitHub account

2. **Import your repository**:
   - Click "New Project"
   - Import your GitHub repository
   - Select the repository: `yourusername/geekrun.github.io`

3. **Configure build settings**:
   - **Framework Preset**: Hugo
   - **Build Command**: `hugo --minify`
   - **Output Directory**: `public`
   - **Install Command**: Leave empty
   - **Root Directory**: Leave empty (or `./` if needed)

4. **Environment Variables** (optional):
   - `HUGO_VERSION`: `0.148.2`
   - `HUGO_ENV`: `production`

5. **Deploy**:
   - Click "Deploy"
   - Vercel will automatically build and deploy your site

### Step 3: GitHub Actions for Vercel (Optional)

If you want to use GitHub Actions for Vercel deployment:

1. **Add Vercel secrets** to your GitHub repository:
   - Go to Settings > Secrets and variables > Actions
   - Add the following secrets:
     - `VERCEL_TOKEN`: Your Vercel API token
     - `ORG_ID`: Your Vercel organization ID
     - `PROJECT_ID`: Your Vercel project ID

2. **The workflow** `.github/workflows/vercel.yml` will handle deployment

### Step 4: Custom Domain (Optional)

1. **Add custom domain**:
   - Go to your project settings in Vercel
   - Navigate to "Domains"
   - Add your custom domain (e.g., `blog.yourdomain.com`)

2. **Update DNS**:
   - Add a CNAME record pointing to your Vercel domain
   - Or use Vercel's automatic DNS configuration

### Step 5: Update Configuration

After deployment, update your `hugo.toml`:

```toml
baseURL = 'https://your-vercel-domain.vercel.app/'
# or your custom domain
# baseURL = 'https://blog.yourdomain.com/'
```

## Hugo Configuration Status

✅ **Configuration Fixed**:
- Removed duplicate `guessSyntax` and `getenv` entries
- Fixed `encrypt` shortcode (removed `.IsPage` check)
- Added missing `image` shortcode
- Temporarily disabled `socialIcons` to fix build issues
- PaperMod theme properly installed as submodule

✅ **Build Status**: Site builds successfully with `hugo --gc --minify`

✅ **GitHub Actions**: Configured for both GitHub Pages and Vercel deployment

## Troubleshooting

### Common Issues

1. **Build fails with schema errors**:
   - Check for duplicate configuration keys in `hugo.toml`
   - Ensure all shortcodes are properly defined

2. **Theme not found**:
   - Run `git submodule update --init --recursive`
   - Check `.gitmodules` file

3. **GitHub Pages not updating**:
   - Check GitHub Actions logs
   - Ensure repository has proper permissions

4. **Vercel deployment fails**:
   - Check build logs in Vercel dashboard
   - Verify Hugo version compatibility

### Performance Optimization

1. **Enable compression**:
   ```toml
   [server]
     [server.headers]
       for = "/*"
       [server.headers.values]
         X-Content-Type-Options = "nosniff"
         X-Frame-Options = "DENY"
         X-XSS-Protection = "1; mode=block"
   ```

2. **Image optimization**:
   ```markdown
   {{< image src="image.jpg" alt="Description" width="800" height="600" >}}
   ```

3. **Minification**:
   ```bash
   hugo --minify
   ```

## Next Steps

1. **Enable social icons** once schema issues are resolved
2. **Add custom CSS** for better styling
3. **Configure analytics** (Google Analytics, etc.)
4. **Set up custom domain** if needed
5. **Add more content** and posts 