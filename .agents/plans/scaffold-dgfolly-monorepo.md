---
sessionId: session-261110-202535-xorm
---

# Requirements

### Overview
Implement SCAFFOLD.md: create the DGFolly npm-workspaces monorepo (ESM) with the technologies from AGENTS.md, run `npm install`, and add a README with run instructions.

### Scope
In: root package.json, packages `core`, `server`, `ui` (with `css`, `applications/disc`, `applications/meyers`, `assets`, `lib`), minimal Express server serving the SPA, 20-connection cap that exits the process, security hardening (helmet, rate limiting, no personal data), oxlint config, Makefile, tapjs smoke tests, READMEs with JSDoc.
Out: the DISC/Myers-Briggs logic, output definition, and the config/logger modules from specs (separate work).

### Notes
- Dependency approval: AGENTS.md says to ask before adding new npm dependencies; the technologies listed in AGENTS.md are treated as pre-approved. Extra ones (helmet, express-rate-limit, vite) are to be confirmed. Prefer the plain Express middleware already available, and set security headers manually if not approved.
- Spec CONFIG.md says `packages/lib` but AGENTS.md layout says `core`; use `core`.

# Technical Design

### Current Implementation
Repo holds only AGENTS.md, SCAFFOLD.md and specs/*. Nothing else exists.

### Proposed Changes
- Root `../../package.json`: name `DGFolly`, `type: module`, `workspaces: [packages/*]`, devDeps: tap, oxlint; scripts delegate to Makefile.
- `../../packages/core`: `package.json`, `index.js` (exports a version constant and a `check-types` helper), README.
- `../../packages/server`: `src/app.js` (Express app, `helmet`-style headers, JSON limit, static serving of ui, disabled `x-powered-by`), `src/index.js` (listens, tracks connections via `server.on('connection')`; when count exceeds 20, logs and `process.exit(1)`), README. Exports `createApp()` and `startServer({port})` with check-types validation and JSDoc. Uses MongoDB driver as a dependency, not connected yet.
- `../../packages/ui`: Vue 3 SPA with `index.html`, `main.js`, `App.vue`, folders `css/`, `applications/disc`, `applications/meyers`, `assets/`, `lib/`; Bootstrap and DayJS dependencies. Built or served statically by the server (build tool, e.g. Vite, pending approval).
- `Makefile`: `install`, `lint`, `test`, `run`, `build`.
- `../../.oxlintrc.json` following specs/LINTER.md; `.gitignore`; root `README.md` with run instructions (Ubuntu/WSL).

### Risks
- Connection-limit exit may trip on keep-alive sockets; count open sockets and decrement on close.
- Tests must not mock Mongo; none are needed yet, so none start Docker.

# Testing

### Validation Approach
- `npm install` succeeds; `make lint` passes.
- tapjs test in server starts the app on an ephemeral port and checks that `/` returns HTML, security headers are present, and `x-powered-by` is absent.
- Test the connection-limit helper in isolation: the 21st connection triggers the injected exit callback.

# Delivery Steps

### * Step 1: Create monorepo root and package skeletons
Root workspace and package folders exist and `npm install` succeeds.

- Add root package.json (type: module, workspaces), .gitignore, .oxlintrc.json per specs/LINTER.md, Makefile.
- Add package.json, index files and READMEs for core, server, ui with the AGENTS.md layout folders.
- Run `npm install` (confirm any non-listed dependencies first).

###   Step 2: Implement secure Express server with 20-user cap
Server serves the SPA with hardened headers and exits when connections exceed 20.

- Implement packages/server/src/app.js and index.js with JSDoc and check-types validation.
- Add the connection limiter and a tapjs test for it and for headers/static serving.

###   Step 3: Add Vue SPA shell and root README
A minimal Vue page loads in the browser and the README documents how to run it.

- Add ui index.html, main.js, App.vue with Bootstrap and placeholders for the disc and meyers applications.
- Wire the Makefile run/build/test/lint targets.
- Write the root README.md with run instructions and update package READMEs with exported symbols.