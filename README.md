![JetUI Logo](app/assets/images/logo.svg)

[![Gem Version](https://img.shields.io/gem/v/jet_ui)](https://rubygems.org/gems/jet_ui)
[![Checks](https://img.shields.io/github/actions/workflow/status/jetrockets/jet_ui/ci.yml?label=checks&logo=github)](https://github.com/jetrockets/jet_ui/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE.md)
[![Downloads](https://img.shields.io/gem/dt/jet_ui)](https://rubygems.org/gems/jet_ui)
[![Stars](https://img.shields.io/github/stars/jetrockets/jet_ui?style=social)](https://github.com/jetrockets/jet_ui/stargazers)

ViewComponent-based UI library for Rails applications, matching the design system at [ui.jetrockets.com](https://ui.jetrockets.com).

## Requirements

- Ruby >= 3.0
- Rails >= 7.0
- [ViewComponent](https://viewcomponent.org) >= 3.0
- Tailwind CSS v4 (configured in your host app)

## Installation

Add the gem to your Gemfile, then run the install generator — it detects how your app manages
JavaScript and wires jet_ui up accordingly, no flags needed:

```ruby
gem "jet_ui"
```

```bash
bundle install
rails generate jet_ui:install
```

|              | Importmap                                                        | Vite                                                                          |
|--------------|-------------------------------------------------------------------|---------------------------------------------------------------------------------|
| **Detected by**  | `config/importmap.rb` present                                  | a Vite config, or `vite` in `package.json`                                      |
| **JS wiring**    | Automatic — controllers auto-register                          | Manual — you `import` and `application.register(...)` the ones you use          |
| **CSS wiring**   | Automatic — injected into your Tailwind source                 | Manual — `@import "@jetrockets/jet_ui/css"` in your CSS entry point             |
| **npm install**  | None needed — the gem ships the controllers itself              | Done for you by the generator (`yarn add @jetrockets/jet_ui`, or your package manager's equivalent) |

Full walkthrough and troubleshooting for the Vite path: [docs/vite.md](docs/vite.md).

### Importmap

The generator detects your Tailwind CSS source file and injects a single import covering all
component stylesheets, and registers JetUi Stimulus controllers in your app's controllers index.
When the gem is updated, both CSS and JS are picked up automatically — no further changes needed.
Safe to re-run after upgrades.

### Vite

The generator detects Vite and installs the `@jetrockets/jet_ui` npm package for you. Vite apps
own their JS/CSS entry points, so those are not modified automatically — wire up the two pieces
yourself:

Register the controllers you use (`@hotwired/stimulus` is a peer dependency):

```javascript
import { ModalController } from "@jetrockets/jet_ui"

application.register("modal", ModalController)
```

Import the component styles in your Tailwind/CSS entry point:

```css
@import "@jetrockets/jet_ui/css";
```

Or, if you'd rather manage styles through the bundler than the Rails asset pipeline, import the CSS straight from JavaScript:

```javascript
import "@jetrockets/jet_ui/css"          // all component styles
import "@jetrockets/jet_ui/css/btn.css"  // a single component
```

See [docs/vite.md](docs/vite.md) for detection details and troubleshooting.

## Usage

The `jet_ui` helper is available in all views:

```erb
<%= jet_ui.btn { "Save" } %>

<%= jet_ui.card do %>
  <%= jet_ui.card_header do %>
    <%= jet_ui.card_title "Hello" %>
  <% end %>
  <%= jet_ui.card_body do %>Content<% end %>
<% end %>
```

Subcomponents follow the `namespace_subcomponent` naming convention (`card_header`, `alert_title`, `stat_label`, etc.).

## Components

| Component | Docs |
|-----------|------|
| Btn | [docs/components/btn.md](docs/components/btn.md) |
| Card | [docs/components/card.md](docs/components/card.md) |
| Badge | [docs/components/badge.md](docs/components/badge.md) |
| Alert | [docs/components/alert.md](docs/components/alert.md) |
| Group | [docs/components/group.md](docs/components/group.md) |
| Stat | [docs/components/stat.md](docs/components/stat.md) |
| Icon | [docs/components/icon.md](docs/components/icon.md) |
| Spinner | [docs/components/spinner.md](docs/components/spinner.md) |
| Avatar | [docs/components/avatar.md](docs/components/avatar.md) |
| Breadcrumbs | [docs/components/breadcrumbs.md](docs/components/breadcrumbs.md) |
| Tabs | [docs/components/tabs.md](docs/components/tabs.md) |
| Empty | [docs/components/empty.md](docs/components/empty.md) |
| List | [docs/components/list.md](docs/components/list.md) |
| Divider | [docs/components/divider.md](docs/components/divider.md) |
| Timeline | [docs/components/timeline.md](docs/components/timeline.md) |
| Stepper | [docs/components/stepper.md](docs/components/stepper.md) |
| Table | [docs/components/table.md](docs/components/table.md) |
| Pagy | [docs/components/pagy.md](docs/components/pagy.md) |
| Flash ⚡ | [docs/components/flash.md](docs/components/flash.md) |
| Accordion | [docs/components/accordion.md](docs/components/accordion.md) |
| Clipboard ⚡ | [docs/components/clipboard.md](docs/components/clipboard.md) |
| Sidebar | [docs/components/sidebar.md](docs/components/sidebar.md) |
| Header | [docs/components/header.md](docs/components/header.md) |
| Navbar | [docs/components/navbar.md](docs/components/navbar.md) |
| Modal ⚡ | [docs/components/modal.md](docs/components/modal.md) |
| Drawer ⚡ | [docs/components/drawer.md](docs/components/drawer.md) |
| Dropdown ⚡ | [docs/components/dropdown.md](docs/components/dropdown.md) |
| Tooltip ⚡ | [docs/components/tooltip.md](docs/components/tooltip.md) |
| Popover ⚡ | [docs/components/popover.md](docs/components/popover.md) |
| Turbo Confirm ⚡ | [docs/components/turbo_confirm.md](docs/components/turbo_confirm.md) |

⚡ Requires Stimulus (configured automatically by `jet_ui:install`).

## Generators

### `jet_ui:install`

Sets up JetUi in your application (CSS + JS). Safe to re-run after gem upgrades — already-configured steps are skipped:

```bash
rails generate jet_ui:install
```

### `jet_ui:eject`

Copies a component's source files into your application for local customisation. Ejected files take precedence over the gem's versions automatically. For components with a Stimulus controller (e.g. `flash`), the JS file is ejected too.

```bash
rails generate jet_ui:eject btn
rails generate jet_ui:eject flash
rails generate jet_ui:eject btn card flash
```

By default the test, preview, and JS controller (when present) are all ejected. Use flags to skip any of them:

```bash
rails generate jet_ui:eject btn --skip-test
rails generate jet_ui:eject btn --skip-preview
rails generate jet_ui:eject flash --skip-javascript
rails generate jet_ui:eject btn --skip-test --skip-preview
```
