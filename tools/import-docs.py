"""Import an Org guide into new Lisp chapter files without overwriting edits."""

import argparse
from html.parser import HTMLParser
from pathlib import Path
import subprocess


class GuideHTML(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.nodes = []
        self.stack = []

    def handle_starttag(self, tag, attrs):
        node = (tag, attrs, [])
        self.append(node)
        if tag != 'br':
            self.stack.append(node)

    def handle_endtag(self, tag):
        if not self.stack or self.stack.pop()[0] != tag:
            raise ValueError(f'Mismatched guide element: {tag}')

    def handle_data(self, data):
        if self.stack or data.strip():
            self.append(data)

    def append(self, node):
        target = self.stack[-1][2] if self.stack else self.nodes
        if target and isinstance(node, str) and isinstance(target[-1], str):
            target[-1] += node
        else:
            target.append(node)


def literal(text):
    return '"' + text.replace('\\', '\\\\').replace('"', '\\"') + '"'


def form(node, level=0):
    if isinstance(node, str):
        return literal(node)
    tag, attrs, children = node
    attributes = ' '.join(f':{key} {literal(value)}' for key, value in attrs)
    start = f'(:{tag} ({attributes})' if attrs else f'(:{tag} nil'
    if not children:
        return start + ')'
    if tag in {'div', 'ol', 'table', 'tbody', 'thead', 'tr', 'ul'}:
        pad = '\n' + '  ' * (level + 1)
        return start + pad + pad.join(form(child, level + 1) for child in children) + ')'
    return start + ' ' + ' '.join(form(child, level + 1) for child in children) + ')'


def read_guide(source):
    tools = Path(__file__).resolve().parent
    html = subprocess.check_output([
        'pandoc', '--from=org', '--to=html5', '--wrap=none', '--highlight-style=pygments',
        f'--lua-filter={tools / "pandoc-autolith.lua"}', str(source),
    ], encoding='utf-8')
    parser = GuideHTML()
    parser.feed(html)
    parser.close()
    if parser.stack:
        raise ValueError('Unclosed element in the guide')
    chapters = {}
    for node in parser.nodes:
        if not isinstance(node, str) and node[0] == 'h1':
            slug = dict(node[1])['id']
            if not slug or any(c not in 'abcdefghijklmnopqrstuvwxyz-0123456789' for c in slug):
                raise ValueError(f'Invalid chapter slug: {slug}')
            if slug in chapters or slug == 'index':
                raise ValueError(f'Duplicate or reserved chapter slug: {slug}')
            chapters[slug] = []
        if chapters:
            list(chapters.values())[-1].append(node)
    if not chapters:
        raise ValueError('The guide has no chapters')
    return chapters


def main():
    cli = argparse.ArgumentParser(description=__doc__)
    cli.add_argument('org_source', type=Path)
    cli.add_argument('output_directory', type=Path)
    args = cli.parse_args()
    chapters = read_guide(args.org_source)
    output = args.output_directory
    output.mkdir(parents=True, exist_ok=True)
    if any(output.iterdir()):
        cli.error('Choose an empty output directory and review before replacing site copy')
    for slug, nodes in chapters.items():
        (output / f'{slug}.sexp').write_text(
            '\n\n'.join(form(node) for node in nodes) + '\n', encoding='utf-8',
        )
    manifest = '(\n' + ''.join(f' {literal(slug)}\n' for slug in chapters) + ')\n'
    (output / 'index.sexp').write_text(manifest, encoding='utf-8')
    print(f'Imported {len(chapters)} chapters into {output}.')


if __name__ == '__main__':
    main()
