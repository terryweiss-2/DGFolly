# AGENTS.md

Guidance for agents working in this repository.

- This is a mono-repo (npm workspaces: `packages/*`).
- Store all skills in the `.agents/skills` directory.
- Store all plans in the `.agents/plans` directory. Specifications go in `specs`.
- Prefer available libraries over new code. Ask for approval before adding any new npm dependency.
- Linting rules are defined in specs/LINTER.md
- Consult the [glossary](specs/GLOSSARY.md) for terminology.

## Layout

Do not create `src/` directories. Modules go right into the package. Tests are kept in `tests/` directories under each
package. Features will live in a subdirectory of the package.

- packages
    - `ui` - The user interface
        - `tets`
        - `css`
        - `applications`
            - disc - The DISC personality test
            - meyers - The Myers-Briggs personality test
        - `assets` - images and static files and such
        - `lib` - The UI library of controls and reusable parts
    - `server` - The web server
        - `tests`
    - `core` - Libraries used by other parts of the repository
        - `tests`

## Technologies

`NodeJS`,
`JavaScript` (ES modules),
`Express.js` (web server),
`MongoDB` (persistent storage),
`GNU Make` (shell scripts, build automation)
`TapJS` (test framework)
`check-types` (validate types)
`DayJS` (date handling)
`oxlint` (linting)
`Bootstrap` (css framework)
`Vue` (UI framework)

## Testing

- Use tapjs for testing
- MongoDB is installed in local docker containers with default options. Do _not_ mock mongo, check to see if the docker
  engine is running and start it if it is not running. If you had to start it, close it when you are done. If you did
  not start it, leave it running when tests are finished. Docker runs in wsl, not docker for windows.

## Agent file locations

- Store all skills in `.agents/skills`.
- Store all plans in `.agents/plans`.
- Do not store project plans in `.junie/plans`.

# Behaviors

- Always type check parameters with `check-type` for any public API, unless it is covered by a JSON Schema.
- Prefer GNU Make for shell scripts and build automation.
- Always add jsdoc module level documentation and for all public methods and properties in the module. Add or update the
  README.md in the root of the package so that it contains all exported symbols and a description of how to use them and
  their parameters.
- All testing and execution happens in ubuntu, wsl is supported when the IDE is in windows. Windows and Mac are not
  supported unless and until a PWA is created. That includes `npm`
- Follow all best practices for securing a web application.
- Scale for 20 simultaneous users. If that limit is hit, exit the application. This is just a proof of concept, so it
  will not scale beyond that limit and exceeding that limit may indicate an attack. Better to just disappear.

