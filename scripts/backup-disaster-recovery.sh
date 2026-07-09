#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_NAME="race-timing-clock"
STAMP="$(date +"%Y%m%d-%H%M%S")"
BACKUP_DIR="${BACKUP_DIR:-"$REPO_ROOT/backups"}"
ONEDRIVE_COPY="${ONEDRIVE_COPY:-"$HOME/Library/CloudStorage/OneDrive-Personal/Race Day apps/Race Timing Clock"}"
SCHEDULE_PDF="${SCHEDULE_PDF:-"$HOME/Downloads/26MRA-R5-EventSchedule(v1.26.07.02).pdf"}"

ARCHIVE_NAME="$APP_NAME-disaster-recovery-$STAMP.tar.gz"
STAGE="$BACKUP_DIR/$APP_NAME-disaster-recovery-$STAMP"
ARCHIVE="$BACKUP_DIR/$ARCHIVE_NAME"

mkdir -p "$STAGE"

cd "$REPO_ROOT"

{
  echo "App: $APP_NAME"
  echo "Created: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo "Repo root: $REPO_ROOT"
  echo "Branch: $(git branch --show-current 2>/dev/null || echo unknown)"
  echo "Commit: $(git rev-parse --short HEAD 2>/dev/null || echo unknown)"
  echo "Remote:"
  git remote -v 2>/dev/null || true
  echo
  echo "Contents:"
  echo "- source/: repo working tree without .git/backups/.DS_Store"
  echo "- git/: git status, log, remotes, and bundle when available"
  echo "- onedrive-race-day-copy/: synced race PC copy when present"
  echo "- external-artifacts/: source schedule PDF when present"
  echo "- environment.example: secret placeholders and env notes"
  echo "- runtime-state.txt: app runtime state notes"
  echo "- scheduled-jobs.txt: scheduled job notes"
} > "$STAGE/manifest.txt"

mkdir -p "$STAGE/source"
rsync -a \
  --exclude ".git" \
  --exclude ".DS_Store" \
  --exclude "backups" \
  "$REPO_ROOT"/ "$STAGE/source"/

mkdir -p "$STAGE/git"
git status --short --branch > "$STAGE/git/git-status.txt" 2>&1 || true
git log -20 --oneline --decorate > "$STAGE/git/git-log.txt" 2>&1 || true
git remote -v > "$STAGE/git/git-remotes.txt" 2>&1 || true
git bundle create "$STAGE/git/$APP_NAME.bundle" --all >/dev/null 2>&1 || true

if [ -d "$ONEDRIVE_COPY" ]; then
  mkdir -p "$STAGE/onedrive-race-day-copy"
  rsync -a \
    --exclude ".git" \
    --exclude ".DS_Store" \
    --exclude "backups" \
    "$ONEDRIVE_COPY"/ "$STAGE/onedrive-race-day-copy"/
else
  echo "OneDrive race-day copy not found at: $ONEDRIVE_COPY" > "$STAGE/onedrive-race-day-copy.NOT_FOUND.txt"
fi

if [ -f "$SCHEDULE_PDF" ]; then
  mkdir -p "$STAGE/external-artifacts"
  cp "$SCHEDULE_PDF" "$STAGE/external-artifacts/"
else
  echo "Schedule PDF not found at: $SCHEDULE_PDF" > "$STAGE/external-artifacts.NOT_FOUND.txt"
fi

cat > "$STAGE/environment.example" <<'ENVEOF'
# Race Timing Clock environment
# No environment variables are required to run the app.
# Do not store GitHub tokens, OneDrive credentials, Natsoft credentials, or browser profile data here.

GITHUB_TOKEN=
NOTION_TOKEN=
NATSOFT_API_KEY=
ENVEOF

cat > "$STAGE/runtime-state.txt" <<'STATEEOF'
Runtime data: none persisted by the app.
Manual Race Control adjustments are in-memory browser state and reset on reload.
Logs: none persisted; local preview server logs are console-only.
Database: none.
Backend: none.
STATEEOF

cat > "$STAGE/scheduled-jobs.txt" <<'JOBEOF'
Local launchd/cron/system jobs: none required for this app.
GitHub Actions: .github/workflows/deploy-pages.yml deploys GitHub Pages on push to main or workflow_dispatch.
JOBEOF

tar -czf "$ARCHIVE" -C "$BACKUP_DIR" "$(basename "$STAGE")"
tar -tzf "$ARCHIVE" > "$ARCHIVE.contents.txt"

echo "Backup archive created:"
echo "$ARCHIVE"
echo
echo "Archive contents index:"
echo "$ARCHIVE.contents.txt"
