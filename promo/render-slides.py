#!/usr/bin/env python3
"""Generate WKAR Election 2026 promo slides matching site palette."""
from __future__ import annotations

import os
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageOps

ROOT = Path(__file__).resolve().parent.parent
IMG = ROOT / "assets" / "images"
OUT = Path(__file__).resolve().parent / ".build" / "slides"
OUT.mkdir(parents=True, exist_ok=True)

W, H = 1920, 1080
GREEN_DEEP = (26, 58, 42)      # #1a3a2a
GREEN_MID = (61, 122, 89)      # #3d7a59
BLUE = (39, 76, 152)           # #274c98
RED = (197, 46, 38)            # #c52e26
CREAM = (250, 247, 243)        # #faf7f3
SLATE = (29, 29, 31)
MUTED = (110, 110, 115)


def font(size: int, bold: bool = False, serif: bool = False):
    candidates = []
    if serif:
        candidates += [
            "/System/Library/Fonts/Supplemental/Georgia.ttf",
            "/System/Library/Fonts/Supplemental/Georgia Bold.ttf",
            "/Library/Fonts/Georgia.ttf",
        ]
    else:
        candidates += [
            "/System/Library/Fonts/Supplemental/Arial Bold.ttf" if bold else "/System/Library/Fonts/Supplemental/Arial.ttf",
            "/System/Library/Fonts/Helvetica.ttc",
        ]
    for path in candidates:
        if os.path.exists(path):
            try:
                return ImageFont.truetype(path, size)
            except OSError:
                continue
    return ImageFont.load_default()


