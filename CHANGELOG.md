# Changelog

All notable changes to this repository are documented here.

This project uses CalVer (`YYYY.MM.DD`) and follows the
[Keep a Changelog](https://keepachangelog.com) format. See
[docs/releasing.md](docs/releasing.md) for how a release is cut. History before
this file was reconstructed from the git log.

Entries are one line each, unwrapped: a section is published verbatim as the
release notes, where GitHub turns a line break into a visible one.

## [Unreleased]

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
