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

## Autolith docs

The development guide uses Lisp data in `content/guide/`, one file per chapter.
`index.sexp` lists the chapters in order. The published guide links to the Org
manual for the corresponding Autolith release.

For in-place copy editing, install SBCL and Quicklisp, then run:

```bash
sbcl --script tools/edit-docs.lisp
```

Open `http://127.0.0.1:7778/autolith/docs` and choose a chapter. Edit headings,
paragraphs, list text, and table cells directly. Click outside a field or press
Ctrl+S to save to its `.sexp` file. Use Ctrl+B, Ctrl+I, or Ctrl+K for bold,
italics, and links. Edit code samples and document structure in the chapter
files. The editor writes to the checkout, so use loopback or a trusted private
interface.

Before publishing, regenerate `autolith/docs/` and `sitemap.xml`. Update the
revision date and release number in `tools/make-docs.lisp` when appropriate,
and commit the chapter files and their regenerated pages together.

```bash
sbcl --non-interactive --load tools/make-docs.lisp --eval '(make-docs)'
```

The site copy was imported from Autolith's `docs/guide.org` at `175b72a8`.
To review a future upstream guide, use Pandoc and Python to import it into an
empty directory, then merge the changes you want into `content/guide/`:

```bash
python3 tools/import-docs.py /path/to/autolith/docs/guide.org /path/to/new-import
```

Check window shadow clearance at desktop and mobile widths with Chromium, and
verify the Autolith relocation routes:

```bash
sbcl --script tools/check-window-layout.lisp paper.css
python3 tools/check-autolith.py
```
