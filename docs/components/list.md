# List

Styled list component for displaying items with optional icons, content areas, and actions.

## Examples

```erb
<%# Default list with icons, content, and actions %>
<%= jet_ui.list do %>
  <%= jet_ui.list_item do %>
    <%= jet_ui.list_icon "user" %>
    <%= jet_ui.list_content do %>
      <strong>John Doe</strong>
      <span class="text-muted-foreground text-sm block">john@example.com</span>
    <% end %>
    <%= jet_ui.list_action do %>
      <%= jet_ui.btn "Edit", size: :sm, variant: :ghost %>
    <% end %>
  <% end %>
<% end %>

<%# Divided variant %>
<%= jet_ui.list variant: :divided do %>
  <%= jet_ui.list_item do %>
    <%= jet_ui.list_icon "inbox" %>
    <%= jet_ui.list_content do %>
      <strong>Inbox</strong>
    <% end %>
  <% end %>
  <%= jet_ui.list_item do %>Option 2<% end %>
<% end %>

<%# Simple list without icons %>
<%= jet_ui.list variant: :divided do %>
  <%= jet_ui.list_item do %>Option 1<% end %>
  <%= jet_ui.list_item do %>Option 2<% end %>
<% end %>
```

## Parameters

### `list`

| Parameter   | Type   | Default    | Description                                          |
|-------------|--------|------------|------------------------------------------------------|
| `variant`   | Symbol | `:default` | Visual variant. `:divided` adds separators between items |
| `**options` | Hash   | `{}`       | HTML attributes passed to the `<ul>` element         |

### `list_item`

| Parameter   | Type | Default | Description                              |
|-------------|------|---------|------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes passed to the `<li>`     |

### `list_icon`

| Parameter   | Type    | Default | Description                        |
|-------------|---------|---------|------------------------------------|
| `name`      | String  | —       | Icon name (e.g. `"user"`, `"cog"`) |
| `size`      | Integer | `5`     | Icon size                          |
| `**options` | Hash    | `{}`    | HTML attributes on the wrapper div |

### `list_content`

| Parameter   | Type | Default | Description                                    |
|-------------|------|---------|------------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the content div (grows to fill remaining space) |

### `list_action`

| Parameter   | Type | Default | Description                                       |
|-------------|------|---------|---------------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the action div (pinned to end) |
