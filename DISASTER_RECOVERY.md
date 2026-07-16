# Race Timing Clock Disaster Recovery

Last reviewed: 2026-07-16 AEST

## Source Of Truth

- Repo: `RETSA-Group-Pty-Ltd/race-timing-clock`
- Remote: `https://github.com/RETSA-Group-Pty-Ltd/race-timing-clock.git`
- Local path: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock`
- Branch: `main`
- Latest app update commit at last DR review: `cd03358` (`Update clock for MRA R6 SuperTT`)
- Current file to run: `index.html`
- Operational handover: `HANDOVER.md`

Check the current tip after restoring:

```sh
git log -1 --oneline
git status --short --branch
git remote -v
```

## Deployment And Production Paths

- Primary race-day runtime: local standalone HTML opened directly in Chrome or Edge.
- GitHub Pages backup/share URL: `https://retsa-group-pty-ltd.github.io/race-timing-clock/`
- GitHub Actions workflow: `.github/workflows/deploy-pages.yml`
- Deployment trigger: push to `main` or manual `workflow_dispatch`.
- OneDrive race PC copy on Mac: `/Users/marcusrummler/Library/CloudStorage/OneDrive-Personal/Race Day apps/Race Timing Clock`
- Expected Windows usage: open `Race Day apps/Race Timing Clock/index.html` from the synced OneDrive folder.

## Runtime Data, Logs, Config, And State

- Runtime data: none persisted by the app.
- Runtime logs: none persisted. Local `python3 -m http.server` output is console-only.
- Config files: none outside repo.
- Environment variables: none required.
- Credentials: none required to run the app. GitHub credentials are required only to push or inspect Actions with `gh`.
- Secrets in repo: none expected. Do not add API keys, GitHub tokens, Natsoft credentials, browser profile data, or OneDrive auth material.
- User/session state: manual schedule adjustments live only in the current browser session and reset on reload.
- Current source schedule artifact: `/Users/marcusrummler/Downloads/26MRA-R6-EventSchedule(v2.26.07.10).pdf` if still present locally.

## Scheduled Jobs And External Services

- Local scheduled jobs: none known. No launchd, cron, systemd, or background service is required.
- GitHub scheduled jobs: none. GitHub Pages deploy runs on push/manual dispatch only.
- External services:
  - GitHub repository and Actions.
  - GitHub Pages.
  - OneDrive for race-day file transfer.
  - Notion only as optional continuity notes.
  - Natsoft is not integrated.

## Required Tools

Minimum to run:

- Chrome, Edge, or another modern browser.

Minimum to restore and continue:

- `git`
- Text editor or AI coding tool
- Browser

Useful local tools:

- `python3` for local preview server.
- `gh` for GitHub Actions/Pages status checks.
- `tar`, `rsync`, and `git bundle` for disaster-recovery backup archives.

Mac install examples:

```sh
xcode-select --install
brew install gh
```

Windows install examples:

```powershell
winget install Git.Git
winget install Python.Python.3
winget install GitHub.cli
```

## Restore From GitHub

```sh
git clone https://github.com/RETSA-Group-Pty-Ltd/race-timing-clock.git
cd race-timing-clock
git status --short --branch
python3 -m http.server 8765
```

Open:

```text
http://localhost:8765/
```

For offline race-day use, open `index.html` directly in Chrome or Edge.

## Restore From Backup Archive

1. Unpack the archive created by `scripts/backup-disaster-recovery.sh`.
2. Read `manifest.txt`, `git-status.txt`, and `git-log.txt`.
3. Use `source/` as the working copy if GitHub is unavailable.
4. If the remote repo is unavailable but the bundle exists, restore with:

```sh
git clone race-timing-clock.bundle race-timing-clock
cd race-timing-clock
git status --short --branch
```

5. Recreate the OneDrive race PC copy by syncing the restored repo folder to `Race Day apps/Race Timing Clock`.
6. Open `index.html` locally and run the validation checklist below.

## Backup Procedure

Run from the repo:

```sh
./scripts/backup-disaster-recovery.sh
```

Default archive location:

```text
./backups/race-timing-clock-disaster-recovery-YYYYmmdd-HHMMSS.tar.gz
```

The archive is sensitive if it includes OneDrive files or external schedule PDFs. Keep it private.

You can override locations:

