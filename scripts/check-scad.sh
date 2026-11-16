#!/usr/bin/env bash
# Render every scad/*.scad file and fail on any diagnostic.
#
# --hardwarnings makes a WARNING exit non-zero. On OpenSCAD 2021.01 a DEPRECATED message
# still exits 0, so the output is searched as well, which holds on any version.
set -uo pipefail

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fail=0

for f in scad/*.scad; do
  printf '  %-28s ' "$f"
  out=$(openscad --hardwarnings -o "$tmp/out.stl" "$f" 2>&1)
  rc=$?
  if [ "$rc" -ne 0 ] || grep -qE 'ERROR:|WARNING:|DEPRECATED:' <<<"$out"; then
    echo FAIL
    grep -E 'ERROR:|WARNING:|DEPRECATED:|TRACE:' <<<"$out" | head -5 | sed 's/^/      /'
    [ "$rc" -ne 0 ] && echo "      exit $rc"
    fail=1
  else
    echo ok
  fi
done

exit "$fail"
