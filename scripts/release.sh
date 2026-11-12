#!/usr/bin/env bash
# Tag HEAD with a CalVer version and publish a GitHub release whose notes are
# that version's section of CHANGELOG.md. See docs/releasing.md.
set -euo pipefail

die() {
  echo "release: $*" >&2
  exit 1
}

version="${1:-$(date +%Y.%m.%d)}"
[[ $version =~ ^[0-9]{4}\.[0-9]{2}\.[0-9]{2}(\.[0-9]+)?$ ]] ||
  die "'$version' is not YYYY.MM.DD or YYYY.MM.DD.MICRO"

cd "$(git rev-parse --show-toplevel)"

[[ $(git symbolic-ref --short HEAD) == main ]] || die "not on main"
git fetch --quiet origin main
[[ $(git rev-parse HEAD) == "$(git rev-parse origin/main)" ]] ||
  die "HEAD is not origin/main; push or pull first"
if git rev-parse --quiet --verify "refs/tags/$version" >/dev/null; then
  die "tag $version already exists"
fi

# The notes come from the committed changelog, since the tag is of HEAD.
notes=$(mktemp)
trap 'rm -f "$notes"' EXIT
git show HEAD:CHANGELOG.md |
  awk -v h="## [$version]" '$0 == h { on = 1; next } /^## \[/ { on = 0 } on' >"$notes"
grep -q '[^[:space:]]' "$notes" ||
  die "CHANGELOG.md at HEAD has no '## [$version]' section with content"

git tag --annotate "$version" --message "$version"
git push origin "$version"
gh release create "$version" --title "$version" --notes-file "$notes" --verify-tag