```sh
BACKUP_DIR=/path/to/private/backups ./scripts/backup-disaster-recovery.sh
ONEDRIVE_COPY="/path/to/Race Timing Clock" ./scripts/backup-disaster-recovery.sh
SCHEDULE_PDF="/path/to/schedule.pdf" ./scripts/backup-disaster-recovery.sh
```

## Latest Test Backup

- Test run: 2026-07-16 12:26 Australia/Sydney.
- Archive: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock/backups/race-timing-clock-disaster-recovery-20260716-122621.tar.gz`
- Contents index: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock/backups/race-timing-clock-disaster-recovery-20260716-122621.tar.gz.contents.txt`
- Archive size: about 493 KiB.
- Verified contents:
  - `source/` with repo files including `index.html`, `HANDOVER.md`, `DISASTER_RECOVERY.md`, and backup script
  - `git/race-timing-clock.bundle`
  - `git/git-status.txt`, `git/git-log.txt`, `git/git-remotes.txt`
  - `onedrive-race-day-copy/` with synced Round 6 race-day files
  - `external-artifacts/26MRA-R6-EventSchedule(v2.26.07.10).pdf`
  - `environment.example`
  - `runtime-state.txt`
  - `scheduled-jobs.txt`

Historical test backup:

- Test run: 2026-07-09 19:53 Australia/Sydney.
- Archive: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock/backups/race-timing-clock-disaster-recovery-20260709-195333.tar.gz`
- Contents index: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock/backups/race-timing-clock-disaster-recovery-20260709-195333.tar.gz.contents.txt`
- Archive size: about 51 KiB.
- Verified contents:
  - `source/` with repo files including `index.html`, `HANDOVER.md`, `DISASTER_RECOVERY.md`, and backup script
  - `git/race-timing-clock.bundle`
  - `git/git-status.txt`, `git/git-log.txt`, `git/git-remotes.txt`
  - `onedrive-race-day-copy/` with synced race-day files
  - `environment.example`
  - `runtime-state.txt`
  - `scheduled-jobs.txt`
- Source schedule PDF was not found at `/Users/marcusrummler/Downloads/26MRA-R5-EventSchedule(v1.26.07.02).pdf`; the backup contains `external-artifacts.NOT_FOUND.txt`.

## Validation Checklist

- `index.html` opens in Chrome or Edge.
- Header shows the intended event/category.
- Running order count matches the current schedule.
- Target category rows are highlighted correctly.
- Next-session countdown skips breaks.
- Live timed session shows remaining time.
- Lap-based future events show elapsed time rather than fake remaining time.
- Manual Race Control controls work:
  - select row
  - `Start now`
  - revised `HH:MM`
  - `+5/-5 from here`
  - `Done`
  - `Clear`
- Reload resets manual adjustments by design.
- Public backup URL serves the expected title after deploy.
- OneDrive race PC copy opens locally without internet.

## Critical Logic Not To Refactor Casually

- `DAY_DATES` uses JavaScript zero-indexed months.
- Break rows are visible in the running order but excluded from next on-track countdown.
- Manual schedule changes cascade from the selected row forward only.
- `completedByDay` can skip a session without deleting it from the running order.
- Lap-based race mode intentionally avoids fake remaining-time countdowns.
- Target-category highlighting uses `isTarget`, `.target`, and `.badgeTarget`.
- Standalone global names/classes are not namespaced for embedding inside another app.

## Known Risks

- Event schedules are manually transcribed and must be rechecked after timetable changes.
- Manual adjustments are not persisted; a page reload clears them.
- No Natsoft or live timing connection.
- GitHub Pages is a backup only; race-day reliability should come from local files.
- OneDrive sync delay can leave the Windows laptop on an older file if not checked before leaving.
- GitHub Actions may warn about upstream action runtime deprecations; treat failed deploys as actionable, warnings as review items.

## Recommended Resilience Next Steps

- Keep a dated ZIP/TAR backup on OneDrive and one offline USB stick before each event.
- Add a tiny built-in schedule version label to the UI if this app is reused frequently.
- Add optional localStorage persistence only if race-day operators need reload recovery.
- Store source event PDFs in a repo-excluded `artifacts/` or external private backup folder.
- Review `.github/workflows/deploy-pages.yml` yearly for action version deprecations.
