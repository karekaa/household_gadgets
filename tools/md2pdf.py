#!/usr/bin/env python3
"""Render a Markdown file to a print-ready A4 PDF.

Written for the README files in this repo, so it only covers the Markdown they
actually use: ATX headings, paragraphs, `**bold**`, `` `code` ``, links, images,
pipe tables, blockquotes, bullet lists (with indented continuation lines) and
fenced code blocks. It is not a general Markdown implementation -- if you add
syntax to a README, check the result.

There is no pandoc/weasyprint on the build machine, so the pipeline is
Markdown -> HTML with print CSS -> headless Chrome --print-to-pdf. Images are
linked as absolute file:// URLs relative to the Markdown file, so anything in
img/ is embedded in the PDF.

Usage:
    tools/md2pdf.py robot_cleaner/threshold_ramp/README.no.md
    tools/md2pdf.py README.no.md -o /tmp/ramp.pdf

With no -o the PDF is written next to the source file with the same stem.
"""
import argparse
import html
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

# Tried in order; the first one found is used to print the HTML.
BROWSERS = [
    "google-chrome",
    "google-chrome-stable",
    "chromium",
    "chromium-browser",
    "microsoft-edge",
]

CSS = """
@page { size: A4; margin: 18mm 16mm 16mm 16mm; }
body { font: 10.5pt/1.45 "DejaVu Sans", Arial, sans-serif; color: #1a1a1a; }
h1 { font-size: 20pt; margin: 0 0 .4em; border-bottom: 2px solid #333; padding-bottom: .2em; }
h2 { font-size: 14pt; margin: 1.4em 0 .4em; border-bottom: 1px solid #bbb;
     padding-bottom: .15em; page-break-after: avoid; }
h3 { font-size: 11.5pt; margin: 1.1em 0 .3em; page-break-after: avoid; }
p, ul, table, pre { page-break-inside: avoid; }
blockquote { margin: .6em 0; padding: .4em .8em; border-left: 3px solid #bbb;
             color: #555; font-size: 9.5pt; }
code { font-family: "DejaVu Sans Mono", monospace; font-size: .88em;
       background: #f0f0f0; padding: .1em .3em; border-radius: 3px; }
pre { background: #f6f6f6; border: 1px solid #ddd; border-radius: 4px;
      padding: .7em .9em; overflow-wrap: break-word; white-space: pre-wrap; }
pre code { background: none; padding: 0; font-size: 9pt; }
table { border-collapse: collapse; width: 100%; margin: .7em 0; font-size: 9.5pt; }
th, td { border: 1px solid #ccc; padding: .35em .5em; text-align: left;
         vertical-align: top; }
th { background: #ececec; }
td:first-child { white-space: nowrap; }
img { max-width: 100%; max-height: 95mm; display: block; margin: .5em auto; }
p.figure { text-align: center; margin: .8em 0; }
ul { padding-left: 1.3em; }
li { margin: .3em 0; }
a { color: #0645ad; text-decoration: none; }
"""


