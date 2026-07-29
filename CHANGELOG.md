# Changelog

All notable changes to this project are listed here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versioning: [Semantic Versioning](https://semver.org/).

## [1.3.0] - 2026-07-29

### Changed
- Ban the word "deliberately" in chat and reports (`CLAUDE.md`, skill, style hook).
- Clarify skip reporting: only name work the user asked for that was skipped,
  with the concrete reason; never list unsolicited non-work. Skill cleanup mode
  strips unsolicited "I didn't do X" asides.
- Style hook self-test covers "deliberately" (positive match and stem non-match).

## [1.2.0] - 2026-07-29

### Added
- `CHANGELOG.md` and version note in `README.md`.

### Changed
- Version file and release tag to 1.2.0.

## [1.1.0] - 2026-07-29

### Changed
- Landed STE100 report-language work on main (PR #1).
- Version file and release tag to 1.1.0.

## [1.0.0] - 2026-07-29

### Added
- ASD-STE100 Simplified Technical English required for user reports and status.
- STE100 notes in `CLAUDE.md`, skill, `README.md`, and `LESSONS.md`.
- `VERSION` file.

[1.3.0]: https://github.com/aigorahub/stop-being-annoying-claude/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/aigorahub/stop-being-annoying-claude/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/aigorahub/stop-being-annoying-claude/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/aigorahub/stop-being-annoying-claude/releases/tag/v1.0.0
