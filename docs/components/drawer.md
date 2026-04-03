# Drawer

Slide-in panel component. Slides in from the right. Supports the same two rendering modes as Modal:

- **Async (Turbo Frame)** — open via a Turbo Frame request; renders a `<turbo-frame id="drawer">` wrapping a `<dialog>` controlled by the `drawer` Stimulus controller.
- **Sync** — pass an `id:` and place a `data-controller="drawers"` wrapper on the page; open by dispatching a click on any element with `data-action="click->drawers#open" data-id="your-id"`.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Async via Turbo Frame %>
<%= jet_ui.drawer(title: "User details") do %>
  <%= jet_ui.drawer_body do %>
    <%= render "users/detail", user: @user %>
  <% end %>
<% end %>

<%# Sync %>
<div data-controller="drawers">
  <button data-action="click->drawers#open" data-id="filters-drawer">Filters</button>

  <%= jet_ui.drawer(id: "filters-drawer", title: "Filters") do %>
    <%= jet_ui.drawer_body do %>
      <%= render "filters_form" %>
    <% end %>
    <%= jet_ui.drawer_footer do %>
      <%= jet_ui.btn "Apply" %>
    <% end %>
  <% end %>
</div>

<%# Custom size %>
<%= jet_ui.drawer(title: "Wide panel", size: "4xl") do %>
  ...
<% end %>
```

## Parameters

### `drawer`

| Parameter  | Type   | Default | Description                                                                                     |
|------------|--------|---------|-------------------------------------------------------------------------------------------------|
| `title`    | String | `nil`   | Header title text.                                                                              |
| `subtitle` | String | `nil`   | Header subtitle text.                                                                           |
| `size`     | String | `'2xl'` | Width token: `sm`, `md`, `lg`, `xl`, `2xl`, `3xl`, `4xl`, `5xl`, `6xl`.                       |
| `id`       | String | `nil`   | Enables sync mode. Must match the `data-id` on the trigger button.                              |

### `drawer_header`

| Parameter  | Type    | Default | Description                                         |
|------------|---------|---------|-----------------------------------------------------|
| `title`    | String  | `nil`   | Title text.                                         |
| `subtitle` | String  | `nil`   | Subtitle text.                                      |
| `closable` | Boolean | `true`  | Shows the close button.                             |
| `id`       | String  | `nil`   | Passed to the close button's `data-id` attribute.   |

### `drawer_body`

Wrapper for drawer content. Accepts `**options` (HTML attributes).

### `drawer_footer`

Wrapper for drawer actions. Accepts `**options` (HTML attributes).

## CSS classes

| Class            | Description                      |
|------------------|----------------------------------|
| `.drawer`        | Root dialog element              |
| `.drawer__header`| Header area                      |
| `.drawer__title` | Title `<h3>`                     |
| `.drawer__close` | Close button                     |
| `.drawer__body`  | Content area                     |
| `.drawer__footer`| Footer area                      |