def convert(src: Path) -> str:
    """Markdown text -> a complete HTML document."""
    base = src.parent.resolve()

    def resolve(target):
        """Make image/link targets absolute so Chrome can load them."""
        if re.match(r"^[a-z]+:", target):
            return target
        return (base / target).as_uri()

    def inline(text):
        text = html.escape(text)
        text = re.sub(
            r"!\[(.*?)\]\((.*?)\)",
            lambda m: '<img alt="%s" src="%s">' % (m.group(1), resolve(m.group(2))),
            text,
        )
        text = re.sub(
            r"\[(.*?)\]\((.*?)\)",
            lambda m: '<a href="%s">%s</a>' % (resolve(m.group(2)), m.group(1)),
            text,
        )
        text = re.sub(r"`(.+?)`", r"<code>\1</code>", text)
        text = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", text)
        return text

    def cells(row):
        return [c.strip() for c in row.strip().strip("|").split("|")]

    # A line starting with "- " or "* " is a bullet. Requiring the space keeps
    # a paragraph line that opens with **bold** from being read as a list.
    bullet = re.compile(r"^(\s*)[-*]\s+(.*)")

    lines = src.read_text(encoding="utf-8").split("\n")
    body = []
    i = 0
    while i < len(lines):
        line = lines[i]

        # fenced code block
        if line.startswith("```"):
            buf = []
            i += 1
            while i < len(lines) and not lines[i].startswith("```"):
                buf.append(html.escape(lines[i]))
                i += 1
            i += 1
            body.append("<pre><code>%s</code></pre>" % "\n".join(buf))
            continue

        # heading
        m = re.match(r"^(#{1,6})\s+(.*)", line)
        if m:
            level = len(m.group(1))
            body.append("<h%d>%s</h%d>" % (level, inline(m.group(2)), level))
            i += 1
            continue

        # pipe table, recognised by the |---|---| separator on the next line
        if (
            line.strip().startswith("|")
            and i + 1 < len(lines)
            and re.match(r"^\s*\|[-:| ]+\|\s*$", lines[i + 1])
        ):
            head = cells(line)
            i += 2
            rows = []
            while i < len(lines) and lines[i].strip().startswith("|"):
                rows.append(cells(lines[i]))
                i += 1
            out = ["<table><thead><tr>"]
            out += ["<th>%s</th>" % inline(c) for c in head]
            out.append("</tr></thead><tbody>")
            for row in rows:
                out.append(
                    "<tr>" + "".join("<td>%s</td>" % inline(c) for c in row) + "</tr>"
                )
            out.append("</tbody></table>")
            body.append("".join(out))
            continue

        # blockquote
        if line.strip().startswith(">"):
            buf = []
            while i < len(lines) and lines[i].strip().startswith(">"):
                buf.append(lines[i].strip().lstrip(">").strip())
                i += 1
            body.append("<blockquote>%s</blockquote>" % inline(" ".join(buf)))
            continue

        # bullet list
        if bullet.match(line):
            items = []
            while i < len(lines):
                m = bullet.match(lines[i])
                if m:
                    items.append([m.group(2)])
                    i += 1
                    continue
                # An indented line continues the current item; a blank line only
                # ends the list if the line after it is not indented too.
                if items and lines[i].startswith("  ") and lines[i].strip():
                    items[-1].append(lines[i].strip())
                    i += 1
                    continue
                if (
                    items
                    and not lines[i].strip()
                    and i + 1 < len(lines)
                    and lines[i + 1].startswith("  ")
                    and lines[i + 1].strip()
                ):
                    i += 1
                    continue
                break
            rendered = []
            for chunk in items:
                images = [c for c in chunk if c.startswith("![")]
                text = " ".join(c for c in chunk if not c.startswith("!["))
                rendered.append(
                    "<li>%s%s</li>"
                    % (
                        inline(text),
                        "".join("<p>%s</p>" % inline(img) for img in images),
                    )
                )
            body.append("<ul>%s</ul>" % "".join(rendered))
            continue

        if not line.strip():
            i += 1
            continue

        # paragraph: consume until a blank line or the start of another block
        buf = []
        while (
            i < len(lines)
            and lines[i].strip()
            and not lines[i].startswith(("#", ">", "```"))
            and not lines[i].strip().startswith("|")
            and not bullet.match(lines[i])
        ):
            buf.append(lines[i].strip())
            i += 1
        if not buf:  # the line opens a block we already handle above
            buf = [lines[i].strip()]
            i += 1
        para = inline(" ".join(buf))
        # A paragraph holding nothing but an image is a figure; centre it.
        css_class = ' class="figure"' if para.startswith("<img") else ""
        body.append("<p%s>%s</p>" % (css_class, para))

    return (
        '<!doctype html><html><head><meta charset="utf-8">'
        "<title>%s</title><style>%s</style></head><body>%s</body></html>"
        % (html.escape(src.stem), CSS, "\n".join(body))
    )


def find_browser():
    for name in BROWSERS:
        path = shutil.which(name)
        if path:
            return path
    sys.exit(
        "No Chrome/Chromium found (tried: %s). Install one, or open the HTML in a\n"
        "browser and print to PDF by hand." % ", ".join(BROWSERS)
    )


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("source", type=Path, help="Markdown file to render")
    ap.add_argument(
        "-o", "--output", type=Path, help="PDF path (default: alongside the source)"
    )
    ap.add_argument(
        "--keep-html", action="store_true", help="keep the intermediate HTML and report its path"
    )
    args = ap.parse_args()

    src = args.source
    if not src.is_file():
        sys.exit("No such file: %s" % src)
    pdf = (args.output or src.with_suffix(".pdf")).resolve()

    # Chrome needs the HTML in the filesystem, and next to the source so that
    # relative image paths resolve even if a future CSS rule uses them.
    fd = tempfile.NamedTemporaryFile(
        mode="w", suffix=".html", prefix=src.stem + "-", dir=src.parent.resolve(),
        encoding="utf-8", delete=False,
    )
    tmp_html = Path(fd.name)
    with fd:
        fd.write(convert(src))

    try:
        subprocess.run(
            [
                find_browser(),
                "--headless",
                "--disable-gpu",
                "--no-sandbox",
                "--no-pdf-header-footer",
                "--print-to-pdf=%s" % pdf,
                tmp_html.as_uri(),
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
    except subprocess.CalledProcessError as exc:
        sys.exit("Chrome failed to render (exit %d)" % exc.returncode)
    finally:
        if args.keep_html:
            print("HTML: %s" % tmp_html)
        else:
            tmp_html.unlink(missing_ok=True)

    print("%s (%.0f kB)" % (pdf, pdf.stat().st_size / 1024))


if __name__ == "__main__":
    main()
