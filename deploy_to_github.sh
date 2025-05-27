#!/bin/bash
# GitHub Deployment Script for macOS Performance Suite
# This script will help you push your project to GitHub

echo "🚀 GitHub Deployment for macOS Performance Suite"
echo "==============================================="

# Configuration
REPO_URL="https://github.com/iezzat001/macos-performance-suite.git"
PROJECT_DIR="/Users/iEzzat/Desktop/Organized/Maintenance_Scripts"

echo "📁 Project Directory: $PROJECT_DIR"
echo "🌍 Repository URL: $REPO_URL"
echo ""

# Navigate to project directory
cd "$PROJECT_DIR" || {
    echo "❌ Error: Cannot access project directory"
    exit 1
}

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first:"
    echo "   brew install git"
    exit 1
fi

# Initialize git repository if not already done
if [ ! -d ".git" ]; then
    echo "🔧 Initializing Git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Configure git user (if not already configured)
if [ -z "$(git config user.name)" ]; then
    echo "⚙️ Git user not configured. Please set up:"
    echo "   git config --global user.name 'Your Name'"
    echo "   git config --global user.email 'your.email@example.com'"
    echo ""
    read -p "Enter your name: " USER_NAME
    read -p "Enter your email: " USER_EMAIL
    
    git config user.name "$USER_NAME"
    git config user.email "$USER_EMAIL"
    echo "✅ Git user configured for this repository"
fi

# Add all files
echo "📦 Adding all files to git..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "⚠️ No changes to commit"
else
    # Create commit
    echo "💾 Creating commit..."
    git commit -m "Initial release: macOS Performance Optimization Suite

- Complete suite of macOS optimization scripts
- Comprehensive system cleaning and maintenance tools
- Browser memory optimization
- Automated performance monitoring and reporting
- Screenshot management and compression
- Application residue cleanup
- Privacy-protected with comprehensive .gitignore
- Professional documentation and setup scripts
- MIT licensed for open source sharing

Features:
- Deep system cleaning with backup safety
- Performance tracking and health scoring
- Automated maintenance reminders
- Browser process optimization
- Language file cleanup (saves GB of space)
- Safe operation with rollback capabilities
- Easy installation and configuration"

    echo "✅ Commit created successfully"
fi

# Add remote origin if not already added
if ! git remote get-url origin &>/dev/null; then
    echo "🔗 Adding remote repository..."
    git remote add origin "$REPO_URL"
    echo "✅ Remote origin added"
else
    echo "✅ Remote origin already configured"
fi

# Display next steps
echo ""
echo "🚀 Ready to Push to GitHub!"
echo "=========================="
echo ""
echo "To complete the deployment, run these commands:"
echo ""
echo "1. Push to GitHub:"
echo "   git push -u origin main"
echo ""
echo "2. If you get an authentication error, you may need to:"
echo "   - Use GitHub CLI: gh auth login"
echo "   - Or use personal access token instead of password"
echo "   - Or set up SSH keys for GitHub"
echo ""
echo "3. Alternative - Push with GitHub CLI (if installed):"
echo "   gh repo create macos-performance-suite --public --source=. --push"
echo ""
echo "📋 Repository Information:"
echo "   Name: macos-performance-suite"
echo "   URL: $REPO_URL"
echo "   Branch: main"
echo "   Files ready: $(git ls-files | wc -l) files"
echo ""
echo "🎉 Your project is ready for the world to see!"

# Show git status
echo ""
echo "📊 Current Git Status:"
git status --short

echo ""
echo "💡 Pro Tips:"
echo "- Add repository topics: macos, performance, optimization, bash"
echo "- Enable GitHub Pages if you want a project website"
echo "- Consider adding GitHub Actions for automated testing"
echo "- Star your own repo to show it's production-ready! ⭐"