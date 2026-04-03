# Accordion

Collapsible content sections built on the native HTML `<details>` / `<summary>` elements. No JavaScript required.

## Examples

```erb
<%# Basic %>
<%= jet_ui.accordion do %>
  <%= jet_ui.accordion_summary { "What is JetUi?" } %>
  <%= jet_ui.accordion_body { "A ViewComponent-based UI library for Rails." } %>
<% end %>

<%# Open by default %>
<%= jet_ui.accordion(open: true) do %>
  <%= jet_ui.accordion_summary { "Already open" } %>
  <%= jet_ui.accordion_body { "This panel starts expanded." } %>
<% end %>

<%# Exclusive group — only one open at a time (native browser behaviour) %>
<%= jet_ui.accordion(name: "faq") do %>
  <%= jet_ui.accordion_summary { "Question 1" } %>
  <%= jet_ui.accordion_body { "Answer 1" } %>
<% end %>

<%= jet_ui.accordion(name: "faq") do %>
  <%= jet_ui.accordion_summary { "Question 2" } %>
  <%= jet_ui.accordion_body { "Answer 2" } %>
<% end %>

<%# No chevron icon %>
<%= jet_ui.accordion do %>
  <%= jet_ui.accordion_summary(icon: nil) { "Custom header" } %>
  <%= jet_ui.accordion_body { "Content" } %>
<% end %>
```

## Parameters

### `accordion`

| Parameter   | Type    | Default | Description                                                     |
|-------------|---------|---------|------------------------------------------------------------------|
| `open`      | Boolean | `false` | Renders the panel expanded by default.                          |
| `name`      | String  | `nil`   | Groups accordions — only one with the same `name` stays open.   |
| `**options` | Hash    | `{}`    | HTML attributes on the `<details>` element.                     |

### `accordion_summary`

| Parameter   | Type   | Default          | Description                                      |
|-------------|--------|------------------|--------------------------------------------------|
| `icon`      | String | `'chevron-down'` | Icon name shown at the right. Pass `nil` to hide. |
| `**options` | Hash   | `{}`             | HTML attributes on the `<summary>` element.      |

### `accordion_body`

No parameters. Renders a `<div>` wrapping the block content.
