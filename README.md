# Race Timing Clock

Standalone race-day timing clock for motorsport event schedules.

This app was created for the 2026 Sydney 300 as a second-screen schedule aid beside the Race Strategy App. It is intentionally simple: one self-contained `index.html` file with no build step, no login, no backend, and no internet dependency once copied locally.

GitHub Pages backup:

```text
https://retsa-group-pty-ltd.github.io/race-timing-clock/
```

## What It Does

- Shows the current time of day.
- Counts down to the next on-track session.
- Shows the current live session and time remaining for timed sessions.
- Shows elapsed time for lap-based races where no honest time-remaining value exists.
- Highlights Sydney 300 sessions.
- Lets the crew manually adjust the schedule from Race Control / PA announcements.

## Race Control Adjustments

Select a running-order row, then use:

- `Start now`
- revised `HH:MM` start time
- `+5/-5 from here`
- `Done`
- `Clear`

Manual changes cascade from the selected row forward. Earlier rows stay as history.

## How To Run

Open `index.html` in Chrome, Edge, or another modern browser.

For race day, copy the folder locally to the race PC first, for example:

```text
C:\Race Day Apps\Race Timing Clock\index.html
```

GitHub Pages can be used as a backup/shareable version, but the local file is the recommended race-day runtime.

## Files

- `index.html` - complete standalone app.
- `HANDOVER.md` - continuity notes, verification, assumptions, and future work.
- `LICENSE` - MIT license.

## Important Caveats

- Official Race Control, PA announcements, and published results always override this clock.
- Manual schedule updates are local to the current browser session and reset on reload.
- The clock is not connected to Natsoft or live timing.
- Event schedules are manually transcribed and should be re-tested after any timetable changes.
