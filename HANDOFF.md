# WKAR Election 2026 Project Handoff

Last updated: June 24, 2026

This note is for continuing the WKAR Election 2026 site with another AI, another developer, or a future session. The project is a static HTML/CSS/JavaScript site intended for GitHub Pages or a simple CMS embed workflow.

## 1. Current Project Status

Main working file:

```text
/Users/gillfillan/Desktop/WKAR POLITICS/index.html
```

Local preview URL currently used during development:

```text
http://127.0.0.1:8126/
```

What has been built so far:

- A redesigned WKAR Election 2026 homepage/hub in one main static file.
- WKAR-style top site chrome and election subnav.
- Hero section with WKAR Election 2026 logo, “We promise” positioning, town-name drift layer, headline panel, and rotating documentary-style image assets.
- Mobile-first headline layout with the WKAR logo kept at the top.
- Top political headlines using current WKAR/Public Media links.
- Lead story photo using Andrew Roth’s Burchfield Park/transmission line image.
- In-depth interview/listening section for Sophia Saliby and Melorie Begay, with a four-story default view and expandable “more stories.”
- Team section split into:
  - The WKAR News Local Team: Sophia, Melorie, Danielle, Andrew.
  - The WKAR News State Team: Rick, Colin, Tim.
- The Signal section with newsletter signup layout and Signal logo.
- Off The Record section with YouTube embeds.
- Ballot/resource tools, key dates, races, data center coverage, and footer.
- A first pass at an interactive map area, but this still needs correction because the current iframe URL returns a GitHub Pages 404.

Important current warning:

- The page is still in active visual iteration. Some recent edits were made right before this handoff, especially around the hero image visibility, team links, and map cleanup. A full visual pass is still needed.

## 2. Folder Structure

Current project folder:

```text
WKAR POLITICS/
├── index.html
├── HANDOFF.md
├── docs/
│   └── README.md
├── assets/
│   ├── images/
│   │   ├── team photos
│   │   ├── hero photos
│   │   ├── Signal graphics
│   │   ├── WKAR / Election logos
│   │   └── story photos
│   ├── video/
│   │   ├── waving-flag.mp4
│   │   ├── hero-capitol.mp4
│   │   ├── hero-michigan.mp4
│   │   ├── capitol-flyover.mp4
│   │   ├── capitol-hero-slow.mp4
│   │   └── dc-header.mp4
│   └── mi-counties-map.js
├── archive/
│   ├── index-before-codex-100k-rework-20260623-231645.html
│   ├── WKAR-Election-2026-original/
│   ├── source-media/
│   └── restore scripts / older experiments
├── backup grok build/
├── promo/
│   ├── README.md
│   ├── .build/
│   └── output/
├── .git/
├── .gitignore
└── .nojekyll
```

Backups exist. Do not delete them casually.

Most important backup:

```text
/Users/gillfillan/Desktop/WKAR POLITICS/archive/index-before-codex-100k-rework-20260623-231645.html
```

## 3. Image Assets

Main image folder:

```text
/Users/gillfillan/Desktop/WKAR POLITICS/assets/images/
```

Cleaned/current team photos:

```text
assets/images/sophia-saliby.webp
assets/images/melorie-begay.webp
assets/images/danielle-prieur-studio.jpg
assets/images/andrew-roth-reporter-wkar-flat.jpg
assets/images/rick-pluta-updated.jpg
assets/images/colin-jackson.webp
assets/images/tim-skubick-recent.jpg
```

Other useful alternate team images:

```text
assets/images/sophia-saliby-clean.jpg
assets/images/sophia-saliby-headshot-clean.png
assets/images/danielle-prieur-clean.jpg
assets/images/danielle-prieur-new.png
assets/images/rick-pluta-clean.jpg
assets/images/rick-pluta-headshot-clean.png
assets/images/colin-jackson-clean.jpg
assets/images/colin-jackson-headshot-clean.png
assets/images/tim-skubick-clean.jpg
assets/images/tim-skubick-headshot-clean.png
assets/images/rick-and-colin.jpg
```

Hero/documentary image assets:

```text
assets/images/capitol-michgov-vertical.jpg
assets/images/capitol-michgov-dome.jpg
assets/images/capitol-michgov-wide.jpg
assets/images/hero-interviews.jpg
assets/images/hero-otr-studio.jpg
assets/images/data-center-meeting-lansing.jpg
assets/images/hero-jackson.jpg
assets/images/hero-meeting-01.jpg
assets/images/hero-meeting-02.jpg
assets/images/hero-meeting-03.jpg
assets/images/hero-meeting-04.jpg
assets/images/hero-meeting-05.jpg
assets/images/hero-meeting-06.jpg
assets/images/hero-meeting-07.jpg
```

