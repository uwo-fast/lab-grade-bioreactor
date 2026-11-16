# Changelog

All notable changes to this repository are documented here.

This project uses CalVer (`YYYY.MM.DD`) and follows the
[Keep a Changelog](https://keepachangelog.com) format. See
[docs/releasing.md](docs/releasing.md) for how a release is cut. History before
this file was reconstructed from the git log.

Entries are one line each, unwrapped: a section is published verbatim as the
release notes, where GitHub turns a line break into a visible one.

## [Unreleased]

## [2026.11.15]

### Added

- Zenodo DOI badge in the README, using the all-versions DOI so it resolves to the latest archived release.
- `software/` placeholder pointing at where the control software is developed for now (`anolishq/anolis-projects`, `projects/bioreactor-v2`).
- Tests for `scripts/release.sh` (`just test`), run in a throwaway repo against a stub `gh`.
- `scadman.toml` and `scadman.lock` pin `iso4796-bottle-scad` and `din168-thread-scad` at `v0.1.0`; `just setup` installs them into `.scadman/env`, which the justfile puts first on `OPENSCADPATH`.
- `just check` also renders every `scad/` file and fails on any warning (`just check-scad`).
- CI runs `just check` on OpenSCAD 2026.10.15 with the scadman-pinned libraries, and Dependabot bumps its actions monthly.
- `CITATION.cff`, for GitHub's **Cite this repository** and Zenodo, listing Cameron Brooks and Sehan Punchihewa, and an `.editorconfig`, both from the organization template.

### Changed

- Hardware files are licensed CERN-OHL-S-2.0 instead of GPL-3.0-or-later: the CAD exports and bills of materials under it alone, the OpenSCAD source under both. Scripts stay GPL-3.0-or-later. `LICENSING.md` states what applies where, and `LICENSES/` holds both texts.
- The README follows the organization template: overview and status, layout, getting started, contributing, citation, licensing and contact.
- The copyright notice in the README and `scad/bioreactor.scad` covers 2025–2026.

### Removed

- The `SPDX-License-Identifier: GPL-3.0-or-later` line in `scad/bioreactor.scad`, which named only one of the two licences `LICENSING.md` grants for `scad/`.

### Fixed

- `bom/2026-09-21/sensors.csv`: removed a leading tab from the pH range, a stray quote from the temperature range, and a trailing space from the off-gas O2 label.

## [2026.11.11]

### Added

- OpenSCAD top-level assembly (`scad/bioreactor.scad`): a Boro 3.3 5 L bottle with a GLS 80 neck thread and a GLS 80 screw cap seated on the rim.
- STEP exports of the lid top and bottom (`cad/2026-11-09/`).
- Mechanical hardware BOM (`bom/2026-07-21/`) and sensor shortlist (`bom/2026-09-21/`).
- `bom/` and `cad/` READMEs: uploads go in `YYYY-MM-DD/` folders named for the export date.
- `.gitattributes` line-ending policy and a `.gitignore`.
- This changelog, and a release process: `just release` tags `HEAD` and publishes a GitHub release from the matching changelog section (`docs/releasing.md`).

### Changed

- Relicensed under GPL-3.0-or-later.
