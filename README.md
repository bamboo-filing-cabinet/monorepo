# Bamboo Filing Cabinet Monorepo

This is a monorepo of all repos under the [Bamboo Filing Cabinet](https://github.com/bamboo-filing-cabinet) organization.

## Setup

Clone with submodules:

`git clone --recurse-submodules git@github.com:bamboo-filing-cabinet/monorepo.git bamboo-filing-cabinet`

If you already cloned without submodules:

`git submodule update --init --recursive`

## Keeping in sync

To fast-forward the workspace **and** every submodule to the latest published commits (not just fetch):

`./scripts/sync-all-submodules.sh`

Add `--commit` to commit the resulting submodule pointer bumps, or `--push` to commit and push. Run `./scripts/sync-all-submodules.sh --help` for details.

## Development

Work inside the relevant submodule and follow its `AGENTS.md` for commands and conventions.

Example (Vietnam Elections site):

`cd vietnam-elections && npm install`
`cd vietnam-elections && npm run dev`
`cd vietnam-elections && npm run build`

## Notes

- Repos are added as submodules
- [.github](./.github/README.md) helps centralize workflows across the organization
