# JetUi

ViewComponent-based UI library for Rails applications, matching the design system at [ui.jetrockets.com](https://ui.jetrockets.com).

## Requirements

- Ruby >= 3.0
- Rails >= 7.0
- [ViewComponent](https://viewcomponent.org) >= 3.0
- Tailwind CSS v4 (configured in your host app)

## Installation

Add to your Gemfile:

```ruby
gem "jet_ui"
```

Run the install generator:

```bash
bundle install
rails generate jet_ui:install
```

The generator detects your Tailwind CSS source file and injects a single import that covers all component stylesheets. When the gem is updated with new components, your app picks them up automatically on the next CSS build — no manual changes needed.

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

## Generators

### `jet_ui:install`

Sets up JetUi in your application:

```bash
rails generate jet_ui:install
```

### `jet_ui:eject`

Copies a component's source files into your application for local customisation. Ejected files take precedence over the gem's versions automatically.

```bash
rails generate jet_ui:eject btn
rails generate jet_ui:eject card
rails generate jet_ui:eject btn card
```

By default both the test file and the ViewComponent preview are ejected. Use the flags below to skip either:

```bash
rails generate jet_ui:eject btn --skip-test
rails generate jet_ui:eject btn --skip-preview
rails generate jet_ui:eject btn --skip-test --skip-preview
```
