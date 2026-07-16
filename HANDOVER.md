# Race Timing Clock Handover

## Current State

- Repo: `RETSA-Group-Pty-Ltd/race-timing-clock`
- GitHub URL: `https://github.com/RETSA-Group-Pty-Ltd/race-timing-clock`
- GitHub Pages URL: `https://retsa-group-pty-ltd.github.io/race-timing-clock/`
- Local path: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock`
- OneDrive race PC copy: `/Users/marcusrummler/Library/CloudStorage/OneDrive-Personal/Race Day apps/Race Timing Clock`
- Branch: `main`
- Latest repo commit before Round 6 update: `5b1994e` (`Add disaster recovery pack`)
- Latest app update commit: `cd03358` (`Update clock for MRA R6 SuperTT`)
- Latest repo commit: run `git log -1 --oneline` locally; handover-only commits may follow the app update commit.
- Source extracted from race-strategy-app local package after commit `8df993c` (`Prepare Winton race strategy updates`)
- Deployment target: standalone local HTML first; GitHub Pages backup/share URL.
- GitHub Pages status at publish: built and returning `index.html`.
- Current production/race-day file: `index.html`
- Current event: 2026 MRA Series Round 6, One Raceway - Wakefield Circuit, Saturday 8 August 2026.
- Target category: Oztrack SuperTT.
- Current schedule source: `/Users/marcusrummler/Downloads/26MRA-R6-EventSchedule(v2.26.07.10).pdf`.

## What Changed In This Session

MRA Round 6 / Oztrack SuperTT update - 2026-07-16:

- Extracted official Round 6 schedule from `26MRA-R6-EventSchedule(v2.26.07.10).pdf`.
- Updated visible title/subtitle to `MRA R6 Timing Clock` / `OZTRACK SUPERTT - ONE RACEWAY - SATURDAY 8 AUGUST 2026`.
- Replaced the schedule data with 21 timed rows for Saturday 8 August 2026.
- Highlighted Oztrack SuperTT rows with `TT` badges:
  - Q4 10:00 qualifying
  - R4 11:40 race 1
  - R9 13:56 race 2
  - R14 15:55 race 3
- Updated README and disaster-recovery schedule PDF defaults for Round 6.
- The PDF lists `Drivers Briefings (as per Further Regulations)` without a fixed time row, so driver briefing is not included in the countdown schedule.
- Copied Round 6 files to OneDrive `Race Day apps/Race Timing Clock` for Windows mini PC sync.
- Test backup created at `backups/race-timing-clock-disaster-recovery-20260716-122621.tar.gz` and inspected.
- Test archive included source, git bundle, git metadata, OneDrive race-day copy, env/runtime/job notes, contents index, and the Round 6 source PDF.

Disaster Recovery Pack - 2026-07-09:

- Added `DISASTER_RECOVERY.md` as the repo-local recovery source of truth.
- Added `scripts/backup-disaster-recovery.sh` to create a sensitive local recovery archive.
- Updated `.gitignore` so generated `backups/` archives are not committed.
- Recovery pack documents repo, branch, remotes, Pages deployment, OneDrive race PC copy, runtime state, logs, env assumptions, scheduled jobs, external services, validation, and restore flow.
- Test backup created at `backups/race-timing-clock-disaster-recovery-20260709-195333.tar.gz` and inspected.
- Test archive included source, git bundle, git metadata, OneDrive race-day copy, env/runtime/job notes, and a contents index.
- Source schedule PDF was not present in Downloads during the test; backup recorded `external-artifacts.NOT_FOUND.txt`.

MRA Round 5 / Oztrack SuperTT update:

- Updated the clock from the Sydney 300 schedule to the MRA Round 5 Sunday schedule.
- Updated visible title/subtitle to `MRA R5 Timing Clock` / `OZTRACK SUPERTT - SMP - SUNDAY 5 JULY 2026`.
- Replaced the schedule data with 19 rows from event schedule version `1.26.07.02`.
- Highlighted Oztrack SuperTT rows with a `TT` badge.
- Removed stale Sydney 300 labels from `index.html`.

## Historical Sydney 300 Setup

- Created final standalone race-day clock package.
- Rebuilt the final HTML as `index.html` for easy Windows use and future GitHub Pages use.
- Removed stale Wakefield/v0.1 metadata and comments.
- Updated visible title/subtitle to Sydney 300 / SMP / MRA R4 / 12-13 June 2026.
- Fixed Fri/Sat segmented control so the active button follows the auto-selected day.
- Changed delay handling to be per-day and anchored from the moment delay is first applied, so it pushes later sessions without rewriting already-started sessions.
- Kept the clock standalone; Race Strategy App v1.7.19 was not folded into or altered.

## Post-Race Update - Manual Race Control Sync

- Added a `Race Control adjustments` panel after Sydney 300 race-day feedback.
- Running-order rows are now selectable.
- Selected rows can be:
  - anchored to the current time with `Start now`
  - manually set to a new `HH:MM` start time
  - shifted plus or minus 5 minutes from that row onward
  - marked `Done` so the next-session countdown skips them
  - restored by clearing manual changes for the selected day
- Manual time changes cascade from the selected row forward and preserve earlier rows as history.
- This is intentionally PA/Race Control driven. Natsoft integration is not required for the primary recovery workflow.

## What Is Working And Verified

- JS syntax check passed.
- All `getElementById()` references resolve to IDs present in `index.html`.
- Simulated MRA R6 / Oztrack SuperTT states passed for:
  - 2026-07-16 pre-event countdown to Saturday.
  - 2026-08-08 09:59 countdown to Oztrack SuperTT qualifying.
  - 2026-08-08 10:01 live Oztrack SuperTT qualifying.
  - 2026-08-08 11:41 live Oztrack SuperTT Race 1.
  - 2026-08-08 13:57 live Oztrack SuperTT Race 2.
  - 2026-08-08 15:56 live Oztrack SuperTT Race 3.
  - 2026-08-08 16:45 day complete.
- Manual-control simulation passed:
  - selecting Saturday R9 Oztrack SuperTT
  - setting R9 from 13:56 to 14:05
  - confirming downstream sessions cascade through R14 16:04 and R15 16:29
- OneDrive copy check passed for Round 6 title and Oztrack SuperTT target rows.

Historical MRA R5 verification retained for context:

- Simulated MRA R5 / Oztrack SuperTT states passed for:
  - 2026-07-03 pre-event countdown to Sunday.
  - 2026-07-05 08:49 countdown to Oztrack SuperTT qualifying.
  - 2026-07-05 08:51 live Oztrack SuperTT qualifying with 19 minutes left.
  - 2026-07-05 10:31 live Oztrack SuperTT Race 1.
  - 2026-07-05 12:39 live Oztrack SuperTT Race 2.
  - 2026-07-05 14:17 live Oztrack SuperTT Race 3.
  - 2026-07-05 16:05 day complete.
- Manual-control simulation passed:
  - selecting Sunday R6 Oztrack SuperTT
  - setting R6 from 12:38 to 12:50
  - confirming the selected row shows the revised time and downstream sessions cascade
Historical browser preview for R5 passed on `http://localhost:8767/`:
  - title `MRA R5 Timing Clock - Oztrack SuperTT`
  - 19 running-order rows
  - one `Sun 5` day selector
  - four Oztrack SuperTT target rows highlighted with `TT`
  - no console errors
