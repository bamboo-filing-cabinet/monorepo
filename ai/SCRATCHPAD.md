# Bamboo Filing Cabinet: Licensing Thoughts (Draft)

Notes: This is not legal advice. It's a working outline to help decide how BFC should handle code, data, and sources.

## Goals for licensing
- Maximize reuse while protecting provenance.
- Be transparent about what we do and do not have rights to relicense.
- Keep each dataset honest about its sources and constraints.

## The split: code vs data vs docs
- **Code**: use a standard permissive license (Apache-2.0). Consistent across repos.
- **Data we produce**: prefer permissive data licenses (CC-BY default).
- **Docs/site copy**: use CC-BY (or a doc-specific license) so people can reuse text with attribution.

## What we can and cannot license
- We can only license **our own work** (scripts, schema design, manual annotations).
- If source licensing is unclear, label the dataset license as **UNKNOWN** and keep provenance strong (source URLs + retrieval dates).
- Avoid claiming a license for third-party data if the source does not grant it.

## Suggested default policy (per dataset)
1. Document the license for the **code** (Apache-2.0).
2. Document the license for the **dataset** (CC-BY if data is original/derived and permitted).
3. If source terms are unclear: set dataset license to **UNKNOWN**, keep source metadata explicit, and link to source terms if available.

## Metadata to include in each dataset
- Source URLs + retrieval dates.
- Any source licensing statements (quote or link).
- Our transformations (what changed vs raw).
- License for code + license for published dataset.
- Any known restrictions or uncertainty.

## Common data-license options (high-level)
- **CC0**: public domain dedication; best for maximum reuse.
- **CC-BY**: reuse allowed with attribution; good when we want credit.
- **ODC-PDDL / ODC-BY / ODbL**: common in data communities; can be useful if CC is not ideal.

## Practical next steps
- Confirm org-wide defaults: code = Apache-2.0, data = CC-BY for original/derived.
- Inventory repos and check for missing `LICENSE` files (monorepo, vietnam-elections, bamboo-filing-cabinet.github.io, etc.).
- Add `LICENSE` (Apache-2.0) to code repos; add a data license notice (CC-BY) to dataset repos where permitted.
- Add a short licensing section in each dataset README/dataset card (code license, data license, source terms, attribution format).
- For Vietnam Elections: review each source for licensing/terms; if unclear, set dataset license to UNKNOWN and document uncertainty.
- Add a standard attribution line/template for CC-BY reuse (e.g., project name, URL, retrieval date).
- Update docs site standards page to reflect the defaults and link to licensing details.

## Progress log

### Step 1: Confirm org-wide defaults
- Confirmed with maintainer: code license = Apache-2.0, data license for original/derived = CC-BY.
- Scan for existing `LICENSE*` files in the monorepo returned no matches, so defaults are not yet reflected in repo files.

### Step 2: Inventory repos for missing LICENSE files
- Monorepo root: no `LICENSE*` file.
- `bamboo-filing-cabinet.github.io`: no `LICENSE*` file.
- `vietnam-elections`: no `LICENSE*` file.

### Step 3 (partial): Add licensing defaults to docs site
- Added Apache-2.0 `LICENSE` to `bamboo-filing-cabinet.github.io/`.
- Updated `bamboo-filing-cabinet.github.io/docs/standards/licensing-guide.md` to reflect BFC defaults (code: Apache-2.0, data: CC-BY, docs: CC-BY) and required per-dataset metadata.
