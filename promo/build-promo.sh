#!/bin/bash
# WKAR Election 2026 — draft promo assembler
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROMO="$(cd "$(dirname "$0")" && pwd)"
IMG="$ROOT/assets/images"
OUT="$PROMO/output"
WORK="$PROMO/.build"
mkdir -p "$OUT" "$WORK"

VOICE="${WKAR_PROMO_VOICE:-Samantha}"
RATE="${WKAR_PROMO_RATE:-156}"

echo "→ Generating voiceover ($VOICE @ ${RATE}wpm)..."
say -v "$VOICE" -r "$RATE" -o "$WORK/vo.aiff" -f "$PROMO/script-final.txt"
ffmpeg -y -i "$WORK/vo.aiff" -ar 48000 -ac 1 "$WORK/vo.wav" 2>/dev/null
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$WORK/vo.wav")
echo "   VO duration: ${DUR}s"

make_photo_seg() {
  local src="$1" dur="$2" out="$3"
  ffmpeg -y -loop 1 -i "$src" -vf \
    "scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,format=yuv420p,zoompan=z='min(zoom+0.0008,1.08)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30" \
    -t "$dur" -r 30 -pix_fmt yuv420p "$out" 2>/dev/null
}

make_logo_seg() {
  local src="$1" dur="$2" out="$3"
  ffmpeg -y \
    -f lavfi -i "color=c=0xf5f5f7:s=1920x1080:d=${dur}:r=30" \
    -loop 1 -i "$src" \
    -filter_complex "[1]format=rgba,scale=1000:-1[logo];[0][logo]overlay=(W-w)/2:(H-h)/2-40:format=auto" \
    -t "$dur" -r 30 -pix_fmt yuv420p "$out" 2>/dev/null
}

# image|duration|type(photo|logo)
SLIDES=(
  "$IMG/wkar-election-logo-transparent.png|3.2|logo"
  "$IMG/capitol-dome.jpg|4.0|photo"
  "$IMG/lansing-aerial-dusk.jpg|2.5|photo"
  "$IMG/downtown-main-street.jpg|2.0|photo"
  "$IMG/hero-main-street.jpg|2.0|photo"
  "$IMG/hero-jackson.jpg|2.0|photo"
  "$IMG/sophia-saliby.webp|1.6|photo"
  "$IMG/melorie-begay.webp|1.6|photo"
  "$IMG/danielle-prieur-studio.jpg|1.6|photo"
  "$IMG/rick-pluta-studio.jpg|1.6|photo"
  "$IMG/colin-jackson.webp|1.6|photo"
  "$IMG/tim-skubick-studio.png|1.6|photo"
  "$IMG/interviews-studio.jpg|2.5|photo"
  "$IMG/wkar-election-logo-transparent.png|3.0|logo"
)

echo "→ Building video segments..."
CONCAT="$WORK/concat.txt"
: > "$CONCAT"
i=0
for entry in "${SLIDES[@]}"; do
  IFS='|' read -r path dur kind <<< "$entry"
  seg="$WORK/seg_$(printf '%02d' $i).mp4"
  if [[ "$kind" == "logo" ]]; then
    make_logo_seg "$path" "$dur" "$seg"
  else
    make_photo_seg "$path" "$dur" "$seg"
  fi
  echo "file '$seg'" >> "$CONCAT"
  i=$((i+1))
done

echo "→ Concatenating..."
ffmpeg -y -f concat -safe 0 -i "$CONCAT" -c copy "$WORK/video_silent.mp4" 2>/dev/null

echo "→ Mixing audio..."
ffmpeg -y -i "$WORK/video_silent.mp4" -i "$WORK/vo.wav" \
  -map 0:v:0 -map 1:a:0 -c:v libx264 -preset medium -crf 20 -c:a aac -b:a 192k \
  -shortest -movflags +faststart \
  "$OUT/wkar-election-2026-promo-draft.mp4" 2>/dev/null

cp "$WORK/vo.wav" "$OUT/wkar-election-2026-vo-draft.wav"

echo ""
echo "Done:"
echo "  Video: $OUT/wkar-election-2026-promo-draft.mp4"
echo "  Audio: $OUT/wkar-election-2026-vo-draft.wav"
echo "  Preview: $PROMO/preview.html"