# Sidebar

Vertical navigation component for application layouts. Pairs with the `sidebar` Stimulus controller to support open/close toggling via a trigger button elsewhere on the page.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Full sidebar example %>
<div data-controller="sidebar">
  <%= jet_ui.sidebar do %>
    <%= jet_ui.sidebar_section do %>
      <%= jet_ui.sidebar_title { "Main" } %>
      <%= jet_ui.sidebar_menu do %>
        <%= jet_ui.sidebar_link(url: root_path) { "Dashboard" } %>
        <%= jet_ui.sidebar_link(url: users_path) { "Users" } %>
        <%= jet_ui.sidebar_link(url: settings_path, disabled: true) { "Settings" } %>
      <% end %>
    <% end %>

    <%= jet_ui.sidebar_section do %>
      <%= jet_ui.sidebar_title { "Account" } %>
      <%= jet_ui.sidebar_menu do %>
        <%= jet_ui.sidebar_link(url: profile_path) { "Profile" } %>
        <%= jet_ui.sidebar_link(url: sign_out_path, active: false) { "Sign out" } %>
      <% end %>
    <% end %>
  <% end %>
</div>

<%# Toggle button (can live anywhere inside the sidebar controller element) %>
<button data-action="click->sidebar#toggle">Menu</button>
```

## Parameters

### `sidebar`

| Parameter   | Type | Default | Description                                     |
|-------------|------|---------|-------------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the `<nav>` element.         |

Always renders `data-sidebar-target="menu"` automatically.

### `sidebar_section`

Wraps a group of menu items. Accepts `**options` (HTML attributes on the wrapper `<div>`).

### `sidebar_title`

Section heading. Accepts `**options` (HTML attributes on the `<h4>` element).

### `sidebar_menu`

Unordered list container for links. Accepts `**options` (HTML attributes on the `<ul>` element).

### `sidebar_link`

| Parameter   | Type    | Default | Description                                                                            |
|-------------|---------|---------|----------------------------------------------------------------------------------------|
| `url`       | String  | `nil`   | Link destination.                                                                      |
| `disabled`  | Boolean | `false` | Renders as a `<span>` instead of a link. Adds `.sidebar__link-disabled` style.         |
| `active`    | Boolean | `nil`   | Forces active state. When `nil`, auto-detects via `current_page?`.                     |
| `**options` | Hash    | `{}`    | HTML attributes on the `<a>` element (ignored when disabled).                          |

## CSS classes

| Class                    | Description                               |
|--------------------------|-------------------------------------------|
| `.sidebar`               | Root `<nav>` element                      |
| `.sidebar__section`      | Section wrapper                           |
| `.sidebar__title`        | Section heading                           |
| `.sidebar__menu`         | `<ul>` list container                     |
| `.sidebar__link`         | Individual navigation link                |
| `.sidebar__link-active`  | Active state for the current page         |
| `.sidebar__link-disabled`| Disabled (non-interactive) link           |
