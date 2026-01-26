# Vietnam Elections Pipeline + Licensing Notes (Draft)

## What the pipeline does today (NA15-2021)
- Raw sources live under `vietnam-elections/data/na15-2021/` (PDFs, DOCX, parsed CSVs, results JSON).
- `data/na15-2021/build-staging-db.py` builds `data/staging.db` and seeds:
  - `document` table with title/url/file_path/doc_type/published_date/fetched_date/notes.
  - `source` table linking records to documents/URLs.
- `data/na15-2021/qa-checks.py` validates the DB.
- `data/na15-2021/export-json.py` exports JSON to `public/data/elections/na15-2021/`.
- README confirms data pipeline: raw -> staging.db -> JSON exports.
- Known gap: per-field citations for candidate attributes are not populated yet.

## Why multi-cycle matters
- Future elections will load into the same `staging.db`, so licensing metadata must be cycle-aware.
- Some documents may be cross-cycle or not tied to a single cycle, so `cycle_id` should be nullable.

## Proposed schema (approved direction)
New table: `document_terms` (separate table for history)
- `id` TEXT PRIMARY KEY
- `document_id` TEXT NOT NULL REFERENCES document(id) ON DELETE CASCADE
- `cycle_id` TEXT REFERENCES election_cycle(id) ON DELETE CASCADE
- `terms_status` TEXT NOT NULL  (enum values below)
- `terms_url` TEXT
- `terms_checked_at` TEXT  (ISO date)
- `terms_notes` TEXT
- `created_at` TEXT  (ISO date/time)

Index:
- `document_id` + `terms_checked_at` (for latest lookup)

Notes:
- Multiple rows per document allow history of checks.
- Latest record per document is used in exports.

## Proposed wiring (approved direction)
- `build-staging-db.py`:
  - Create `document_terms` table + index.
  - Add `cycle_id` to `document` table (nullable).
  - Add a `seed_document_terms()` that reads `data/<cycle>/dataset.yml` and inserts terms rows only for listed sources.
- `export-json.py`:
  - Join latest `document_terms` row per document into `documents.json`.
  - Keep UI unaffected for now; JSON simply carries extra fields.
- `dataset.yml`:
  - Add `document_id` for each source and mirror fields (`terms_status`, `terms_url`, `terms_checked_at`, `terms_notes`).
  - `document_id` is generated via a helper script under `data/tools/`.

## terms_status enum (proposed)
- UNKNOWN
- UNCLEAR
- OPEN_LICENSE
- PUBLIC_DOMAIN
- RESTRICTED
- NO_REUSE
- GOV_PUBLIC_INFO

## Decisions so far
- Source-terms should live in `staging.db` as well as dataset YAML.
- Use a **separate terms table** (future-proof for multiple checks and multi-cycle staging DB).
- UI does not need to show terms status for now (JSON/YAML only).
- Seed `document_terms` only from `dataset.yml` (no implicit UNKNOWN rows).
- Add `document_id` to `dataset.yml` sources for precise mapping.
- Add `cycle_id` to `document` and `document_terms` (nullable for cross-cycle docs).
- Use a helper script under `data/tools/` to generate/verify `document_id` values.
- Helper script scope: compute/print document_id from url/path/type only (no validation).

## Phase-by-phase plan (no implementation yet)
### Phase 0: Baseline audit (read-only)
- Confirm current schema in `data/na15-2021/build-staging-db.py` (document + source tables).
- Confirm exports in `data/na15-2021/export-json.py` (documents.json content).
- Confirm dataset card location: `data/na15-2021/dataset.yml`.
- Identify any other cycles currently using `staging.db` (future-proofing).

### Phase 1: Schema + helper tooling
- Add `cycle_id` column to `document` table (nullable).
- Create new `document_terms` table + index (`document_id`, `terms_checked_at`).
- Add helper script `data/tools/document-id.py` (prints document_id for url/path/type).
- Update dataset template (`docs/standards/dataset-card-template.yml`) to include `document_id` and terms fields.

### Phase 2: Dataset YAML alignment
- Update `data/na15-2021/dataset.yml` sources to include `document_id`, `terms_status`, `terms_checked_at`, `terms_url`, `terms_notes`.
- Ensure `document_id` values align with the IDs produced by the helper script.
- Decide per-source `cycle_id` values (set to `na15-2021` for now).

### Phase 3: Ingest + seed logic
- Update `build-staging-db.py`:
  - Write `cycle_id` into `document` rows (for NA15-2021 documents).
  - Add `seed_document_terms()` to read `data/na15-2021/dataset.yml` and insert rows into `document_terms`.
  - Ensure only rows explicitly listed in `dataset.yml` are inserted.
- Update `qa-checks.py`:
  - Validate every dataset.yml source `document_id` exists in `document`.
  - Validate each document referenced by sources has at least one terms entry.

### Phase 4: Export surface
- Update `export-json.py` to include latest `document_terms` data in `documents.json`:
  - `terms_status`, `terms_url`, `terms_checked_at`, `terms_notes`.
  - Keep UI unchanged.

### Phase 5: Documentation + guardrails
- Update `data/na15-2021/README.md` to mention dataset.yml as the authoritative terms log.
- Add short instructions to `docs/standards/licensing-guide.md` (how to set terms status).
- Add a short README in `data/tools/` describing the helper script usage.

### Phase 6: Regeneration + verify
- Run `npm run data:build` to regenerate `data/staging.db` and JSON exports.
- Spot-check `public/data/elections/na15-2021/documents.json` for new fields.

## Progress (implementation started)
- Added `data/tools/document-id.py` and `data/tools/README.md`.
- Added `document_terms` table and `cycle_id` column in `build-staging-db.py`.
- Wired `build-staging-db.py` to seed `document_terms` from `dataset.yml`.
- Added new document entry for the DOCX source page (Bao Chinh Phu).
- Updated `export-json.py` to include latest terms data in `documents.json`.
- Updated `qa-checks.py` to validate dataset.yml sources against document/terms tables.
- Updated `data/na15-2021/dataset.yml` with `document_id` and `terms_checked_at`.
- Updated dataset template to include document_id + terms fields.
- Documented dataset metadata and PyYAML requirement in `data/na15-2021/README.md`.

## terms_status enum (proposed)
- UNKNOWN
- UNCLEAR
- OPEN_LICENSE
- PUBLIC_DOMAIN
- RESTRICTED
- NO_REUSE
- GOV_PUBLIC_INFO
