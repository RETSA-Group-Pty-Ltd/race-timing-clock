# Sydney 300 Timing Clock Handover

## Current State

- Repo: `RETSA-Group-Pty-Ltd/race-timing-clock`
- GitHub URL: `https://github.com/RETSA-Group-Pty-Ltd/race-timing-clock`
- GitHub Pages URL: `https://retsa-group-pty-ltd.github.io/race-timing-clock/`
- Local path: `/Users/marcusrummler/AI Developer Files/New project/race-timing-clock`
- Branch: `main`
- Latest local commit at repo creation: `1e5ea8a` (`Initial race timing clock`)
- Source extracted from race-strategy-app local package after commit `8df993c` (`Prepare Winton race strategy updates`)
- Deployment target: standalone local HTML first; GitHub Pages backup/share URL.
- Current production/race-day file: `index.html`
- Event: 2026 MRA R4 / Sydney 300, Sydney Motorsport Park, Friday 12 June and Saturday 13 June 2026.

## What Changed In This Session

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
- After manual-control update, all 31 `getElementById()` references resolve.
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
- Theme matches Race Strategy Manager v1.7.19 electric blue telemetry styling.

## What Is Unfinished Or Risky

- Schedule is manually transcribed from official v2.26.06.05 event schedules. If organisers issue a newer timetable, update the `SCHEDULE` object and re-test.
- Delay and Race Control adjustment controls are manual estimates only. Official PA, Race Control, and published schedules override this clock.
- The Sydney 300 race is lap-based, so the clock shows elapsed time only. It does not know live lap count or remaining time.
- No persistence by design. Reloading resets selected day, delay, manual overrides, and done states.
- Not connected to Natsoft or live timing.

## Critical Logic To Avoid Casual Refactor

- `DAY_DATES` uses JavaScript zero-indexed months: June is `5`.
- Breaks are shown in the running order but skipped by the next on-track session countdown.
- Lap-based race handling intentionally avoids fake countdowns.
- Delay anchoring is per day using `delayMinByDay` and `delayAnchorByDay`.
- Manual Race Control sync uses `startOverridesByDay` and `completedByDay`; changes are deliberately local to the current browser session.
- RSM merge risk: this standalone file uses generic global names/classes such as `render`, `.card`, `.dot`, `.live`, and `.seg`; namespace these before folding into RSM.

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

Windows race PC:

1. Copy the `timing-clock` folder or just `index.html` from OneDrive.
2. Open `index.html` in Chrome or Edge.
3. Keep the Race Strategy App open separately.
4. Use this clock as a second-screen schedule aid only.

## Important Files

- `index.html`: complete standalone timing clock with HTML, CSS, and JavaScript.
- `HANDOVER-timing-clock.md`: this continuity document.
- Original source repo reference: `RETSA-Group-Pty-Ltd/race-strategy-app`.

## Assumptions And External Services

- No internet is required to run the timing clock once copied locally.
- OneDrive is used only as a file transfer path to the Windows race PC.
- No credentials, API keys, Natsoft feed, or build tools are required.

## Recommended Next Steps

- Copy `timing-clock/` to OneDrive `Race Day apps`.
- Open the copied file on the Windows mini PC before leaving for the event.
- Keep one extra copy on a USB stick or phone storage.
- If publishing to GitHub Pages, keep it as `/timing-clock/` and treat it as a backup, not the primary race-day runtime.