- Copied updated race-day files to OneDrive `Race Day apps/Race Timing Clock` for Windows mini PC sync.
- Theme matches Race Strategy Manager v1.7.19 electric blue telemetry styling.

Historical Sydney 300 verification retained for context:

- Simulated schedule states passed for:
  - 2026-06-11 pre-event countdown to Friday practice.
  - 2026-06-12 18:29 before Friday practice.
  - 2026-06-12 18:31 during Friday practice.
  - 2026-06-13 09:12 during Sydney 300 Group 1 practice.
  - 2026-06-13 10:16 during Excels qualifying while Sydney 300 briefing is listed as a break.
  - 2026-06-13 19:31 during the Sydney 300 race, showing elapsed time rather than false time remaining.
- Manual-control simulations passed:
  - selecting Saturday R3
  - setting R3 from 13:00 to 13:20
  - confirming Q5 cascades from 14:25 to 14:45
  - marking R3 done so the next-session countdown skips to R4

## What Is Unfinished Or Risky

- Schedule is manually transcribed from official R6 event schedule v2.26.07.10. If organisers issue a newer timetable, update the `SCHEDULE` object and re-test.
- Driver briefings are not timed in the PDF schedule; follow Further Regulations, PA, and Race Control for briefing timing.
- Delay and Race Control adjustment controls are manual estimates only. Official PA, Race Control, and published schedules override this clock.
- Current R6 sessions are time-boxed. The lap-based elapsed-only path remains in code for future events but is not used by the current schedule.
- No persistence by design. Reloading resets selected day, delay, manual overrides, and done states.
- Not connected to Natsoft or live timing.

