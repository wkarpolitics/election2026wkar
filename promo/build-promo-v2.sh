#!/bin/bash
# WKAR Election 2026 — branded promo (site-matched)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROMO="$(cd "$(dirname "$0")" && pwd)"
SLIDES="$PROMO/.build/slides"
OUT="$PROMO/output"
WORK="$PROMO/.build"
ASSETS="$ROOT/assets/video"
mkdir -p "$OUT" "$WORK" "$SLIDES" "$ASSETS"

VOICE="${WKAR_PROMO_VOICE:-Samantha}"
RATE="${WKAR_PROMO_RATE:-158}"
VARIANT="${1:-full}"   # full | social

if [[ "$VARIANT" == "social" ]]; then
  SCRIPT="$PROMO/script-15.txt"
  OUTNAME="wkar-election-2026-promo-15.mp4"
  SLIDE_SCALE=0.72
else
  SCRIPT="$PROMO/script-final.txt"
  OUTNAME="wkar-election-2026-promo.mp4"
  SLIDE_SCALE=1.0
fi

echo "→ Rendering branded slides..."
python3 "$PROMO/render-slides.py"

echo "→ Generating voiceover..."
say -v "$VOICE" -r "$RATE" -o "$WORK/vo.aiff" -f "$SCRIPT"
ffmpeg -y -i "$WORK/vo.aiff" -ar 48000 -ac 1 "$WORK/vo.wav" 2>/dev/null
VO_DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$WORK/vo.wav")
echo "   VO: ${VO_DUR}s"

# ffmpeg fade=st= requires a leading zero (e.g. 0.946, not .946)
ff_time() {
  awk -v x="$1" 'BEGIN { printf "%.3f", (x < 0 ? 0 : x) }'
}

echo "→ Generating music bed..."
ffmpeg -y \
  -f lavfi -i "sine=frequency=65:duration=${VO_DUR}" \
  -f lavfi -i "sine=frequency=130:duration=${VO_DUR}" \
  -f lavfi -i "anoisesrc=color=pink:amplitude=0.015:duration=${VO_DUR}" \
  -filter_complex "\
    [0]volume=0.055,lowpass=f=180[a];\
    [1]volume=0.028,lowpass=f=320[b];\
    [2]volume=0.02,lowpass=f=400[c];\
    [a][b][c]amix=inputs=3:duration=first,\
    afade=t=in:st=0:d=1.2,\
    afade=t=out:st=$(ff_time "$(echo "$VO_DUR - 1.8" | bc)"):d=1.8,\
    volume=0.85" \
  "$WORK/music.wav" 2>/dev/null

echo "→ Mixing VO + music..."
ffmpeg -y -i "$WORK/vo.wav" -i "$WORK/music.wav" \
  -filter_complex "[0]volume=1.0[vo];[1]volume=0.42[bed];[vo][bed]amix=inputs=2:duration=first:dropout_transition=0" \
  "$WORK/mix.wav" 2>/dev/null

make_seg() {
  local src="$1" dur="$2" out="$3"
  local durs=$(echo "$dur * $SLIDE_SCALE" | bc)
  local fade_out=$(ff_time "$(echo "$durs - 0.35" | bc)")
  ffmpeg -y -loop 1 -i "$src" -vf \
    "scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,format=yuv420p,\
     eq=contrast=1.05:saturation=0.94:brightness=0.02,\
     vignette=PI/5,\
     zoompan=z='min(zoom+0.0006,1.06)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1920x1080:fps=30,\
     fade=t=in:st=0:d=0.35,fade=t=out:st=${fade_out}:d=0.35" \
    -t "$durs" -r 30 -pix_fmt yuv420p "$out" 2>/dev/null
}

if [[ "$VARIANT" == "social" ]]; then
  ORDER=(
    "01-open.jpg|2.0"
    "02-capitol-dome.jpg|2.2"
    "03-lansing-aerial-dusk.jpg|1.8"
    "09-team-danielle-prieur-studio.jpg|1.8"
    "07-team-sophia-saliby.jpg|1.6"
    "99-close.jpg|2.2"
  )
else
  ORDER=(
    "01-open.jpg|3.0"
    "02-capitol-dome.jpg|3.5"
    "03-lansing-aerial-dusk.jpg|2.2"
    "04-downtown-main-street.jpg|1.8"
    "05-hero-main-street.jpg|1.8"
    "06-hero-jackson.jpg|1.8"
    "07-team-sophia-saliby.jpg|1.4"
    "08-team-melorie-begay.jpg|1.4"
    "09-team-danielle-prieur-studio.jpg|1.4"
    "10-team-rick-pluta-studio.jpg|1.4"
    "11-team-colin-jackson.jpg|1.4"
    "12-team-tim-skubick-studio.jpg|1.4"
    "13-interviews-studio.jpg|2.5"
    "99-close.jpg|3.0"
  )
fi

echo "→ Building segments..."
CONCAT="$WORK/concat.txt"
: > "$CONCAT"
i=0
for entry in "${ORDER[@]}"; do
  IFS='|' read -r file dur <<< "$entry"
  seg="$WORK/seg_$(printf '%02d' $i).mp4"
  make_seg "$SLIDES/$file" "$dur" "$seg"
  echo "file '$seg'" >> "$CONCAT"
  i=$((i+1))
done

ffmpeg -y -f concat -safe 0 -i "$CONCAT" -c copy "$WORK/video_silent.mp4" 2>/dev/null

ffmpeg -y -i "$WORK/video_silent.mp4" -i "$WORK/mix.wav" \
  -map 0:v:0 -map 1:a:0 -c:v libx264 -preset medium -crf 18 -c:a aac -b:a 192k \
  -shortest -movflags +faststart \
  "$OUT/$OUTNAME" 2>/dev/null

cp "$OUT/$OUTNAME" "$ASSETS/$OUTNAME"
cp "$WORK/mix.wav" "$OUT/${OUTNAME%.mp4}-audio.wav"

echo ""
echo "✓ $OUT/$OUTNAME"
echo "✓ $ASSETS/$OUTNAME (site asset)"