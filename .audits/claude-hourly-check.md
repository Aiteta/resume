# claude-hourly-check — Hourly Claude relocation-model check

- **Job id:** `claude-hourly-check`
- **Schedule:** every hour (America/New_York)
- **Owner:** goal:transition-to-cloud-and-distributed-computing-work
- **Status snapshot (2026-10-08 ~12:40 EDT):** enabled; last run 11:42 EDT succeeded; next run ~13:38 EDT.

## What it is supposed to do

Read-only hourly check of Alexandre's Claude chat "Relocation model data
completion for 18 cities". Each run re-reads the latest chat messages and
messages Alexandre ONLY if one of these is true:

1. Claude's usage credits are exhausted (ping always — include the reset time if shown),
2. the full 18-city ranking has landed,
3. Claude asked Alexandre something new.

Otherwise it stays silent — no hourly "still working" notes. It never sends
messages into the Claude chat, never spawns new chats, and never changes
schedules. If the browser looks actively in use by Alexandre, the run ends
silently without touching it.

## How to audit it

- Runs should occur roughly hourly and be read-only against the chat.
- Alexandre should receive a message only on the three trigger conditions above.
- If Alexandre gets an hourly "still working" message, or the Claude chat
  receives any message from this job, that's a failure.
