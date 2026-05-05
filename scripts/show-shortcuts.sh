#!/bin/bash
###############################################################################
# Minty-I3 Shortcuts Display Script
# Shows keyboard shortcuts on the left side of the screen
# Similar to Manjaro Sway's Super+Shift+? feature with Windows logo
###############################################################################

# Get screen dimensions
SCREEN_WIDTH=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | cut -d'x' -f1)
SCREEN_HEIGHT=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | cut -d'x' -f2)

# Window size and position (left side like Manjaro Sway)
WINDOW_WIDTH=400
WINDOW_HEIGHT=$((SCREEN_HEIGHT - 100))
POS_X=50
POS_Y=50

# Colors - Linux Mint Dark Theme
BG="#1a1a1a"
FG="#ffffff"
ACCENT="#87cf3e"
BORDER="#87cf3e"

# Create a temporary file for the shortcuts HTML content
SHORTCUTS_HTML=$(mktemp --suffix=.html)

# Windows Logo Unicode
WIN_LOGO="&#x229E;"  # ⊞ Windows logo symbol

# Generate shortcuts HTML content with Windows logo styling
cat > "$SHORTCUTS_HTML" << EOF
<!DOCTYPE html>
<html>
<head>
<style>
body {
    background-color: ${BG};
    color: ${FG};
    font-family: 'Segoe UI', sans-serif;
    font-size: 13px;
    margin: 20px;
    padding: 0;
}
h1 {
    color: ${ACCENT};
    font-size: 18px;
    margin-bottom: 20px;
    border-bottom: 2px solid ${ACCENT};
    padding-bottom: 10px;
}
h2 {
    color: ${ACCENT};
    font-size: 14px;
    margin-top: 20px;
    margin-bottom: 10px;
}
.shortcut {
    margin: 8px 0;
    display: flex;
    justify-content: space-between;
}
.key {
    color: ${ACCENT};
    font-weight: bold;
    min-width: 180px;
}
.action {
    color: ${FG};
    text-align: right;
}
.logo {
    font-size: 24px;
    color: ${ACCENT};
    margin-bottom: 10px;
}
hr {
    border: none;
    border-top: 1px solid ${ACCENT};
    margin: 15px 0;
    opacity: 0.3;
}
</style>
</head>
<body>
<div class="logo">${WIN_LOGO} Minty-I3</div>
<h1>Keyboard Shortcuts</h1>

<h2>System</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+?</span><span class="action">Show this help</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+F1</span><span class="action">Show this help</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+e</span><span class="action">Exit i3</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+r</span><span class="action">Restart i3</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+c</span><span class="action">Reload config</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+s</span><span class="action">Suspend</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+l</span><span class="action">Lock screen</span></div>

<hr>

<h2>Windows</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+Return</span><span class="action">Open terminal</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+Return</span><span class="action">Drop-down terminal</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+q</span><span class="action">Close window</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+d</span><span class="action">Application launcher</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+f</span><span class="action">Fullscreen</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+Space</span><span class="action">Toggle floating</span></div>

<hr>

<h2>Navigation</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+Arrow / h,j,k,l</span><span class="action">Focus window</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+Arrow</span><span class="action">Move window</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+a</span><span class="action">Focus parent</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+c</span><span class="action">Focus child</span></div>

<hr>

<h2>Layout</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+b</span><span class="action">Split horizontal</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+v</span><span class="action">Split vertical</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+s</span><span class="action">Stacking layout</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+w</span><span class="action">Tabbed layout</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+e</span><span class="action">Toggle split</span></div>

<hr>

<h2>Workspaces</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+1-10</span><span class="action">Switch workspace</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+1-10</span><span class="action">Move to workspace</span></div>

<hr>

<h2>Scratchpad</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+-</span><span class="action">Move to scratchpad</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+-</span><span class="action">Show scratchpad</span></div>

<hr>

