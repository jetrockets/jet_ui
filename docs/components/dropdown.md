# Dropdown

Context menu component. Clicking the trigger toggles the menu open/closed. Clicking outside closes it. Menu position flips automatically when near viewport edges.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Basic %>
<%= jet_ui.dropdown do %>
  <%= jet_ui.dropdown_trigger { "Options" } %>
  <%= jet_ui.dropdown_menu do %>
    <%= jet_ui.dropdown_link "Edit", href: edit_path %>
    <%= jet_ui.dropdown_link "Duplicate", href: duplicate_path %>
    <%= jet_ui.dropdown_divider %>
    <%= jet_ui.dropdown_button "Delete", data: { action: "click->modal#open" } %>
  <% end %>
<% end %>

<%# Trigger rendered as a button component %>
<%= jet_ui.dropdown do %>
  <%= jet_ui.dropdown_trigger(as: :btn, variant: :outline, size: :sm) { "Actions" } %>
  <%= jet_ui.dropdown_menu do %>
    <%= jet_ui.dropdown_title { "Manage" } %>
    <%= jet_ui.dropdown_link "Settings", href: settings_path %>
  <% end %>
<% end %>
```

## Parameters

### `dropdown`

| Parameter   | Type | Default | Description                              |
|-------------|------|---------|------------------------------------------|
| `**options` | Hash | `{}`    | HTML attributes on the wrapper `<div>`.  |

Always renders `data-controller="dropdown"`.

### `dropdown_trigger`

| Parameter   | Type   | Default | Description                                                              |
|-------------|--------|---------|--------------------------------------------------------------------------|
| `as`        | Symbol | `nil`   | Render as another JetUi component (e.g. `:btn`). Options are forwarded.  |
| `**options` | Hash   | `{}`    | HTML attributes. `data-dropdown-target="trigger"` is added automatically.|

### `dropdown_menu`

Wrapper for menu items. Accepts `**options` (HTML attributes on the inner `<ul>`).

### `dropdown_link`

| Parameter   | Type   | Default | Description                                         |
|-------------|--------|---------|-----------------------------------------------------|
| `label`     | String | —       | Link text (positional argument).                    |
| `**options` | Hash   | `{}`    | HTML attributes on the `<a>` element (include `href`). |

### `dropdown_button`

| Parameter   | Type   | Default | Description                               |
|-------------|--------|---------|-------------------------------------------|
| `label`     | String | —       | Button text (positional argument).        |
| `**options` | Hash   | `{}`    | HTML attributes on the `<button>` element.|

### `dropdown_title`

Section label. Accepts block content. No additional parameters.

### `dropdown_divider`

Horizontal rule separator. No parameters.

## CSS classes

| Class               | Description                       |
|---------------------|-----------------------------------|
| `.dropdown`         | Root container                    |
| `.dropdown__trigger`| Trigger element                   |
| `.dropdown__menu`   | Floating menu container           |
| `.dropdown__wrapper`| Inner `<ul>` list                 |
| `.dropdown__item`   | Individual menu item              |
| `.dropdown__title`  | Section label                     |
| `.dropdown__divider`| Separator rule                    |
