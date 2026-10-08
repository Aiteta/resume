# claude-continue-1320 — Send Claude continuation at credit reset

- **Job id:** `claude-continue-1320`
- **Schedule:** one-off, 2026-10-08 13:20 EDT (America/New_York)
- **Owner:** goal:transition-to-cloud-and-distributed-computing-work
- **Status snapshot (2026-10-08 ~12:40 EDT):** enabled; has not run yet; fires at 13:20 EDT.

## What it is supposed to do

At the moment Alexandre's Claude Pro credits reset (~1:20 PM EDT Oct 8, when
the relocation-model work stalled waiting on credits), send exactly the word
`Continue` as Alexandre's own message in the "Relocation model data
completion for 18 cities" chat — but ONLY if credits are actually back and
Claude has not already resumed on its own.

Safety rules: check read-only first; if credits are still exhausted, reschedule
itself ~30 minutes later instead of sending or dropping the work; if Alexandre
is actively using the browser, back off and retry in 20 minutes; never send
anything other than the single word `Continue`.

## How to audit it

- After 13:20 EDT, the chat should contain at most one new `Continue` message
  from Alexandre, sent only if credits had returned and Claude was still idle.
- If credits were still out, the job should have rescheduled itself, not sent.
- Any other message sent into the chat by this job is a failure.
