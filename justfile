# Project task runner

set dotenv-load := false

# The libraries scadman.lock pins, installed by `just setup`. First on OPENSCADPATH, so the
# pinned copy is used over any installed globally.
export OPENSCADPATH := justfile_directory() + "/.scadman/env"

# Default: show available recipes
default:
    @just --list

# Install the OpenSCAD libraries scadman.lock pins into .scadman/env (needs scadman)
setup:
    scadman sync

# Format shell scripts (mutates working tree)
fmt:
    shfmt -i 2 -w scripts/*.sh tests/*.sh

# Verify formatting (non-mutating)
fmt-check:
    shfmt -i 2 -d scripts/*.sh tests/*.sh

# Lint shell scripts
lint:
    shellcheck scripts/*.sh tests/*.sh

# Render every scad/ file against the pinned libraries, failing on any diagnostic
check-scad:
    scripts/check-scad.sh

# Format check + lint + scad render (non-mutating)
check: fmt-check lint check-scad

# Run the release script's tests in a throwaway repo
test:
    tests/release.test.sh

# Tag HEAD and publish a GitHub release from its CHANGELOG.md section (default version: today)
release *version:
    scripts/release.sh {{ version }}
