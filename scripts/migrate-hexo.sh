#!/bin/bash

# Hexo to Hugo Migration Script
# This script helps migrate content from Hexo to Hugo

set -e

echo "🚀 Starting Hexo to Hugo migration..."

# Check if source directory exists
if [ ! -d "../geekrun.github.io" ]; then
    echo "❌ Source directory not found. Please run this script from the geekrun-hugo directory."
    exit 1
fi

SOURCE_DIR="../geekrun.github.io"
TARGET_DIR="content"

echo "📁 Source directory: $SOURCE_DIR"
echo "📁 Target directory: $TARGET_DIR"

# Create backup
echo "💾 Creating backup..."
cp -r "$TARGET_DIR" "${TARGET_DIR}_backup_$(date +%Y%m%d_%H%M%S)"

# Function to convert Hexo front matter to Hugo
convert_front_matter() {
    local file="$1"
    local temp_file=$(mktemp)
    
    # Convert Hexo front matter to Hugo format
    sed -E '
        # Convert title
        s/^title:\s*(.*)$/title = "\1"/
        # Convert date
        s/^date:\s*(.*)$/date = "\1"/
        # Convert tags (convert array format)
        s/^tags:\s*\[(.*)\]$/tags = [\1]/
        # Convert categories
        s/^categories:\s*\[(.*)\]$/categories = [\1]/
        # Convert description
        s/^description:\s*(.*)$/description = "\1"/
        # Convert draft status
        s/^draft:\s*(true|false)$/draft = \1/
        # Add toc and readingTime
        /^---$/a\
toc = true\
readingTime = true
    ' "$file" > "$temp_file"
    
    mv "$temp_file" "$file"
}

# Function to process markdown files
process_markdown_files() {
    local source_dir="$1"
    local target_dir="$2"
    
    find "$source_dir" -name "*.md" -o -name "*.markdown" | while read -r file; do
        # Get relative path
        rel_path="${file#$source_dir/}"
        
        # Create target directory
        target_file="$target_dir/$rel_path"
        target_file_dir=$(dirname "$target_file")
        mkdir -p "$target_file_dir"
        
        echo "📝 Processing: $rel_path"
        
        # Copy file
        cp "$file" "$target_file"
        
        # Convert front matter
        convert_front_matter "$target_file"
        
        # Update internal links (basic conversion)
        sed -i 's/\[.*\](\/.*\/.*\/)/[{{< ref "$1" >}}]/g' "$target_file"
        
        echo "✅ Converted: $target_file"
    done
}

# Function to copy static assets
copy_static_assets() {
    local source_dir="$1"
    local target_dir="$2"
    
    echo "📁 Copying static assets..."
    
    # Copy images
    if [ -d "$source_dir/images" ]; then
        cp -r "$source_dir/images" "$target_dir/static/"
        echo "✅ Copied images"
    fi
    
    # Copy other static files
    if [ -d "$source_dir/css" ]; then
        cp -r "$source_dir/css" "$target_dir/static/"
        echo "✅ Copied CSS files"
    fi
    
    if [ -d "$source_dir/js" ]; then
        cp -r "$source_dir/js" "$target_dir/static/"
        echo "✅ Copied JavaScript files"
    fi
}

# Main migration process
echo "🔄 Starting migration..."

# Process markdown files
if [ -d "$SOURCE_DIR/source/_posts" ]; then
    echo "📝 Processing posts..."
    process_markdown_files "$SOURCE_DIR/source/_posts" "$TARGET_DIR/posts"
elif [ -d "$SOURCE_DIR/2019" ]; then
    echo "📝 Processing posts from 2019 directory..."
    process_markdown_files "$SOURCE_DIR/2019" "$TARGET_DIR/posts"
else
    echo "⚠️  No posts directory found. Skipping posts migration."
fi

# Copy static assets
copy_static_assets "$SOURCE_DIR" "$TARGET_DIR"

# Create migration report
echo "📊 Creating migration report..."
cat > "migration_report.md" << EOF
# Migration Report

## Migration Summary
- **Source**: Hexo blog
- **Target**: Hugo blog
- **Date**: $(date)

## Files Processed
- Posts: $(find "$TARGET_DIR/posts" -name "*.md" | wc -l | tr -d ' ')
- Static assets: Copied from source

## Next Steps
1. Review converted posts for formatting issues
2. Update internal links manually if needed
3. Test the site locally: \`hugo server -D\`
4. Update configuration in hugo.toml
5. Deploy to your chosen platform

## Notes
- Front matter has been converted to Hugo format
- Internal links may need manual review
- Static assets have been copied to static/ directory
- Backup created in content_backup_$(date +%Y%m%d_%H%M%S)

## Manual Tasks Required
1. Review and fix any broken links
2. Update image paths if needed
3. Test encrypted content functionality
4. Customize theme and styling
5. Update personal information and social links
EOF

echo "✅ Migration completed!"
echo "📋 Review migration_report.md for details"
echo "🚀 Next steps:"
echo "   1. Test locally: hugo server -D"
echo "   2. Review converted content"
echo "   3. Deploy to Vercel or GitHub Pages"
echo "   4. Update configuration and personal info" 