# Agent notes

Read this before touching git in this repository. The setup here is deliberately
asymmetric, and getting it wrong publishes things to the internet.

## What this is

`clean-macOS-icon-cache`: a small macOS utility that clears the system icon cache and
restarts Dock and Finder. English is the primary language of the documentation.

## Two remotes, two different jobs

| Remote | Location | Purpose |
| --- | --- | --- |
| `origin` | Synology NAS (private) | Archive of record. Everything goes here. |
| `github` | GitHub (public) | Public window. Updated only on purpose. |

Rules:

- Routine work ends with `git push`. That targets `origin` (Synology) and is always
  safe.
- Do **not** push to `github` on your own initiative: not after a feature, not after a
  bug fix, not "to keep the two in sync". Publishing is the user's decision and a
  separate, explicit step.
- Do not push all branches or mirror to GitHub (`git push --all github`,
  `git push --mirror github`), and never force-push it.
- `origin` must stay pointed at Synology. Do not make GitHub the default push target,
  and do not add a second push URL.
- The only sanctioned publish path is `scripts/publish-public.sh`, and only when the
  user explicitly asks for a public release.
- Do not rewrite history, do not delete branches or remotes, and do not create a second
  copy of the project directory.

## Never commit

- `.codex-signing/` — local commit-signing keys. Gitignored on purpose.
- `.codex-local/` — machine-specific notes (NAS host, ports, local paths). Gitignored.
- `.env*`, `credentials*`, `secrets/`, `private/`, `*.key`, `*.pem`.
- If a secret looks like it is already tracked or already in history, stop and report it.
  Do not rewrite history and do not force-push.

## Commit signing

Commits are signed with an SSH key wired up in local git config (`user.signingkey`
points into `.codex-signing/`). Verify with `git log --show-signature`; it should report
`Good "git" signature`. Keep it that way.

## Before changing git config

Run `git status`, `git remote -v` and `git branch -vv`, and report the current state
before changing anything.

## Where the details live

- Workflow, release steps, safety checks: `docs/DEVELOPMENT.md`
- Machine-specific connection details: `.codex-local/ENVIRONMENT.md` (gitignored)
- Actual remote URLs: `git remote -v` is the canonical source, always
