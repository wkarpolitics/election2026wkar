# WKAR Election 2026 — Promo (Draft)

## Watch it

**Easiest:** Double-click  
`promo/output/wkar-election-2026-promo-draft.mp4`

**Or open the preview page** (video player + team avatars):

```bash
cd ~/Desktop/WKAR\ POLITICS/promo
python3 -m http.server 8770
```

Then open: `http://localhost:8770/preview.html`

## What’s in the draft

| File | Description |
|------|-------------|
| `output/wkar-election-2026-promo-draft.mp4` | ~25 sec video |
| `output/wkar-election-2026-vo-draft.wav` | Voice track only |
| `script-final.txt` | Record-ready script |
| `preview.html` | Browser preview with team photos |

## How it was built

- **Voice:** macOS Samantha (placeholder — replace before on-air)
- **Faces:** Real WKAR team headshots (not AI avatars)
- **B-roll:** Capitol, Lansing, Main Street, I-96 corridor, newsroom
- **Edit:** `build-promo.sh` + ffmpeg

## Rebuild

```bash
cd ~/Desktop/WKAR\ POLITICS/promo
./build-promo.sh
```

Different voice: `WKAR_PROMO_VOICE=Fred WKAR_PROMO_RATE=150 ./build-promo.sh`

## Before you air it

1. Re-record VO with a news anchor (use `script-final.txt`)
2. Add licensed music bed under VO (-18 dB)
3. Optional: newsroom/Capitol SFX from the creative brief
4. Replace draft MP4 in traffic / web / social

## Upgrade to “broadcast” quality

- **VO:** Talent bureau, ElevenLabs Studio (human-reviewed), or in-house anchor
- **Music:** APM, Soundstripe, or WKAR brand library
- **Picture:** Add WKAR News logo sting + legal line at end