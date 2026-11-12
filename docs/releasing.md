# Releasing

Releases are CalVer snapshots of the design files: `YYYY.MM.DD`, month and day
zero-padded, dated by the day the release is cut. A second release on the same
day takes a counter: `YYYY.MM.DD.1`. Tags are the bare version, with no `v`
prefix.

## Between releases

Add an entry under `## [Unreleased]` in [CHANGELOG.md](../CHANGELOG.md) in the
same change it describes, under `Added`, `Changed`, `Deprecated`, `Removed`,
`Fixed` or `Security`.

## Cutting a release

You need `just`, `git` and an authenticated `gh`.

1. In `CHANGELOG.md`, rename `## [Unreleased]` to `## [YYYY.MM.DD]` and put a
   new, empty `## [Unreleased]` heading above it.
2. Commit that as `chore(release): YYYY.MM.DD` and get it onto `main`.
3. On `main`, in sync with `origin/main`, run:

   ```sh
   just release              # today's date
   just release 2026.11.11.1 # or a named version
   ```

`just release` refuses to run unless `HEAD` is `origin/main`, the tag is new,
and `CHANGELOG.md` at `HEAD` has a non-empty section for the version. It then
creates an annotated tag, pushes it, and publishes a GitHub release with that
changelog section as its notes.
