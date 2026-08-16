#!/usr/bin/env bash
# ============================================================
#  application_setup.sh
#  Creates Vivaldi --app desktop entries for web apps,
#  downloads icons, and disables KWallet.
# ============================================================

set -euo pipefail

APPS_DIR="$HOME/.local/share/applications"
ICONS_DIR="$HOME/.local/share/icons/webapps"
BRAVE_FLAGS="--password-store=basic"

mkdir -p "$APPS_DIR" "$ICONS_DIR"

# ── Colour helpers ───────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓ $*${NC}"; }
warn() { echo -e "${YELLOW}  ⚠ $*${NC}"; }
err()  { echo -e "${RED}  ✗ $*${NC}"; }

# ── App definitions ──────────────────────────────────────────
# Format: "Name|URL|IconName|Categories"
declare -a WEBAPPS=(
  "YouTube Music|https://music.youtube.com|youtube-music|Audio;Music;"
  "WhatsApp|https://web.whatsapp.com|whatsapp|Network;InstantMessaging;"
  "ChatGPT|https://chatgpt.com|chatgpt|Utility;Education;"
  "Gmail|https://mail.google.com|gmail|Network;Email;"
#  "Google Calendar|https://calendar.google.com|google-calendar|Office;"
#  "Notion|https://notion.so|notion|Office;ProjectManagement;"
#  "GitHub|https://github.com|github|Development;"
  "Figma|https://figma.com|figma|Graphics;Design;"
#  "Discord|https://discord.com/app|discord|Network;InstantMessaging;"
#  "Spotify|https://open.spotify.com|spotify|Audio;Music;"
#  "Linear|https://linear.app|linear|Office;ProjectManagement;"
)

# ── Icon fetch ───────────────────────────────────────────────
fetch_icon() {
  local name="$1" url="$2" slug="$3"
  local icon_path="$ICONS_DIR/${slug}.png"

  # Skip if already downloaded
  [[ -f "$icon_path" ]] && { echo "$icon_path"; return; }

  # Try Google favicon service (high-res)
  local domain favicon_url
  domain=$(echo "$url" | sed 's|https\?://||;s|/.*||')
  favicon_url="https://www.google.com/s2/favicons?domain=${domain}&sz=128"

  if command -v curl &>/dev/null; then
    curl -fsSL "$favicon_url" -o "$icon_path" 2>/dev/null && { echo "$icon_path"; return; }
  elif command -v wget &>/dev/null; then
    wget -qO "$icon_path" "$favicon_url" 2>/dev/null && { echo "$icon_path"; return; }
  fi

  echo "$slug"  # Fall back to icon name
}

# ── Create desktop entry ─────────────────────────────────────
create_entry() {
  local name="$1" url="$2" icon_slug="$3" categories="$4"

  # Sanitise slug for filenames
  local slug
  slug=$(echo "$name" | tr '[:upper:] ' '[:lower:]-' | tr -cd '[:alnum:]-')

  local icon
  icon=$(fetch_icon "$name" "$url" "$icon_slug")

  local entry_path="$APPS_DIR/${slug}.desktop"

  if [[ -f "$entry_path" ]]; then
    warn "Already exists, skipping: ${slug}.desktop"
    return
  fi

  cat > "$entry_path" <<EOF
[Desktop Entry]
Name=${name}
Exec=brave ${BRAVE_FLAGS} --app=${url} %U
Icon=${icon}
Type=Application
Categories=${categories}
StartupNotify=true
StartupWMClass=brave-${slug}
EOF

  ok "Created: ${slug}.desktop"
}

# ── Main ─────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Web App Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

for app in "${WEBAPPS[@]}"; do
  IFS='|' read -r name url icon_slug categories <<< "$app"
  create_entry "$name" "$url" "$icon_slug" "$categories"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Updating desktop database"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
update-desktop-database "$APPS_DIR" && ok "Desktop database updated."

echo ""
ok "All done!"
echo ""