Story/photo assets:

```text
assets/images/burchfield-park-transmission-line.webp
assets/images/data-center-mason.jpg
assets/images/data-center-meeting-lansing.jpg
```

Signal assets:

```text
assets/images/the-signal-logo.svg
assets/images/politics2026-signal-plus-extension.png
assets/images/signal/promo-collage.jpg
assets/images/signal/roth-watching.jpg
assets/images/signal/data-center-tracker.jpg
assets/images/signal/st-johns.jpg
assets/images/signal/week-ahead.jpg
```

Logo assets:

```text
assets/images/wkar-election-logo-transparent.png
assets/images/wkar-election-logo.jpg
assets/images/wkar-election-26-mark.svg
assets/images/wkar-news-logo.svg
assets/images/wkar-news-logo-dark.svg
assets/images/wkar-news-logo-horizontal.svg
```

Important: do not modify the WKAR masthead base64 image inside `index.html`. The user gave a hard rule that it must never be changed.

## 4. Key Design Decisions

General visual direction:

- Mobile is the priority.
- The desired look is modern, Apple-like, boutique, premium public-media/newsroom.
- Avoid overly rounded “pill box” styling unless it is a clear button or small control.
- Use straighter edges, subtle borders, soft shadows, and quiet whitespace.
- Accent colors are WKAR green, blue, and red.
- Avoid peach/tan-heavy backgrounds.
- Avoid big generic marketing cards.
- The site should feel like a premium election resource, not a campaign page.

Content direction:

- The site is about the team asking questions:
  - Seven WKAR political voices.
  - Six/seven reporters, hosts, and public affairs voices.
  - In-depth interviews, long-form reporting, candidate accountability, local impact.
- The WKAR hosts do in-depth coverage:
  - Sophia Saliby: All Things Considered Host.
  - Melorie Begay: Morning Edition Host.
- Local reporting:
  - Danielle Prieur: Lead Mid-Michigan Political Reporter.
  - Andrew Roth: Mid-Michigan Political Reporter, author of “What Roth’s Watching” in The Signal.
- State team:
  - Rick Pluta: Senior Capitol Correspondent.
  - Colin Jackson: Capitol Correspondent.
  - Tim Skubick: Host of Off The Record.

Hero direction:

- The hero should be shorter than earlier versions.
- It should start with a gorgeous high-definition Capitol image, then dissolve to documentary photos like Melorie in studio, public meetings, and Jackson/local visuals.
- No shaky Capitol video in the hero.
- The hero images must be visible. Avoid burying them behind too much white overlay, town text, or the headline panel.
- The town-name animated layer is liked, but it should stay very faint, slow, scattered, and calm.

Headlines:

- Headline tags should be geographic labels only, such as `Ingham` or `Michigan`.
- Do not use topic labels like `Energy`, `Budget`, `Governor`, or `Data Centers` in the headline tags unless that direction changes.
- Top story should include the Burchfield Park photo from Andrew Roth’s story.

Team:

- Team order must be:
  1. Sophia Saliby
  2. Melorie Begay
  3. Danielle Prieur
  4. Andrew Roth
  5. Rick Pluta
  6. Colin Jackson
  7. Tim Skubick
- Group labels should be:
  - `THE WKAR NEWS LOCAL TEAM`
  - `THE WKAR NEWS STATE TEAM`
- Reporter cards should be compact on mobile.
- Avoid long bio text under photos.
- Cards should link to bio pages where available.

Signal:

- Use The Signal logo.
- The eyebrow/tag “Coming Wednesdays This Summer” should be removed from the top Signal masthead area.
- Signal Plus can be explained in body copy, not as a confusing carousel graphic.
- Wednesday edition language: “coming Wednesdays this summer.”

Map:

- The map must be interactive, mobile-friendly, and at least 450px tall on mobile if embedded in a CMS iframe.
- Current external iframe is broken because it loads a GitHub Pages 404.
- Best next step is either:
  - build the map directly into `index.html`, or
  - publish the map repository correctly and update the iframe URL.

Public media references:

- Avoid presenting “Michigan Public” as a headline brand or partner block near WKAR brand moments. The user noted Michigan Public is a rival in audience perception.
- It is okay to link to Michigan Public stories where editorially useful, but avoid ugly “public media network” blocks and repeated station badges.

## 5. What Still Needs To Be Done

High-priority TODOs:

