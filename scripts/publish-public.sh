#!/bin/sh
#
# Publish the public branch to GitHub.
#
# This repository has two remotes with two different jobs:
#   origin  -> Synology: the archive of record. Everything goes here.
#   github  -> GitHub:   the public window. Only updated on purpose.
#
# Day to day work is just:  git add . && git commit && git push   (-> Synology)
# This script is the only sanctioned path to GitHub.
#
# Usage:
#   scripts/publish-public.sh           prompts before pushing
#   scripts/publish-public.sh --yes     no prompt, for non-interactive use
#
set -eu

private_remote=origin
public_remote=github
branch=main
assume_yes=no

if [ "${1:-}" = "--yes" ]; then
	assume_yes=yes
fi

fail() {
	printf '%s\n' "$*" >&2
	exit 1
}

cd "$(git rev-parse --show-toplevel)"

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "$branch" ]; then
	fail "Refusing to publish: on branch '$current_branch', expected '$branch'."
fi

if [ -n "$(git status --porcelain)" ]; then
	git status --short >&2
	fail "Refusing to publish: working tree is not clean."
fi

echo "Fetching $private_remote..."
git fetch --quiet "$private_remote"

if ! git rev-parse --verify --quiet "refs/remotes/$private_remote/$branch" >/dev/null; then
	fail "Refusing to publish: $private_remote/$branch does not exist yet. Run 'git push' first."
fi

behind=$(git rev-list --count "HEAD..$private_remote/$branch")
ahead=$(git rev-list --count "$private_remote/$branch..HEAD")

if [ "$behind" -gt 0 ]; then
	fail "Refusing to publish: HEAD is behind $private_remote/$branch by $behind commit(s). Reconcile first."
fi

if [ "$ahead" -gt 0 ]; then
	fail "Refusing to publish: $ahead commit(s) are not on Synology yet. Run 'git push' first."
fi

private_files=$(git ls-files | grep -Ei '(^|/)(\.env|credentials|secrets|private|\.codex-[^/]*)([./]|$)|\.(key|pem|p12|pfx)$' || true)
if [ -n "$private_files" ]; then
	printf '%s\n' "$private_files" >&2
	fail "Refusing to publish: the files above look private. Review them first."
fi

echo
echo "About to publish these commits to $public_remote/$branch:"
git --no-pager log --oneline -10
echo

if [ "$assume_yes" != "yes" ]; then
	printf 'Publish to GitHub now? Type "yes" to continue: '
	read -r answer
	if [ "$answer" != "yes" ]; then
		fail "Aborted. Nothing was published."
	fi
fi

echo "Pushing $branch to Synology ($private_remote)..."
git push "$private_remote" "$branch"

echo "Publishing $branch to GitHub ($public_remote)..."
git push "$public_remote" "$branch"

echo "Public release completed."
