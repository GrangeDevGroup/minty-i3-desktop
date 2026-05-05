# GitHub Setup Guide for Minty-I3

## Quick Summary

**For users to install:**
```bash
curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash
```

**To upload (3 steps):**
1. Create repo on GitHub
2. Update URLs in files (or run helper script)
3. Push to GitHub

---

## Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `minty-i3-desktop`
3. Description: `Linux Mint Dark Theme i3 Window Manager`
4. Set to **Public** (recommended)
5. Check "Add a README file"
6. Click **Create repository**

## Step 2: Update Repository URL in Files

Before uploading, update the URLs:

### Option A: Use the Helper Script (Easiest)

```bash
./upload-to-github.sh YOUR_GITHUB_USERNAME
```

This script automatically:
- Updates all `YOURUSERNAME` placeholders
- Initializes git (if needed)
- Adds remote origin
- Commits and pushes to GitHub

### Option B: Manual Update

Edit these files and replace `YOURUSERNAME`:

#### File: `install.sh` (Line ~12)
```bash
REPO_URL="https://github.com/GrangeDevGroup/minty-i3-desktop.git"
```

#### File: `README.md` (Lines ~11, ~37, ~45)
```bash
curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash
```

```bash
git clone https://github.com/GrangeDevGroup/minty-i3-desktop.git
```

Replace `YOURUSERNAME` with your actual GitHub username (e.g., `johndoe`).

## Step 3: Upload Files to GitHub

### Option A: Using Git Command Line

```bash
# Navigate to your Minty-I3 directory
cd /home/d/CascadeProjects/Minty-I3

# Initialize git (if not already done)
git init

# Add the remote repository
git remote add origin https://github.com/GrangeDevGroup/minty-i3-desktop.git

# Add all files
git add .

# Commit
git commit -m "Initial release: Minty-I3 with one-line installer"

# Push to GitHub
git branch -M main
git push -u origin main
```

### Option B: Using GitHub Web Interface

1. Go to your GitHub repository: `https://github.com/GrangeDevGroup/minty-i3-desktop`
2. Click **"Add file"** → **"Upload files"**
3. Drag and drop all files from `/home/d/CascadeProjects/Minty-I3/`
4. Enter commit message: `Initial release`
5. Click **"Commit changes"**

## Step 4: Verify Installation

Test the one-line installer (on a VM or test system):

```bash
curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash
```

## Step 5: Create Release (Optional but Recommended)

1. Go to your GitHub repo → **Releases** tab → **Create a new release**
2. Tag version: `v1.0.0`
3. Release title: `Minty-I3 v1.0.0 - Initial Release`
4. Description: Copy from README features section
5. Click **Publish release**

## Step 6: Add Badges (Optional)

Badges for your README:

```markdown
![Linux Mint](https://img.shields.io/badge/Linux%20Mint-20%2F21%2F22-green)
![i3wm](https://img.shields.io/badge/i3wm-tiling-blue)
![License](https://img.shields.io/badge/license-MIT-blue)
```

## Directory Structure on GitHub

Your repository should look like this:

```
Minty-I3/
├── .gitignore
├── install.sh          # One-line installer
├── README.md           # Main documentation
├── GITHUB_SETUP.md     # This file (can delete after setup)
├── LICENSE             # MIT License
├── config/
│   ├── i3/
│   │   ├── config
│   │   ├── Xresources
│   │   └── i3status.conf
│   ├── rofi/
│   │   └── windows10.rasi
│   ├── picom.conf
│   └── dunstrc
├── scripts/
│   ├── install.sh      # Main installer
│   ├── uninstall.sh
│   └── show-shortcuts.sh
└── docs/
    ├── KEYBINDINGS.md
    └── CUSTOMIZATION.md
```

## Testing the Installer

Before sharing, test on a fresh Linux Mint VM:

1. Install fresh Linux Mint in VirtualBox/VMware
2. Run the curl command
3. Reboot
4. Verify both session types work
5. Test shortcuts panel with `Super+Shift+?`

## Troubleshooting

### If curl installer fails

Check that `install.sh` has the correct permissions and line endings:

```bash
# Ensure file has proper line endings
dos2unix install.sh

# Make executable
chmod +x install.sh
```

### If files don't show on GitHub

```bash
# Force push if needed
git push origin main --force
```

## Share Your Project

Share this install command:

```
Install Minty-I3 with one command:

curl -sSL https://raw.githubusercontent.com/GrangeDevGroup/minty-i3-desktop/main/install.sh | sudo bash

Features:
- Linux Mint dark theme
- i3 tiling window manager  
- Manjaro Sway-style shortcuts
- Left-side shortcuts panel
- Multi-monitor support
```

## Next Steps

- [ ] Add screenshot to README
- [ ] Share on Reddit r/i3wm, r/linuxmint
- [ ] Add to awesome-i3 list
