#!/bin/bash
###############################################################################
# Helper script to upload Minty-I3 to GitHub
# Usage: ./upload-to-github.sh YOUR_GITHUB_USERNAME
###############################################################################

if [ -z "$1" ]; then
    echo "Usage: ./upload-to-github.sh YOUR_GITHUB_USERNAME"
    echo "Example: ./upload-to-github.sh johndoe"
    exit 1
fi

USERNAME="$1"
REPO_URL="https://github.com/$USERNAME/minty-i3-desktop.git"

echo "========================================"
echo "  Minty-I3 GitHub Uploader"
echo "========================================"
echo ""
echo "This will upload Minty-I3 to: $REPO_URL"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    echo "Install with: sudo apt install git"
    exit 1
fi

# Update YOURUSERNAME in files
echo "Step 1: Updating YOURUSERNAME to $USERNAME in files..."
sed -i "s/YOURUSERNAME/$USERNAME/g" install.sh
sed -i "s/YOURUSERNAME/$USERNAME/g" README.md
echo "✓ Files updated"
echo ""

# Initialize git if needed
if [ ! -d .git ]; then
    echo "Step 2: Initializing git repository..."
    git init
    git branch -M main
    echo "✓ Git initialized"
else
    echo "Step 2: Git already initialized"
fi
echo ""

# Add remote
echo "Step 3: Adding remote origin..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"
echo "✓ Remote added: $REPO_URL"
echo ""

# Add all files
echo "Step 4: Adding files to git..."
git add -A
echo "✓ Files added"
echo ""

# Commit
echo "Step 5: Committing changes..."
git commit -m "Initial release: Minty-I3 with one-line installer" || echo "Nothing new to commit"
echo "✓ Committed"
echo ""

# Push
echo "Step 6: Pushing to GitHub..."
echo "You may need to enter your GitHub credentials..."
git push -u origin main --force
echo "✓ Pushed to GitHub"
echo ""

echo "========================================"
echo "  Upload Complete!"
echo "========================================"
echo ""
echo "Your project is now at:"
echo "  $REPO_URL"
echo ""
echo "Users can install with:"
echo "  curl -sSL https://raw.githubusercontent.com/$USERNAME/minty-i3-desktop/main/install.sh | sudo bash"
echo ""
echo "Don't forget to:"
echo "  1. Add a screenshot to your README"
echo "  2. Create a release on GitHub"
echo "  3. Share your project!"
echo ""
