# Header

Page-level header component for titles, subtitles, and action buttons. Supports responsive direction, alignment, sticky positioning, and an optional bottom border.

## Examples

```erb
<%# Basic %>
<%= jet_ui.header do %>
  <%= jet_ui.header_heading do %>
    <%= jet_ui.header_title { "Users" } %>
    <%= jet_ui.header_subtitle { "Manage your team members." } %>
  <% end %>
  <%= jet_ui.header_actions do %>
    <%= jet_ui.btn "New user", href: new_user_path %>
  <% end %>
<% end %>

<%# Sticky with border %>
<%= jet_ui.header(sticky: true, bordered: true) do %>
  <%= jet_ui.header_heading do %>
    <%= jet_ui.header_title { "Settings" } %>
  <% end %>
<% end %>

<%# Column direction (title above actions, no responsive breakpoint) %>
<%= jet_ui.header(direction: :col) do %>
  <%= jet_ui.header_heading do %>
    <%= jet_ui.header_title { "Report" } %>
    <%= jet_ui.header_subtitle { "Last updated today" } %>
  <% end %>
  <%= jet_ui.header_actions do %>
    <%= jet_ui.btn "Export", variant: :outline %>
  <% end %>
<% end %>
```

## Parameters

### `header`

| Parameter   | Type    | Default   | Description                                                                                |
|-------------|---------|-----------|--------------------------------------------------------------------------------------------|
| `direction` | Symbol  | `:row`    | Layout direction: `:row` (stacks vertically on mobile, horizontal on `md+`) or `:col`.    |
| `align`     | Symbol  | `:start`  | Cross-axis alignment: `:start`, `:center`, `:end`.                                         |
| `justify`   | Symbol  | `:between`| Main-axis distribution: `:start`, `:center`, `:end`, `:between`.                           |
| `sticky`    | Boolean | `false`   | Sticks to top of viewport on `lg+` with a blurred background.                              |
| `bordered`  | Boolean | `false`   | Adds a bottom border and extra bottom padding.                                              |
| `**options` | Hash    | `{}`      | HTML attributes on the wrapper `<div>`.                                                     |

### `header_heading`

Flexible column container for title/subtitle. Accepts `**options` (HTML attributes on the `<div>`).

### `header_title`

Renders the page title. Accepts `**options` (HTML attributes on the element).

### `header_subtitle`

Renders a subtitle below the title. Accepts `**options` (HTML attributes on the element).

### `header_actions`

Right-aligned slot for buttons and controls. Accepts `**options` (HTML attributes on the wrapper `<div>`).
