#!/usr/bin/env python3
"""Check autolith.html against the Autolith repository's own metadata.

The page must never drift from the repository again. This script reads
the authoritative sources in an Autolith checkout and fails when the
published page disagrees with them:

  version        autolith.asd            :version
  SBCL pin       sbcl.version
  platforms      script/install          uname case arms
  providers      src/provider/builtins.lisp   register-provider forms
  default model  src/configuration/settings.lisp  *default-model*
  install        README.org              curl and nix run commands

Usage: python3 tools/check-autolith.py [AUTOLITH-CHECKOUT]
The checkout defaults to $AUTOLITH_REPO, then ~/common-lisp/frob.
Exit status 0 means the page agrees with the repository.
"""

import os
import re
import sys
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


def repo_providers(repo: Path) -> list[str]:
    """Provider description strings from the builtin registrations."""
    builtins = read(repo / "src" / "provider" / "builtins.lisp")
    descriptions = re.findall(
        r'register-provider[^)]*?:description\s+"([^"]+)"', builtins, re.S
    )
    if not descriptions:
        sys.exit("no register-provider descriptions in src/provider/builtins.lisp")
    return descriptions


def repo_default_model(repo: Path) -> str:
    settings = read(repo / "src" / "configuration" / "settings.lisp")
    match = re.search(
        r'\*default-model\*[^"]*"([^"]+)"', settings
    )
    if not match:
        sys.exit("no *default-model* in settings.lisp")
    return match.group(1)


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


def main() -> None:
    repo = repo_path()
    if not (repo / "autolith.asd").exists():
        sys.exit(
            f"{repo} is not an Autolith checkout; "
            "pass one or set AUTOLITH_REPO"
        )
    page = re.sub(r"\s+", " ", read(PAGE))

    failures = []

    def require(fact: str, needle: str) -> None:
        if re.sub(r"\s+", " ", needle) not in page:
            failures.append(f"{fact}: page is missing {needle!r}")

    version = repo_version(repo)
    require("version", f"v{version}")
    require("version (JSON-LD)", f'"softwareVersion": "{version}"')
    require("SBCL pin", f"SBCL {repo_sbcl(repo)}")
    for platform in repo_platforms(repo):
        require("platform", platform)
    for provider in repo_providers(repo):
        require("provider", provider)
    require("default model", repo_default_model(repo))
    for command in repo_install_commands(repo):
        require("install command", command)

    if failures:
        for failure in failures:
            print(f"drift: {failure}", file=sys.stderr)
        sys.exit(1)
    print(f"autolith.html agrees with {repo} (v{version})")


if __name__ == "__main__":
    main()