<h2>Resize</h2>
<div class="shortcut"><span class="key">${WIN_LOGO}+r</span><span class="action">Resize mode</span></div>
<div class="shortcut"><span class="key">Arrow keys</span><span class="action">Resize window</span></div>

<hr>

<h2>Screenshots</h2>
<div class="shortcut"><span class="key">Print</span><span class="action">Full screenshot</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Print</span><span class="action">Window screenshot</span></div>
<div class="shortcut"><span class="key">${WIN_LOGO}+Shift+Print</span><span class="action">Area screenshot</span></div>

<hr>

<div style="text-align: center; color: #888888; font-size: 12px; margin-top: 20px;">
    Press Escape or click anywhere to close
</div>

</body>
</html>
EOF

# Check if we have a suitable browser for displaying HTML
if command -v zenity &> /dev/null; then
    # Use zenity with HTML support for better styling
    zenity --html --filename="$SHORTCUTS_HTML" \
        --title="Minty-I3 Shortcuts" \
        --width=$WINDOW_WIDTH \
        --height=$WINDOW_HEIGHT &
    ZENITY_PID=$!
    
    # Wait for window to appear and position it on the left
    sleep 0.5
    WINDOW_ID=$(xdotool search --class "zenity" | tail -1)
    if [ -n "$WINDOW_ID" ]; then
        xdotool windowmove "$WINDOW_ID" "$POS_X" "$POS_Y"
    fi
    
    # Auto-close after 30 seconds
    (sleep 30 && kill $ZENITY_PID 2>/dev/null) &
    
    # Wait for user to close or timeout
    wait $ZENITY_PID 2>/dev/null
    
elif command -v yad &> /dev/null; then
    # Fallback to yad text display positioned on left
    # Convert HTML to plain text for yad
    SHORTCUTS_TXT=$(mktemp)
    sed 's/<[^>]*>//g' "$SHORTCUTS_HTML" | sed 's/&#[xX][0-9a-fA-F]*;/⊞/g' > "$SHORTCUTS_TXT"
    
    yad --text-info --filename="$SHORTCUTS_TXT" \
        --title="Minty-I3 Shortcuts" \
        --width=$WINDOW_WIDTH \
        --height=$WINDOW_HEIGHT \
        --posx=$POS_X --posy=$POS_Y \
        --no-buttons \
        --borders=20 \
        --back="$BG" \
        --fore="$FG" \
        --fontname="Segoe UI 11" \
        --timeout=30 \
        --timeout-indicator=bottom &
        
    rm -f "$SHORTCUTS_TXT"
else
    # Final fallback: display in browser
    if command -v firefox &> /dev/null; then
        firefox --new-window "file://$SHORTCUTS_HTML" &
        sleep 1
        WINDOW_ID=$(xdotool search --class "firefox" | tail -1)
        if [ -n "$WINDOW_ID" ]; then
            xdotool windowmove "$WINDOW_ID" "$POS_X" "$POS_Y"
            xdotool windowsize "$WINDOW_ID" "$WINDOW_WIDTH" "$WINDOW_HEIGHT"
        fi
        # Auto-close after 30 seconds
        (sleep 30 && kill $(pgrep -f "firefox.*$SHORTCUTS_HTML") 2>/dev/null) &
    elif command -v chromium &> /dev/null; then
        chromium --app="file://$SHORTCUTS_HTML" --window-size=$WINDOW_WIDTH,$WINDOW_HEIGHT --window-position=$POS_X,$POS_Y &
        (sleep 30 && kill $(pgrep -f "chromium.*$SHORTCUTS_HTML") 2>/dev/null) &
    else
        # Last resort: terminal
        xfce4-terminal --title="Minty-I3 Shortcuts (⊞ = Windows Key)" --geometry=50x35 --hold -e "cat $SHORTCUTS_HTML | sed 's/<[^>]*>//g' | sed 's/&#x229E;/[WIN]/g'"
    fi
fi

# Clean up
rm -f "$SHORTCUTS_HTML"
