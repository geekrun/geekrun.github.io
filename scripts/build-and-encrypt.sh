#!/bin/bash

# Build and encrypt script for Hugo blog with encryption
# This script builds the Hugo site and applies encryption to protected content

set -e

echo "🚀 Starting Hugo build and encryption process..."

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf public/

# Initialize Hugo modules
echo "📦 Initializing Hugo modules..."
hugo mod init github.com/geekrun/geekrun.github.io || true
hugo mod get github.com/hugomods/encrypt

# Build the Hugo site
echo "🔨 Building Hugo site..."
hugo --gc --minify

# Check if encrypt command exists
if ! command -v encrypt &> /dev/null; then
    echo "📥 Installing Hugo encryptor..."
    go install github.com/hugomods/encrypt/commands/encrypt@latest
fi

# Apply encryption
echo "🔐 Applying encryption to protected content..."
$HOME/go/bin/encrypt

echo "✅ Build and encryption completed successfully!"
echo "💡 You can now serve the site using: python -m http.server -d public 8080"
echo "🌐 Or test locally with: hugo server --disableFastRender"
