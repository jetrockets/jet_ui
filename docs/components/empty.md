# Empty

Empty state component for displaying placeholder content when no data is available. Composed of optional subcomponents.

## Examples

```erb
<%# Full empty state %>
<%= jet_ui.empty do %>
  <%= jet_ui.empty_icon "inbox" %>
  <%= jet_ui.empty_title { "No messages" } %>
  <%= jet_ui.empty_description { "Your inbox is empty. Start a conversation." } %>
  <%= jet_ui.empty_actions do %>
    <%= jet_ui.btn { "New message" } %>
    <%= jet_ui.btn variant: :outline do %>Learn more<% end %>
  <% end %>
<% end %>

<%# Without actions %>
<%= jet_ui.empty do %>
  <%= jet_ui.empty_icon "magnifying-glass" %>
  <%= jet_ui.empty_title { "No results found" } %>
  <%= jet_ui.empty_description { "Try adjusting your search or filter." } %>
<% end %>
```

## Parameters

### `empty`

| Parameter   | Type | Default | Description                                   |
|-------------|------|---------|-----------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the wrapper `<div>`        |

### `empty_icon`

| Parameter   | Type    | Default | Description                                      |
|-------------|---------|---------|--------------------------------------------------|
| `name`      | String  | —       | Icon name (positional argument, e.g. `"inbox"`)  |
| `**options` | Hash    | `{}`    | HTML attributes on the icon wrapper `<div>`      |

### `empty_title`

| Parameter   | Type | Default | Description                              |
|-------------|------|---------|------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the `<h3>` element    |

### `empty_description`

| Parameter   | Type | Default | Description                              |
|-------------|------|---------|------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the `<p>` element     |

### `empty_actions`

Wraps its content in a `group` component. Accepts the same options as `group`.

| Parameter   | Type | Default | Description                                      |
|-------------|------|---------|--------------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes passed to the group wrapper      |
