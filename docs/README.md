# WKAR Election 2026

A single-page election hub for WKAR Public Media — Michigan 2026 races, headlines, team, The Signal newsletter, and voter tools.

## Folder structure

```
WKAR POLITICS/
├── index.html              ← Main website (start here)
├── assets/
│   ├── images/             ← All photos and graphics
│   ├── video/              ← Short clips used on the page
│   └── mi-counties-map.js  ← Interactive county map script
├── docs/
│   └── README.md           ← This file
└── archive/                ← Old tests and raw source files (safe to ignore)
```

## How to preview locally

1. Open Terminal.
2. Run:
   ```bash
   cd ~/Desktop/WKAR\ POLITICS
   python3 -m http.server 8766
   ```
3. Visit: `http://localhost:8766/index.html`

## Where files go

| What | Where |
|------|--------|
| Team headshots | `assets/images/` (e.g. `sophia-saliby.webp`, `danielle-prieur-studio.jpg`) |
| Clean/cropped team photos | `assets/images/` (e.g. `sophia-saliby-clean.jpg`, `danielle-prieur-clean.jpg`) |
| Election & Signal logos | `assets/images/` |
| Hero background photos | `assets/images/` |
| Flag / background video | `assets/video/waving-flag.mp4` |
| Old HTML tests | `archive/` (not linked from the live site) |
| Raw downloads & drafts | `archive/source-media/` |

## Images used on the Team section

| Person | File in `assets/images/` |
|--------|--------------------------|
| Sophia Saliby | `sophia-saliby.webp` |
| Melorie Begay | `melorie-begay.webp` |
| Danielle Prieur | `danielle-prieur-studio.jpg` |
| Rick Pluta | `rick-pluta-studio.jpg` |
| Colin Jackson | `colin-jackson.webp` |
| Tim Skubick | `tim-skubick-studio.png` |

## GitHub-ready notes

- Only commit `index.html`, `assets/`, and `docs/` for the public site.
- Keep `archive/` local or add it to `.gitignore` if you do not want old files in the repo.
- The WKAR masthead in `index.html` uses an embedded base64 image — do not replace that image when updating the header.

## Archive folder

Contains backups and experiments, including:

- `index-test.html` — older sync copy from Desktop
- `map-code.html` — county map experiment
- `WKAR-Election-2026-original/` — full project folder before this cleanup
- `source-media/` — original photos and drafts