- Run a full visual check at 390px, 768px, and 1280px.
- Fix the hero image treatment so the photos are clearly visible and not hidden under overlays or headline panels.
- Confirm the hero is shorter and no longer feels like a giant wallpaper block.
- Remove or soften the repeated election logos in lower sections. They currently look too repetitive.
- Fix headline tags so every tag is county/state only.
- Remove the repeated “What voters get from us” mobile/team mini-block if still visible.
- Remove “Coming Wednesdays This Summer” eyebrow/tag from the Signal header area.
- Replace old Off The Record YouTube embeds with:
  - `https://www.youtube.com/watch?v=HJRvbUD6cYU`
  - `https://www.youtube.com/watch?v=QsA3uvCUQTg`
- Fix the interactive map. Current iframe points to a URL returning 404.
- Remove the ugly public media station/partner block.
- Remove or rewrite “Michigan Public Media network” language in the data center section.
- Make sure team cards link correctly:
  - Sophia: WKAR bio page.
  - Melorie: WKAR bio page.
  - Danielle: WKAR.org.
  - Andrew: WKAR.org.
  - Rick: bio page if available.
  - Colin: bio page if available.
  - Tim: WKAR bio page if available.
- Verify all links open correctly.

Mobile-specific TODOs:

- Keep WKAR Election logo at the top of mobile.
- On mobile, put political headlines before the “We promise” closing/tagline.
- Put stats below headlines on mobile if the ticker/stats feel cramped.
- Make sure the headline ticker does not overlap text.
- Make sure tap targets are at least 44px.
- Make sure team cards do not have large blank areas.
- Make sure the map has enough height for its bottom sheet.

Polish TODOs:

- Reduce rounded corners across the site where they feel too soft.
- Keep buttons usable but avoid “pill overload.”
- Make typography consistent and premium.
- Confirm the pretty serif headline style is used intentionally.
- Check color balance: red, blue, green accents should feel deliberate, not noisy.
- Add subtle flag texture only if it does not cause motion sickness or visual clutter.
- Re-check contrast and focus states after final styling.

## 6. How To Push To GitHub

The project already appears to have a `.git` folder. Check first:

```bash
cd "/Users/gillfillan/Desktop/WKAR POLITICS"
git status
```

If Git is already initialized:

```bash
cd "/Users/gillfillan/Desktop/WKAR POLITICS"
git add .
git commit -m "Rework WKAR Election 2026 hub"
git branch -M main
git remote add origin https://github.com/wkarpolitics/election2026wkar.git
git push -u origin main
```

If the remote already exists, use this instead:

```bash
cd "/Users/gillfillan/Desktop/WKAR POLITICS"
git remote -v
git remote set-url origin https://github.com/wkarpolitics/election2026wkar.git
git push -u origin main
```

If Git is not initialized in a fresh copy:

```bash
cd "/Users/gillfillan/Desktop/WKAR POLITICS"
git init
git add .
git commit -m "Initial WKAR Election 2026 hub"
git branch -M main
git remote add origin https://github.com/wkarpolitics/election2026wkar.git
git push -u origin main
```

If GitHub Pages is used:

1. Go to the GitHub repo.
2. Open Settings.
3. Open Pages.
4. Set source to `Deploy from a branch`.
5. Choose `main` and `/root`.
6. Save.
7. The public URL should eventually be:

```text
https://wkarpolitics.github.io/election2026wkar/
```

## 7. Notes For Other AIs

Please read this before editing:

- Do not modify the WKAR masthead base64 image in `index.html`.
- The user is making live visual judgments from screenshots. Always visually inspect before saying something is done.
- Mobile matters most.
- The user strongly prefers:
  - smaller items,
  - less rounded UI,
  - modern Apple-like restraint,
  - crisp images,
  - premium serif headlines,
  - clear resource utility,
  - no clutter.
- The user dislikes:
  - peach backgrounds,
  - huge cards,
  - pill-heavy layouts,
  - blurry photos,
  - repeated logos everywhere,
  - hidden/overwashed photos,
  - broken embeds,
  - generic partner/public-media blocks.
- The user wants the site to feel like a `$100k` public media election build.
- The core editorial promise is:
  - in-depth reporting,
  - beyond the Capitol,
  - stories nobody else is chasing,
  - tools to take action,
  - where the audience is,
  - independent public media.
- Newsroom email:

```text
news@wkar.org
```

- Andrew Roth email:

```text
rothand5@msu.edu
```

Recommended workflow for the next AI:

1. Open `index.html`.
2. Start the local preview server.
3. Inspect at 390px, 768px, and 1280px.
4. Fix one visible section at a time.
5. After every major visual change, take screenshots before moving on.
6. Keep changes scoped. This file is large, and it is easy to accidentally break unrelated sections.

Suggested local preview command:

```bash
cd "/Users/gillfillan/Desktop/WKAR POLITICS"
python3 -m http.server 8126
```

Then open:

```text
http://127.0.0.1:8126/
```

