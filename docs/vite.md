# Using jet_ui with Vite

jet_ui ships two ways to wire up its Stimulus controllers and CSS: the gem itself (for importmap
apps) and an npm package, `@jetrockets/jet_ui` (for Vite apps). This guide covers the Vite path in
detail — setup, what the install generator does and doesn't touch, and troubleshooting.

If your app uses importmap instead, see the [README](../README.md#installation) — you don't need
this guide.

## How the generator detects Vite

`rails generate jet_ui:install` doesn't ask which bundler you use — it detects it. The logic (see
[`lib/generators/jet_ui/js_runtime.rb`](../lib/generators/jet_ui/js_runtime.rb)) is:

1. **Vite wins if any of these exist**, checked in your app's root:
   - `vite.config.js`, `vite.config.mjs`, or `vite.config.ts`
   - `config/vite.json`
   - `vite` listed under `dependencies` or `devDependencies` in `package.json`
2. Otherwise, **importmap wins if `config/importmap.rb` exists**.
3. If neither is found, the generator can't tell — it prints instructions for both and does
   nothing automatically.

Vite is checked first on purpose: a real Vite config is a stronger signal than a leftover
`config/importmap.rb` from `rails new`, which is common in apps mid-migration to Vite.

## Setup

Run the install generator — it detects Vite and installs the npm package for you:

```bash
rails generate jet_ui:install
```

This runs the install command for whichever package manager your app uses (see
[Package manager detection](#package-manager-detection) below) — equivalent to:

```bash
yarn add @jetrockets/jet_ui   # or npm/pnpm/bun, whichever the generator picked
```

Vite apps own their JS and CSS entry points, so **the generator does not touch them** — you wire
up the two remaining pieces yourself:

**1. Register the Stimulus controllers you use** (`@hotwired/stimulus` is a peer dependency, so
it must already be in your `package.json`):

```javascript
import { ModalController } from "@jetrockets/jet_ui"

application.register("modal", ModalController)
```

Only register the controllers your app actually uses — see each component's doc under
[`docs/components/`](components/) for which controller it needs.

**2. Import the component styles** in your Tailwind/CSS entry point:

```css
@import "@jetrockets/jet_ui/css";
```

Or, if you'd rather pull CSS in from JavaScript instead of your CSS entry point:

```javascript
import "@jetrockets/jet_ui/css"          // all component styles
import "@jetrockets/jet_ui/css/btn.css"  // a single component, to keep the bundle lean
```

### Package manager detection

The generator picks a package manager by checking, in order: `bun.lockb`, `pnpm-lock.yaml`,
`yarn.lock`, `package-lock.json`, then the `"packageManager"` field in `package.json` (set by
Corepack, e.g. `"yarn@4.5.0"` — useful on a fresh clone with no lockfile yet). If none of those
match, it defaults to npm.

Pass `--skip-install` to print the install command instead of running it (useful in CI, or if you
want to review the command first):

```bash
rails generate jet_ui:install --skip-install
```

## Troubleshooting

### The generator wired importmap, but my app uses Vite

This means none of the Vite signals in [How detection works](#how-the-generator-detects-vite)
were found. The most common cause: your `vite.config.js` exists but Vite isn't listed in
`package.json` yet (e.g. it's a transitive dependency of `vite_rails`/`vite_ruby`, not a direct
one) — check that `vite.config.js`/`.mjs`/`.ts` actually exists at your app's root, not nested in
a subdirectory. If it does and detection still picks importmap, please
[open an issue](https://github.com/jetrockets/jet_ui/issues/new) with your `vite.config.*`
filename and where it lives — that's a detection gap worth fixing.

### The generator installed the package with the wrong tool (e.g. npm instead of yarn)

The package-manager detection only looks at lockfiles and the `packageManager` field — it doesn't
read your global npm/yarn/pnpm preference. Make sure the lockfile for your preferred manager
exists in the app root (run your manager's install command once to generate it) before running
`jet_ui:install` again, or just run the install command yourself:

```bash
yarn add @jetrockets/jet_ui
```

### Controllers aren't registering / "X is not defined" in the console

Two common causes:

- **The controller name doesn't match.** `application.register("dialog", DialogController)` — the
  string must match the `data-controller="dialog"` value the component renders. Check the
  component's doc for the exact name.
- **`@hotwired/stimulus` isn't installed.** It's a peer dependency — jet_ui's controllers `import`
  from it directly, so it must be a real dependency of your app, not something jet_ui bundles for
  you.

### Styles aren't applied

Confirm `@import "@jetrockets/jet_ui/css";` is actually in the file your build processes as CSS
entry point (not, for example, a `.css` file that isn't `@import`-ed from your main stylesheet).
If you're using per-component imports (`@jetrockets/jet_ui/css/btn.css`), make sure you imported
one for every component you use — unlike the importmap path, nothing pulls all styles in
automatically once you've switched to per-component imports.

### Switching an existing importmap app to Vite

Re-run the generator after adding a Vite config — it re-detects and switches to the Vite
instructions. It won't undo anything the importmap path already wired into
`app/javascript/controllers/index.js` or your Tailwind source; remove
`eagerLoadControllersFrom("jet_ui", application)` and the `@import` of the gem's `jet_ui.css`
manually once you've confirmed the Vite path works, to avoid loading jet_ui's CSS/JS twice.
