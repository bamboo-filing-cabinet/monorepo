# Repository Guidelines

## Project Structure & Module Organization

This repository is a monorepo that tracks projects as Git submodules.

- `.github/` is a shared workflows repo (submodule) used across Bamboo Filing Cabinet.
- `vietnam-elections/` is an application repo (submodule) with its own source, data, and docs.
- Top-level files (`README.md`, `.gitmodules`) describe the monorepo and submodule wiring.

For module-specific contributor details, read each module’s `AGENTS.md` (for example: `vietnam-elections/AGENTS.md`).

## Build, Test, and Development Commands

The root has no build artifacts; run commands inside the relevant submodule.

- `git submodule update --init --recursive`: fetch all submodules after cloning.
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
