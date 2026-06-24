#!/bin/bash
# Run this after logging into GitHub as wkarpolitics (see docs/README.md)
set -e
cd "$(dirname "$0")"

echo "→ Pushing to wkarpolitics/election2026wkar ..."
git push -u origin main --force

echo "→ Enabling GitHub Pages (main branch, root) ..."
gh api repos/wkarpolitics/election2026wkar/pages -X POST \
  -f "build_type=legacy" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || \
gh api repos/wkarpolitics/election2026wkar/pages -X PUT \
  -f "build_type=legacy" \
  -f "source[branch]=main" \
  -f "source[path]=/"

echo ""
echo "Done! Site will be live in 1–3 minutes at:"
echo "  https://wkarpolitics.github.io/election2026wkar/"
echo "  https://wkarpolitics.github.io/election2026wkar/index.html"