def tricolor_bar(draw: ImageDraw.ImageDraw, y: int, width: int = 420, height: int = 3, cx: int = W // 2):
    x0 = cx - width // 2
    seg = width // 3
    draw.rectangle([x0, y, x0 + seg, y + height], fill=BLUE)
    draw.rectangle([x0 + seg, y, x0 + seg * 2, y + height], fill=GREEN_DEEP)
    draw.rectangle([x0 + seg * 2, y, x0 + width, y + height], fill=RED)


def gradient_bg(top=CREAM, bottom=(245, 245, 247)):
    bg = Image.new("RGB", (W, H), top)
    draw = ImageDraw.Draw(bg)
    for y in range(H):
        t = y / max(H - 1, 1)
        r = int(top[0] * (1 - t) + bottom[0] * t)
        g = int(top[1] * (1 - t) + bottom[1] * t)
        b = int(top[2] * (1 - t) + bottom[2] * t)
        draw.line([(0, y), (W, y)], fill=(r, g, b))
    return bg


def dark_bg():
    bg = Image.new("RGB", (W, H), GREEN_DEEP)
    draw = ImageDraw.Draw(bg)
    for y in range(H):
        t = y / H
        r = int(26 + 18 * t)
        g = int(58 + 30 * t)
        b = int(42 + 22 * t)
        draw.line([(0, y), (W, y)], fill=(r, g, b))
    return bg


def paste_logo(canvas: Image.Image, scale: float = 0.55, y_offset: int = -60):
    logo_path = IMG / "wkar-election-logo-transparent.png"
    logo = Image.open(logo_path).convert("RGBA")
    lw = int(W * scale)
    lh = int(lw * logo.height / logo.width)
    logo = logo.resize((lw, lh), Image.Resampling.LANCZOS)
    x = (W - lw) // 2
    y = (H - lh) // 2 + y_offset
    canvas.paste(logo, (x, y), logo)


def open_card():
    bg = gradient_bg()
    paste_logo(bg, 0.5, -80)
    draw = ImageDraw.Draw(bg)
    tricolor_bar(draw, H // 2 + 200)
    eyebrow = "MID-MICHIGAN'S VOICE"
    f_e = font(28, bold=True)
    tw = draw.textlength(eyebrow, font=f_e)
    draw.text(((W - tw) / 2, H // 2 + 220), eyebrow, fill=GREEN_MID, font=f_e)
    bg.save(OUT / "01-open.jpg", quality=92)


def close_card():
    bg = dark_bg()
    draw = ImageDraw.Draw(bg)
    tricolor_bar(draw, H // 2 - 120)
    f1 = font(72, bold=True, serif=True)
    f2 = font(34)
    lines = ["WKAR News", "On air & online · All year long"]
    y = H // 2 - 60
    for i, line in enumerate(lines):
        f = f1 if i == 0 else f2
        color = (255, 255, 255) if i == 0 else (220, 220, 225)
        tw = draw.textlength(line, font=f)
        draw.text(((W - tw) / 2, y), line, fill=color, font=f)
        y += 90 if i == 0 else 56
    f3 = font(22)
    sub = "Public Media from Michigan State University"
    tw = draw.textlength(sub, font=f3)
    draw.text(((W - tw) / 2, H - 120), sub, fill=MUTED, font=f3)
    bg.save(OUT / "99-close.jpg", quality=92)


def brand_photo(src: Path, name: str, idx: int):
    photo = Image.open(src).convert("RGB")
    photo = ImageOps.fit(photo, (W, H), method=Image.Resampling.LANCZOS)
    photo = photo.filter(ImageFilter.GaussianBlur(radius=0.3))
    overlay = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    od = ImageDraw.Draw(overlay)
    for y in range(H):
        t = max(0, (y - H * 0.45) / (H * 0.55))
        a = int(180 * (t ** 1.4))
        od.line([(0, y), (W, y)], fill=(15, 30, 22, a))
    for y in range(int(H * 0.55)):
        t = 1 - y / (H * 0.55)
        a = int(90 * (t ** 1.8))
        od.line([(0, y), (W, y)], fill=(250, 247, 243, a))
    photo = Image.alpha_composite(photo.convert("RGBA"), overlay).convert("RGB")
    draw = ImageDraw.Draw(photo)
    draw.rectangle([0, 0, W, 4], fill=BLUE)
    draw.rectangle([0, 4, W, 7], fill=GREEN_DEEP)
    draw.rectangle([0, 7, W, 10], fill=RED)
    if name:
        f_e = font(26, bold=True)
        draw.text((72, H - 130), "WKAR NEWS", fill=GREEN_MID, font=f_e)
        f_t = font(52, bold=True, serif=True)
        draw.text((72, H - 88), name, fill=(255, 255, 255), font=f_t)
    photo.save(OUT / f"{idx:02d}-{src.stem}.jpg", quality=90)


def team_card(src: Path, name: str, role: str, idx: int):
    bg = gradient_bg((248, 250, 248), (240, 244, 241))
    draw = ImageDraw.Draw(bg)
    tricolor_bar(draw, 120, 280, 3)

    photo = Image.open(src).convert("RGB")
    size = 520
    photo = ImageOps.fit(photo, (size, size), method=Image.Resampling.LANCZOS)
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).ellipse([0, 0, size, size], fill=255)
    photo.putalpha(mask)

    bordered = Image.new("RGBA", (size + 16, size + 16), (0, 0, 0, 0))
    bdraw = ImageDraw.Draw(bordered)
    bdraw.ellipse([0, 0, size + 15, size + 15], fill=GREEN_MID + (255,))
    bordered.paste(photo, (8, 8), photo)
    bg.paste(bordered, ((W - size) // 2 - 8, 200), bordered)

    f_e = font(24, bold=True)
    tw = draw.textlength("WKAR NEWS", font=f_e)
    draw.text(((W - tw) / 2, 780), "WKAR NEWS", fill=GREEN_MID, font=f_e)
    f_n = font(56, bold=True, serif=True)
    tw = draw.textlength(name, font=f_n)
    draw.text(((W - tw) / 2, 830), name, fill=SLATE, font=f_n)
    f_r = font(22, bold=True)
    tw = draw.textlength(role.upper(), font=f_r)
    draw.text(((W - tw) / 2, 910), role.upper(), fill=MUTED, font=f_r)
    bg.save(OUT / f"{idx:02d}-team-{src.stem}.jpg", quality=92)


def main():
    open_card()
    close_card()
    brand_photo(IMG / "capitol-dome.jpg", "From the state Capitol", 2)
    brand_photo(IMG / "lansing-aerial-dusk.jpg", "Across Mid-Michigan", 3)
    brand_photo(IMG / "downtown-main-street.jpg", "Along the Grand River", 4)
    brand_photo(IMG / "hero-main-street.jpg", "Up and down 127", 5)
    brand_photo(IMG / "hero-jackson.jpg", "Across I-96", 6)
    brand_photo(IMG / "interviews-studio.jpg", "Trusted election coverage", 13)

    team = [
        (IMG / "sophia-saliby.webp", "Sophia Saliby", "All Things Considered Host", 7),
        (IMG / "melorie-begay.webp", "Melorie Begay", "Morning Edition Host", 8),
        (IMG / "danielle-prieur-studio.jpg", "Danielle Prieur", "Mid-Michigan Political Reporter", 9),
        (IMG / "rick-pluta-studio.jpg", "Rick Pluta", "Senior Capitol Correspondent", 10),
        (IMG / "colin-jackson.webp", "Colin Jackson", "Capitol Correspondent", 11),
        (IMG / "tim-skubick-studio.png", "Tim Skubick", "Off The Record Host", 12),
    ]
    for src, name, role, idx in team:
        team_card(src, name, role, idx)
    print(f"Rendered slides → {OUT}")


if __name__ == "__main__":
    main()