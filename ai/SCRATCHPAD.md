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

## Plan: Vietnam Elections licensing work
1. Audit current licensing mentions in `vietnam-elections/` (README, docs, data notes).
2. Add Apache-2.0 `LICENSE` to `vietnam-elections/`.
3. Add a licensing section to `vietnam-elections/README.md` (code license, data license, attribution template, source-terms caveat).
4. Decide dataset license label (CC-BY vs UNKNOWN) based on source-term clarity; document per-dataset notes if needed.
5. Summarize changes and update this log with findings.

## Vietnam Elections audit (Step 1)
- No explicit licensing section in `vietnam-elections/README.md`.
- No `LICENSE` file in `vietnam-elections/`.
- Mentions of “terms” exist in app nav/routes, but no dataset licensing guidance found.
- `package-lock.json` contains third-party dependency licenses only.

### Step 2-3: Apply licensing defaults to Vietnam Elections
- Added Apache-2.0 `LICENSE` to `vietnam-elections/`.
- Added a Licensing section to `vietnam-elections/README.md` covering code, compiled outputs (CC-BY 4.0), source ownership caveat, and attribution format.

## Site licensing placement investigation
- Site has dedicated policy pages: `app/terms/page.tsx`, `app/privacy/page.tsx`, `app/disclaimer/page.tsx`.
- Footer/nav already links to `/terms`, `/privacy`, `/disclaimer` (via `app/layout.tsx` and `app/mobile-nav.tsx`).
- `app/terms/page.tsx` currently states usage rules but does not mention code/data licenses.

## Proposed plan (site licensing)
1. Add a “Licensing” section to `app/terms/page.tsx` with concise bullets:
   - Code: Apache-2.0 (link to repo LICENSE).
   - Compiled dataset outputs: CC-BY 4.0 (attribution template).
   - Underlying sources: third-party, terms may be unclear.
2. Keep it short and consistent with the existing Terms tone.
3. Optional: add a short sentence in the footer (or `/sources`) linking to the Terms licensing section if you want more visibility.

## Status
- Added a Licensing section to `vietnam-elections/app/terms/page.tsx` with code/data/source bullets and a suggested attribution line.

## Open items / next goals
- Add a `LICENSE` at the monorepo root (Apache-2.0). (done)
- Add a CC-BY notice for docs/content in the docs site (e.g., `bamboo-filing-cabinet.github.io/docs/README.md`).
- Perform a source-terms audit for Vietnam Elections (per-source licensing notes where possible).
- Create a dataset card/template (license, sources, retrieval dates, transforms) and apply it to Vietnam Elections.
- Optional: add a footer or `/sources` link pointing to the site licensing section for visibility.

## Updates
- Added Apache-2.0 `LICENSE` at monorepo root.
