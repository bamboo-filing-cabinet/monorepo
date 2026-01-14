# Bamboo Filing Cabinet Monorepo

This is a monorepo of all repos under the [Bamboo Filing Cabinet](https://github.com/bamboo-filing-cabinet) organization.

## Setup

Clone with submodules:

`git clone --recurse-submodules git@github.com:bamboo-filing-cabinet/monorepo.git bamboo-filing-cabinet`

If you already cloned without submodules:

`git submodule update --init --recursive`

## Development

Work inside the relevant submodule and follow its `AGENTS.md` for commands and conventions.

Example (Vietnam Elections site):

`cd vietnam-elections && npm install`
`cd vietnam-elections && npm run dev`
`cd vietnam-elections && npm run build`

## Notes

- Repos are added as submodules
- [.github](./.github/README.md) helps centralize workflows across the organization
