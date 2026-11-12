#!/usr/bin/env bash
# Exercise scripts/release.sh against a throwaway repo, a local bare origin and
# a stub gh that records its arguments. Nothing leaves the temp directory.
# Usage: tests/release.test.sh [path/to/release.sh]
set -uo pipefail

script=$(realpath "${1:-$(dirname "$0")/../scripts/release.sh}")
root=$(mktemp -d) || exit 1
trap 'rm -rf "$root"' EXIT

mkdir "$root/bin"
# shellcheck disable=SC2016 # the stub's own variables, expanded when it runs
printf '%s\n' '#!/bin/sh' 'echo "gh $*" >>"$GH_LOG"' \
  'for a; do [ -f "$a" ] && cat "$a" >>"$GH_LOG"; done' \
  'exit 0' >"$root/bin/gh"
chmod +x "$root/bin/gh"
export PATH="$root/bin:$PATH" GH_LOG="$root/gh.log"
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=/dev/null
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@example.invalid
export GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@example.invalid

git init -q --bare -b main "$root/origin.git"
git init -q -b main "$root/work"
cd "$root/work" || exit 1
git remote add origin "$root/origin.git"
mkdir scripts && cp "$script" scripts/release.sh
printf '%s\n' '# Changelog' '' '## [Unreleased]' '' '## [2026.11.11]' '' \
  '### Added' '' '- first thing' '' '## [2026.11.10]' '' '- older thing' '' \
  '## [2026.11.09]' '' >CHANGELOG.md
git add -A && git commit -q -m init && git push -q origin main

failed=0
fail() {
  echo "FAIL $1"
  failed=1
}

# label, expected exit, expected text in the last line of output, args...
run() {
  local label=$1 want=$2 text=$3 out rc
  shift 3
  out=$(scripts/release.sh "$@" 2>&1)
  rc=$?
  if [[ $rc -eq $want && $(tail -n 1 <<<"$out") == *"$text"* ]]; then
    echo "ok   $label"
  else
    fail "$label: exit $rc (want $want): $(tail -n 1 <<<"$out")"
  fi
}

run "rejects a v prefix" 1 "is not YYYY.MM.DD" v2026.11.11
run "rejects an unpadded day" 1 "is not YYYY.MM.DD" 2026.11.1
run "rejects a version with no changelog section" 1 "has no '## [2026.11.12]'" 2026.11.12
run "rejects an empty changelog section" 1 "has no '## [2026.11.09]'" 2026.11.09
git switch -q -c side
run "rejects a branch other than main" 1 "not on main" 2026.11.11
git switch -q main
git commit -q --allow-empty -m local-only
run "rejects a HEAD ahead of origin" 1 "HEAD is not origin/main" 2026.11.11
git reset -q --hard origin/main
# An uncommitted entry in the section must not reach the notes.
sed -i 's/^- first thing$/&\n- uncommitted thing/' CHANGELOG.md
run "releases, reading the changelog from HEAD" 0 "" 2026.11.11
git checkout -q CHANGELOG.md
run "rejects an existing tag" 1 "already exists" 2026.11.11

[[ $(git cat-file -t 2026.11.11 2>/dev/null) == tag ]] || fail "tag is not annotated"
git ls-remote --exit-code --tags origin refs/tags/2026.11.11 >/dev/null ||
  fail "tag did not reach origin"
want_log=$'gh release create 2026.11.11 --title 2026.11.11 --notes-file\n\n### Added\n\n- first thing'
got_log=$(sed -E '1s/ --notes-file .*/ --notes-file/' "$GH_LOG")
[[ $got_log == "$want_log" ]] || fail "gh call or notes differ: $got_log"

exit "$failed"
