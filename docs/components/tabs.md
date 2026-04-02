# Tabs

Navigation component for switching between views or sections. Supports pill (default) and underline variants.

**Variants:** `pill` (default), `underline`

## Examples

```erb
<%# Pill (default) %>
<%= jet_ui.tabs do %>
  <%= jet_ui.tabs_item "Profile", href: profile_path, active: true %>
  <%= jet_ui.tabs_item "Settings", href: settings_path %>
  <%= jet_ui.tabs_item "Notifications", href: notifications_path %>
<% end %>

<%# Underline %>
<%= jet_ui.tabs variant: :underline do %>
  <%= jet_ui.tabs_item "All", href: "#", active: true %>
  <%= jet_ui.tabs_item "Pending", href: "#" %>
  <%= jet_ui.tabs_item "Completed", href: "#" %>
<% end %>

<%# With icons %>
<%= jet_ui.tabs variant: :underline do %>
  <%= jet_ui.tabs_item "General", href: "#", icon: "user", active: true %>
  <%= jet_ui.tabs_item "Security", href: "#", icon: "shield-check" %>
  <%= jet_ui.tabs_item "Billing", href: "#", icon: "credit-card" %>
<% end %>
```

## Parameters

### `tabs`

| Parameter   | Type   | Default | Description                              |
|-------------|--------|---------|------------------------------------------|
| `variant`   | Symbol | `:pill` | Visual style: `pill`, `underline`        |
| `**options` | Hash   | `{}`    | HTML attributes on the `<ul>` list       |

### `tabs_item`

| Parameter   | Type    | Default | Description                                      |
|-------------|---------|---------|--------------------------------------------------|
| `label`     | String  | —       | Tab label (positional argument)                  |
| `href`      | String  | —       | URL the tab links to (required)                  |
| `active`    | Boolean | `false` | Marks this tab as currently active               |
| `icon`      | String  | `nil`   | Icon name displayed before the label             |
| `**options` | Hash    | `{}`    | HTML attributes on the `<a>` link element        |
