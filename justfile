# Project task runner

set dotenv-load := false

# Default: show available recipes
default:
    @just --list

# Format shell scripts (mutates working tree)
fmt:
    shfmt -i 2 -w scripts/*.sh tests/*.sh

# Verify formatting (non-mutating)
fmt-check:
    shfmt -i 2 -d scripts/*.sh tests/*.sh

# Lint shell scripts
lint:
    shellcheck scripts/*.sh tests/*.sh

# Format check + lint (non-mutating)
check: fmt-check lint

# Run the release script's tests in a throwaway repo
test:
    tests/release.test.sh

# Tag HEAD and publish a GitHub release from its CHANGELOG.md section (default version: today)
release *version:
    scripts/release.sh {{ version }}
