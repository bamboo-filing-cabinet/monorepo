# Repository Guidelines

## Project Structure & Module Organization

This repository is a monorepo that tracks projects as Git submodules.

Submodules:

- `.github/` — shared workflows repo used across Bamboo Filing Cabinet.
- `bamboo-filing-cabinet.github.io/` — the organization's website.
- `vietnam-elections/` — application repo: a static, source-linked directory of official Vietnam election candidates (source, data, docs).
- `vietnam-elections-wikidata/` — Wikidata reconciliation & enrichment for National Assembly delegates and electoral units (`mappings/`, `reference/`, and decision `docs/journals/`).
- `vietnam-elections-archive/` — **private** submodule: raw archived source material (HTML profiles, candidate photos) from Vietnamese election portals. See its `daibieunhandan/` for the validated unit↔candidate index.

Other top-level paths:

- `scripts/` holds root-level maintenance helpers (for example, `sync-all-submodules.sh`).
- Top-level files (`README.md`, `.gitmodules`) describe the monorepo and submodule wiring.

For module-specific contributor details, read each module’s `AGENTS.md` (for example: `vietnam-elections/AGENTS.md`).

## Build, Test, and Development Commands

The root has no build artifacts; run commands inside the relevant submodule.

- `git submodule update --init --recursive`: fetch all submodules after cloning.
- `./scripts/sync-all-submodules.sh`: fast-forward the workspace and every submodule to the latest commits (add `--commit`/`--push` to record pointer bumps).
- `cd vietnam-elections && npm install`: install dependencies for the Vietnam Elections site.
- `cd vietnam-elections && npm run dev`: start the Next.js dev server.
- `cd vietnam-elections && npm run build`: produce the static export.

## Coding Style & Naming Conventions

- Follow each submodule’s established style guide and linting rules.
- For top-level edits, keep Markdown concise and consistent with existing docs.
- When adding a new submodule, mirror current naming (kebab-case directory name, repo slug match).

## Testing Guidelines

- No root-level test runner is configured.
- Run tests or linting from within the submodule you change (see its `AGENTS.md` for commands).

## Commit & Pull Request Guidelines

- Git history is minimal; the initial commit uses Conventional Commits (`feat: created monorepo`).
- Prefer Conventional Commit prefixes (`feat:`, `fix:`, `chore:`) and short, imperative messages.
- PRs should include: a concise summary, impacted submodules, and screenshots for UI changes.
- If a PR updates a submodule pointer, note the upstream commit SHA in the description.

## Configuration & Security Notes

- Do not commit secrets or local credentials at the monorepo root.
- Store environment files inside the appropriate submodule (for example, `vietnam-elections/.env.local`).

## GitHub CLI Notes

- In Codex sandboxed commands, `gh` may fail with `HTTP 401` even when it is authenticated in the user's normal terminal. If that happens, rerun the same `gh` command outside the sandbox with escalation; do not assume the user needs to re-authenticate.

## GitHub Accounts & Submodule Access

- These repos are owned by the maintainer's **personal** GitHub account, not a work/org account. Local git in this workspace is already configured to authenticate (over SSH) as that personal account, so submodule clone/fetch/push work here without extra setup.
- Multiple `gh` accounts may be logged in (see `gh auth status`). The default active account is **not** necessarily the one that owns these repos. For `gh` **write** operations (creating/editing/closing issues and PRs), switch the active account to the personal one first (`gh auth switch`), then restore the previously-active account when done — a mismatched account can silently lack write access.
- `vietnam-elections-archive` is a **private** submodule (personal account only); the others are public. If `git submodule update` reports "Repository not found" for it, that's an identity/access mismatch, not a missing repo — check which account your git/SSH is authenticating as.