## Critical Logic To Avoid Casual Refactor

- `DAY_DATES` uses JavaScript zero-indexed months: August is `7`.
- Breaks are shown in the running order but skipped by the next on-track session countdown.
- Lap-based race handling intentionally avoids fake countdowns.
- Delay anchoring is per day using `delayMinByDay` and `delayAnchorByDay`.
- Manual Race Control sync uses `startOverridesByDay` and `completedByDay`; changes are deliberately local to the current browser session.
- Target-category highlighting uses `isTarget`, `.target`, and `.badgeTarget`.
- RSM merge risk: this standalone file still uses generic global names/classes such as `render`, `.card`, `.dot`, `.live`, and `.seg`; namespace these before folding into another app.

## Commands And Test Steps

Preview locally from the repo:

```sh
cd "/Users/marcusrummler/AI Developer Files/New project/race-timing-clock"
python3 -m http.server 8765
```

Open:

```text
http://localhost:8765/
```

Create a disaster-recovery backup archive:

```sh
cd "/Users/marcusrummler/AI Developer Files/New project/race-timing-clock"
./scripts/backup-disaster-recovery.sh
```

Default backup output:

```text
backups/race-timing-clock-disaster-recovery-YYYYmmdd-HHMMSS.tar.gz
backups/race-timing-clock-disaster-recovery-YYYYmmdd-HHMMSS.tar.gz.contents.txt
```

Treat generated backups as sensitive if they include OneDrive copies or source PDFs.

Windows race PC:

1. Open the OneDrive-synced `Race Day apps/Race Timing Clock/index.html`.
2. Open `index.html` in Chrome or Edge.
3. Keep the Race Strategy App open separately.
4. Use this clock as a second-screen schedule aid only.

## Important Files

- `index.html`: complete standalone timing clock with HTML, CSS, and JavaScript.
- `HANDOVER.md`: this continuity document.
- `DISASTER_RECOVERY.md`: restore, backup, deployment, tooling, and validation checklist.
- `scripts/backup-disaster-recovery.sh`: creates local recovery archives under `backups/`.
- Original source repo reference: `RETSA-Group-Pty-Ltd/race-strategy-app`.

## Assumptions And External Services

- No internet is required to run the timing clock once copied locally.
- OneDrive is used only as a file transfer path to the Windows race PC.
- No credentials, API keys, Natsoft feed, or build tools are required.

## Recommended Next Steps

- Copy `race-timing-clock/` to OneDrive `Race Day apps`.
- Open the copied file on the Windows mini PC before leaving for the event.
- Keep one extra copy on a USB stick or phone storage.
- If publishing to GitHub Pages, use the existing `race-timing-clock` Pages site and treat it as a backup, not the primary race-day runtime.
