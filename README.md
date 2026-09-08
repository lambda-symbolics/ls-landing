# Lambda Symbolics Landing

Static landing site for Lambda Symbolics OÜ, set in the Interlisp Paper
design language: Times New Roman, black ink on off-white paper, no flat
gray, and only a small inline script for the Autolith demo. The durable design context lives in `.impeccable.md`;
`paper.css` is the implementation canon.

## Stack

- Hand-written HTML and one stylesheet (`paper.css`)
- No build step; the Autolith demo has a small inline playback script
- Local self-hosted "Times New Roman" fonts included in `fonts/`
- Vercel static hosting (`vercel.json`)

## Files

- `index.html`: company page
- `cclsh.html`: CCLSH product page
- `autolith.html`: Autolith product page
- `autolith.png`: paper-colored, 1-bit dithered Autolith mascot
- `autolith/docs/`: Autolith documentation pages, served under `/autolith/docs`
- `rust-course.html`: Rust course page
- `lisp-repair.html`: fixed-scope Common Lisp repair service and quote enquiries
- `bookmark.html`: unlinked printable bookmark sheet (`/bookmark`; not in the sitemap, noindex)
- `cards.html`: unlinked printable business card sheet (`/cards`; not in the sitemap, noindex)
- `404.html`: not-found page
- `paper.css`: Interlisp Paper stylesheet
- `tools/make-og.py`: regenerates `og.png` (Pillow + the repo Times New Roman faces)

## Local preview

```bash
python3 -m http.server 4173
```

Then open `http://localhost:4173`.

## Deploy

Point Vercel at this repository/submodule and deploy as a static site.
