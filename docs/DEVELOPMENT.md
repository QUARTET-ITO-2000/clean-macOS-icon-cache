# Development and release workflow

This project keeps one working directory and two remotes with clearly separated jobs:

| Remote | Location | Contents |
| --- | --- | --- |
| `origin` | Synology NAS, private | Everything: every branch, experiment and commit. |
| `github` | GitHub, public | `main` only, published on purpose. |

The Synology side is the archive of record; GitHub is a public window onto it. They are
not mirrors of each other, and GitHub is deliberately allowed to lag behind.

Whatever `git remote -v` reports is the truth about the URLs. Machine-specific details
(NAS host, SSH port, account, key paths) are intentionally kept out of the repository in
`.codex-local/ENVIRONMENT.md`, which is gitignored.

## Daily work

```sh
git add .
git commit -m "..."
git push          # -> Synology (origin)
```

`main` tracks `origin/main`, so a bare `git push` always goes to Synology. It never
publishes to GitHub.

## Branch strategy

- Synology: `main`, plus any `develop`, `feature/*`, `fix/*`, `experiment/*`, `codex/*`.
- GitHub: `main` only, unless the user explicitly asks for more.

Never use `git push --all github` or `git push --mirror github`: that would expose every
development branch and the entire experiment history to the public repository.

## Public release

```sh
scripts/publish-public.sh          # asks for confirmation
scripts/publish-public.sh --yes    # non-interactive
```

The script is the only sanctioned way to reach GitHub. It refuses to publish unless:

1. the current branch is `main`,
2. the working tree is clean,
3. `HEAD` is not behind `origin/main`,
4. every commit is already on Synology (`HEAD` == `origin/main`),
5. no tracked file looks private (`.env*`, `credentials*`, `secrets/`, `private/`,
   `.codex-*`, `*.key`, `*.pem`, `*.p12`, `*.pfx`).

It then pushes `main` to Synology and to GitHub, in that order. The manual equivalent,
for when the script cannot be used:

```sh
git push origin main
git push github main
```

## Exposure review before publishing

Publishing is an explicit boundary crossing, so review what is about to become public:

- `git status` — nothing unexpected.
- `git log --oneline -10` — read the commit subjects the way a stranger would.
- `git diff --stat origin/main` — nothing that looks internal.
- Things that are fine locally but should not be public: signing keys, `.codex-local/`
  notes, machine paths, NAS hostnames or ports, personal scratch directories.
- `.gitignore` only prevents future commits. It cannot remove something that is already
  in history — if that happens, stop and report it instead of rewriting history or
  force-pushing.

## Commit signing

Commits and tags are signed (SSH format) with the key in `.codex-signing/`, wired up in
local git config:

```
user.signingkey            <repo>/.codex-signing/tmb_codex_signing.pub
gpg.ssh.allowedsignersfile <repo>/.codex-signing/allowed_signers
```

Both values are absolute paths, so if the project directory ever moves again, update them
or signing stops working. Verify with `git log --show-signature`.

## Setup record (2026-09-15)

Kept so later sessions do not have to rediscover it:

- The project was moved into its current directory; it previously lived in a Codex
  scratch folder. `.git`, all commits and both tags moved with it unchanged.
- The existing remote — named `origin` but pointing at GitHub — was renamed to `github`.
  No URL was guessed, deleted or overwritten.
- A bare repository was created on the Synology NAS and the full history plus the
  `v1.0.0` and `v1.1.0` tags were pushed to it. `origin` now points there and `main`
  tracks `origin/main`.
- The commit-signing key was copied from another local project into `.codex-signing/`
  and local git config was repointed at the copy, so this repository no longer depends on
  a sibling project for signing. Existing commit signatures still verify.
- `.codex-signing/` and `.codex-local/` are gitignored, and the publish script refuses to
  publish any tracked path matching `.codex-*`.
- These setup commits were pushed to Synology only. GitHub's `main` is therefore behind
  Synology's `main` by design — that gap is not a bug to fix by pushing.

## Known, harmless quirks

- `synopkg status Git` on the NAS reports `stop` (status code 263). The Synology Git
  Server package has no daemon; repositories are served by the system sshd, so a stopped
  status is expected and pushes work fine.
- The NAS sshd is OpenSSH 8.2, so newer clients print a "not using a post-quantum key
  exchange" warning on every connection. Cosmetic only.
