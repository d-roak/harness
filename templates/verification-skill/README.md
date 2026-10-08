# App Verification

`control-app.mjs` is this application's verification interface. It stays local to this repository.

## Setup

1. Copy `config.example.json` to `config.json`.
2. Fill every field with local development details.
3. Run `node control-app.mjs doctor`.
4. Reuse the app's existing browser, simulator, or CDP driver. Do not add a driver until the app needs it.

## Contract

Commands print JSON. Unknown commands and unsupported origins fail. Extend the template only after adding a Feature Map entry and a seam test.

## Feature Map

Start at `references/features/README.md`. It is the concise user-facing map of application behavior and runnable controls.
