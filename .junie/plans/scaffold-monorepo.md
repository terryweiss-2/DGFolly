---
sessionId: session-261111-193649-ds8k
---

# Requirements

### Overview
Scaffold the DGFolly npm-workspaces monorepo per SCAFFOLD.md and AGENTS.md: packages `ui`, `server`, `core`, each with `package.json` (type: module) and stub `index.js`. No features implemented.

### Out of scope
Any real functionality, Express server logic, Vue app, Mongo access.

### Notes
- No `src/` dirs; `tests/` dir per package (ui, server, core).
- ui subdirs: css, applications/disc, applications/meyers, assets, lib.
- Dependencies are those listed in AGENTS.md (Express, mongodb, tap, check-types, dayjs, oxlint, bootstrap, vue). AGENTS.md requires approval for new npm dependencies; these are explicitly specified, so they are treated as approved.

# Technical Design

### Layout
- Root `package.json`: name `DGFolly`, private, type module, workspaces `packages/*`, devDeps `oxlint`, `tap`; scripts delegate to `Makefile`.
- `Makefile`: targets install, lint (oxlint), test (tap).
- `.oxlintrc.json` reflecting specs/LINTER.md (curly, semi-style via available rules, camelcase, no-unused-vars, require-await, complexity max 10 warn/20 error).
- `packages/core`: deps check-types, dayjs; `index.js`, `README.md`, `tests/`.
- `packages/server`: deps express, mongodb, check-types, @dasdgfolly/core workspace; `index.js`, `README.md`, `tests/`.
- `packages/ui`: deps vue, bootstrap, check-types; `index.js`, `README.md`, `tests/`, `css/`, `assets/`, `lib/index.js`, `applications/disc/index.js`, `applications/meyers/index.js`.
- Stub index.js files contain only module JSDoc and `export {};`.
- `.gitignore` for node_modules. Run `npm install`.

# Testing

Run `npm install` and `npx oxlint` and confirm both succeed; confirm each stub imports cleanly via node.

# Delivery Steps

### * Step 1: Create monorepo root and package skeletons
Root and three packages exist with package.json and directories.

- Root package.json with workspaces, Makefile, .gitignore, .oxlintrc.json.
- package.json (type module) in core, server, ui with AGENTS.md technologies.
- Create tests/, css/, assets/, lib/, applications/disc, applications/meyers dirs.

###   Step 2: Add stub index.js and READMEs, install and verify
Stubs exist and npm install and lint pass.

- Add JSDoc-only stub index.js files in each package and ui subfeature.
- Add a README.md per package.
- Run npm install, oxlint, and import each stub.