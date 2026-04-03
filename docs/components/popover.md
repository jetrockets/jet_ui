# Popover

Rich hover panel component. Shows a floating content card when hovering over the trigger element. Position flips automatically when near viewport edges.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Basic %>
<%= jet_ui.popover do %>
  <%= jet_ui.popover_trigger { "Hover me" } %>
  <%= jet_ui.popover_content(title: "Details") do %>
    <p>More information goes here.</p>
  <% end %>
<% end %>

<%# Custom placement %>
<%= jet_ui.popover(placement: :right) do %>
  <%= jet_ui.popover_trigger { "Info" } %>
  <%= jet_ui.popover_content do %>
    <p>Shown on the right.</p>
  <% end %>
<% end %>

<%# Trigger rendered as a button %>
<%= jet_ui.popover do %>
  <%= jet_ui.popover_trigger(as: :btn, variant: :outline, size: :sm) { "Details" } %>
  <%= jet_ui.popover_content(title: "Summary") do %>
    Some rich content here.
  <% end %>
<% end %>
```

## Parameters

### `popover`

| Parameter   | Type          | Default    | Description                                                          |
|-------------|---------------|------------|----------------------------------------------------------------------|
| `placement` | Symbol/String | `:bottom`  | Preferred position: `:top`, `:bottom`, `:left`, `:right`.            |
| `**options` | Hash          | `{}`       | HTML attributes on the wrapper `<div>`.                              |

### `popover_trigger`

| Parameter   | Type   | Default | Description                                                              |
|-------------|--------|---------|--------------------------------------------------------------------------|
| `as`        | Symbol | `nil`   | Render as another JetUi component (e.g. `:btn`). Options are forwarded.  |
| `**options` | Hash   | `{}`    | HTML attributes on the trigger element.                                  |

### `popover_content`

| Parameter   | Type   | Default | Description                                        |
|-------------|--------|---------|----------------------------------------------------|
| `title`     | String | `nil`   | Optional title shown above the body content.       |
| `**options` | Hash   | `{}`    | HTML attributes on the popover content `<div>`.    |

## CSS classes

| Class            | Description                       |
|------------------|-----------------------------------|
| `.popover`       | Floating content panel            |
| `.popover__title`| Panel title                       |
| `.popover__body` | Panel body                        |
