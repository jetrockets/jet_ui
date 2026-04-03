# Navbar

Top navigation bar component. Sticky by default. Pairs naturally with the Sidebar component for full app shell layouts.

## Examples

```erb
<%# Basic %>
<%= jet_ui.navbar do %>
  <%= jet_ui.navbar_brand do %>
    <%= link_to root_path do %>
      <%= image_tag "logo.svg", height: 28 %>
    <% end %>
  <% end %>

  <%= jet_ui.navbar_content do %>
    <%= jet_ui.navbar_main do %>
      <%= link_to "Dashboard", root_path %>
      <%= link_to "Reports", reports_path %>
    <% end %>

    <%= jet_ui.navbar_actions do %>
      <%= jet_ui.btn "Sign out", href: sign_out_path, variant: :outline, size: :sm %>
    <% end %>
  <% end %>
<% end %>

<%# Non-sticky %>
<%= jet_ui.navbar(sticky: false) do %>
  ...
<% end %>
```

## Parameters

### `navbar`

| Parameter   | Type    | Default | Description                                             |
|-------------|---------|---------|----------------------------------------------------------|
| `sticky`    | Boolean | `true`  | Fixes the navbar to the top of the viewport.            |
| `**options` | Hash    | `{}`    | HTML attributes on the `<header>` element.              |

### `navbar_brand`

Left-aligned brand/logo slot. Accepts `**options` (HTML attributes on the wrapper `<div>`).

### `navbar_content`

Flex container for the rest of the navbar (main nav + actions). Accepts `**options`.

### `navbar_main`

Center/left nav links area. Accepts `**options` (HTML attributes on the wrapper `<div>`).

### `navbar_actions`

Right-aligned actions slot (buttons, user avatar, etc.). Accepts `**options`.

## CSS classes

| Class            | Description                                     |
|------------------|-------------------------------------------------|
| `.navbar`        | Root `<header>` element                         |
| `.navbar-sticky` | Added when `sticky: true`                       |
| `.navbar__brand` | Brand/logo area                                 |
| `.navbar__content`| Content flex container                         |
