# Job audits

Hidden folder. Its purpose: let Claude (or Alexandre) independently audit the
scheduled jobs Robin runs that touch Alexandre's Claude account — what each
job is supposed to do, when it runs, and its last known status.

Jobs are identified by their stable id. Status snapshots are point-in-time
(as of the timestamp noted on each file); live status lives in the scheduler,
not here.

- [claude-hourly-check](claude-hourly-check.md) — hourly read-only check on the relocation-model chat
- [claude-continue-1320](claude-continue-1320.md) — one-off "Continue" sent at the credit reset
- [claude-vibecheck-chat](claude-vibecheck-chat.md) — one-off spawn of the adversarial vibe-check chat
