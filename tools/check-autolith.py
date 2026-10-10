#!/usr/bin/env python3
"""Check the Autolith product page or its permanent relocation routes.

A relocated page must have matching canonical, HTML refresh, and Vercel
redirect destinations. A local product page is checked against the Autolith
checkout's version, SBCL pin, installer platforms, and installation commands.

Usage: python3 tools/check-autolith.py [AUTOLITH-CHECKOUT]
The checkout defaults to $AUTOLITH_REPO, then ~/common-lisp/frob.
"""

import json
import os
import re
import sys
from html.parser import HTMLParser
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PAGE = ROOT / "autolith.html"

PLATFORM_LABELS = {
    "x86_64-linux": "Linux x86-64",
    "aarch64-linux": "Linux aarch64",
    "arm64-darwin": "macOS arm64",
    "x86_64-darwin": "macOS x86-64",
    "x86_64-freebsd": "FreeBSD x86-64",
    "x86_64-netbsd": "NetBSD x86-64",
    "x86_64-openbsd": "OpenBSD x86-64",
}


def repo_path() -> Path:
    if len(sys.argv) > 1:
        return Path(sys.argv[1]).expanduser()
    if os.environ.get("AUTOLITH_REPO"):
        return Path(os.environ["AUTOLITH_REPO"]).expanduser()
    return Path("~/common-lisp/frob").expanduser()


def read(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except OSError as error:
        sys.exit(f"cannot read {path}: {error}")


def repo_version(repo: Path) -> str:
    match = re.search(r':version\s+"([^"]+)"', read(repo / "autolith.asd"))
    if not match:
        sys.exit("no :version in autolith.asd")
    return match.group(1)


def repo_sbcl(repo: Path) -> str:
    return read(repo / "sbcl.version").strip()


def repo_platforms(repo: Path) -> list[str]:
    """Platform triples the installer actually accepts."""
    installer = read(repo / "script" / "install")
    triples = set()
    for match in re.finditer(r"platform=([a-z0-9_]+-[a-z]+)", installer):
        triples.add(match.group(1))
    labels = [PLATFORM_LABELS[t] for t in sorted(triples) if t in PLATFORM_LABELS]
    if not labels:
        sys.exit("no platforms recognized in script/install")
    return labels


def repo_install_commands(repo: Path) -> list[str]:
    readme = read(repo / "README.org")
    commands = []
    curl = re.search(r"(curl -fsSL \S+ \| sh)", readme)
    if curl:
        commands.append(curl.group(1))
    nix = re.search(r"(nix run github:\S+)", readme)
    if nix:
        commands.append(nix.group(1))
    if len(commands) < 2:
        sys.exit("README.org no longer lists curl and nix install commands")
    return commands


class ProductLocation(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.canonical = None
        self.refresh = None

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        attributes = dict(attrs)
        if tag == "link" and attributes.get("rel") == "canonical":
            self.canonical = attributes.get("href")
        if tag == "meta" and attributes.get("http-equiv", "").lower() == "refresh":
            content = attributes.get("content", "")
            _, separator, target = content.partition(";")
            if separator and target.strip().lower().startswith("url="):
                self.refresh = target.strip()[4:]


def check_relocation(page: str) -> bool:
    location = ProductLocation()
    location.feed(page)
    if location.refresh is None:
        return False
    destination = location.refresh
    if not destination.startswith("https://") or location.canonical != destination:
        sys.exit("relocation: canonical and HTTPS refresh destinations must agree")
    routes = json.loads(read(ROOT / "vercel.json")).get("redirects", [])
    for source in ("/autolith", "/autolith.html"):
        if not any(route.get("source") == source
                   and route.get("destination") == destination
                   and route.get("permanent") is True for route in routes):
            sys.exit(f"relocation: missing permanent {source} redirect to {destination}")
    print(f"Autolith relocation routes agree: {destination}")
    return True


def main() -> None:
    page = read(PAGE)
    if check_relocation(page):
        return
    repo = repo_path()
    if not (repo / "autolith.asd").exists():
        sys.exit(
            f"{repo} is not an Autolith checkout; "
            "pass one or set AUTOLITH_REPO"
        )
    page = re.sub(r"\s+", " ", page)

    failures = []

    def require(fact: str, needle: str) -> None:
        if re.sub(r"\s+", " ", needle) not in page:
            failures.append(f"{fact}: page is missing {needle!r}")

    version = repo_version(repo)
    require("version (JSON-LD)", f'"softwareVersion": "{version}"')
    require("SBCL pin", f"SBCL {repo_sbcl(repo)}")
    for platform in repo_platforms(repo):
        require("platform", platform)
    for command in repo_install_commands(repo):
        require("install command", command)

    if failures:
        for failure in failures:
            print(f"drift: {failure}", file=sys.stderr)
        sys.exit(1)
    print(f"autolith.html agrees with {repo} (v{version})")


if __name__ == "__main__":
    main()
