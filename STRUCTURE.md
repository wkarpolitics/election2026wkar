# WKAR Election 2026 — Project Structure

Single-page election hub for WKAR Public Media. All styles and scripts for the live site live in **`index.html`** unless noted below.

## Quick start

| Task | Location / command |
|------|-------------------|
| **Open the site** | `index.html` |
| **Local preview** | `cd "~/Desktop/GROK ELEX BUILD" && python3 -m http.server 8767 --bind 127.0.0.1` → http://127.0.0.1:8767/index.html |
| **Deploy** | `./deploy-to-github.sh` → [election2026wkar](https://github.com/wkarpolitics/election2026wkar) |

---

## Folder layout

```
GROK ELEX BUILD/
├── index.html                 ← Main site (HTML + embedded CSS + JS)
├── STRUCTURE.md               ← This file
├── HANDOFF.md                 ← Design/build notes and locked decisions
├── deploy-to-github.sh        ← Push to GitHub Pages
├── .nojekyll                  ← GitHub Pages (no Jekyll processing)
├── .gitignore
│
├── assets/
│   ├── images/                ← All photos, logos, promos, hero frames
│   │   ├── signal/            ← Signal + Signal+ promo graphics
│   │   └── hero-team/         ← Team cutouts (legacy)
│   ├── video/                 ← Background clips (e.g. corn-wind.mp4)
│   ├── tmp/                   ← Scratch exports (not linked from site)
│   └── mi-counties-map.js     ← County map data + init (loaded by index.html)
│
├── docs/
│   └── README.md              ← Preview & publish notes
│
├── promo/                     ← Slide/promo build scripts (not served on site)
│
└── archive/                   ← Local only — not published
    ├── source-media/          ← Original PNGs/JPEGs before import to assets/
    ├── screenshots/           ← QA screenshots
    └── experiments/           ← Standalone HTML tests
```

---

## Main HTML file

**`index.html`** (~10.9k lines) contains:

- **`<style>`** — All site CSS (mobile-first `election-hub` overrides, section styles, animations)
- **`<body>`** — Full page markup (hero, headlines, team, promise, OTR, Signal, dates, ballot, map, footer)
- **`<script>`** — Countdown, RSS headlines, hero slideshow, town pop, nav menu, YouTube fallbacks

External dependencies (CDN):

- Tailwind CSS (utility classes)
- Google Fonts (Source Serif 4, Inter, DM Mono)

---

## CSS organization (inside `index.html`)

CSS is sectioned with comment headers, roughly in page order:

| Block | Contents |
|-------|----------|
| `:root` / Tailwind config | Colors, spacing tokens |
| Site chrome | Masthead, election nav, mobile menu |
| Hero | Slideshow, promise card, town pop, headlines band |
| Sections | Team, promise, OTR, Signal, key dates, ballot, races, data centers |
| County map | `.county-map-*` module styles |
| `body.election-hub` | Mobile-first polish layer (primary breakpoint `max-width: 767px`) |
| Visual QA pass | Spacing, tap targets, map panel (end of `<style>`) |

There is **no separate `.css` file** — edits are made in the `<style>` block.

---

## JavaScript organization

| Feature | Where |
|---------|--------|
| County map data + SVG render | `assets/mi-counties-map.js` (loaded before inline scripts) |
| County map interaction | Inline in `index.html` (panel updates, chip selection) |
| Hero background slideshow | Inline IIFE |
| Town name pop (mobile promise card) | Inline IIFE |
| WKAR RSS headlines feed | Inline IIFE |
| Election nav mobile toggle | Inline |
| Countdown / key dates | Inline |

---

## Images & assets

**Always use paths relative to `index.html`:**

```
assets/images/hero-capitol-promise.jpg
assets/images/rick-and-colin.jpg
assets/images/headlines-skyline-cutout.png
assets/images/signal/signal-plus-promo-horizontal.png
assets/video/corn-wind.mp4
```

### Key image groups

| Group | Path | Used for |
|-------|------|----------|
| Hero slideshow | `assets/images/hero-*.jpg` | 7-frame mobile/desktop hero |
| Headlines | `assets/images/headlines-top-story-capitol.jpg` | Lead story photo |
| Team | `assets/images/*.webp`, `rick-and-colin.jpg`, `tim-skubick-recent.jpg` | Reporter cards & state team |
| Signal | `assets/images/signal/` | Newsletter promo graphics |
| Logos | `assets/images/wkar-*.png`, `signal-logo-transparent.png` | Brand marks |
| WKAR building | `assets/images/wkar-building-exterior.jpg` | Team intro card |

Raw downloads and duplicates live in **`archive/source-media/`** — not referenced by the site.

---

## County map

| Piece | Location |
|-------|----------|
| Map markup | `#county-map` section in `index.html` |
| Map styles | `.county-map-module`, `.county-map-panel`, `.county-path-wkar` in `<style>` |
| Michigan SVG paths + WKAR county data | `assets/mi-counties-map.js` |
| Interaction (tap/hover → info panel) | Inline JS in `index.html` |

On **mobile**, the info panel stacks below the map with a bordered card. On **desktop** (≥900px), map and panel sit side-by-side.

---

## Section order (live page)

1. Hero (slideshow + promise card + headlines band + key-dates glance)
2. Signal promo scatter (after Interviews)
3. Team
4. Coverage mosaic (divider)
5. Promise
6. Off The Record
7. The Signal (newsletter promo)
8. Key Dates
9. Your Ballot
10. Races
11. Data Centers
12. County Map
13. Legislative Watch / Explainers
14. Footer

---

## What gets published (GitHub Pages)

- `index.html`
- `assets/` (images, video, `mi-counties-map.js`)
- `docs/`
- `.nojekyll`

**Not published:** `archive/`, `promo/`, `HANDOFF.md`, `STRUCTURE.md` (optional to include docs)

---

## Locked decisions (do not regress)

See **`HANDOFF.md`** for full list. Critical items:

- Mobile hero slide 3 = corn video
- White promise card on mobile hero
- WKAR masthead placeholder image unchanged
- Capitol hero = `hero-capitol-promise.jpg` only
- Rick & Colin shared photo; Tim full-width; no individual Rick/Colin cards
- Signal+ promos use transparent PNG assets in `assets/images/signal/`

---

## Maintenance tips

1. **Preview changes** — Always use a local server (`python3 -m http.server`), not `file://`, for RSS and video.
2. **New images** — Add to `assets/images/`, reference with relative paths, optimize before commit.
3. **Mobile QA** — Test at 390×844; primary CSS breakpoint is `767px`.
4. **County map** — Edit clerk URLs / WKAR counties in `mi-counties-map.js`, not inline HTML.