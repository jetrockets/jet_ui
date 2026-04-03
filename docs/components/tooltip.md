# Tooltip

Hover tooltip powered by Stimulus. Tooltip content is rendered in a dynamically created DOM element and positioned relative to its trigger. Position flips automatically when near viewport edges.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Basic — wraps content in a <span> %>
<%= jet_ui.tooltip(title: "More information") do %>
  <%= jet_ui.icon("information-circle") %>
<% end %>

<%# Custom placement %>
<%= jet_ui.tooltip(title: "Saved!", placement: :bottom) do %>
  <%= jet_ui.btn("Save", variant: :outline) %>
<% end %>

<%# Render as another JetUi component %>
<%= jet_ui.tooltip(title: "Delete permanently", as: :btn, variant: :danger) do %>
  Delete
<% end %>
```

## Parameters

| Parameter   | Type           | Default | Description                                                              |
|-------------|----------------|---------|--------------------------------------------------------------------------|
| `title`     | String         | —       | Tooltip text content (required).                                         |
| `as`        | Symbol         | `nil`   | Render as another JetUi component (e.g. `:btn`). Options are forwarded.  |
| `placement` | Symbol/String  | `:top`  | Preferred position: `:top`, `:bottom`, `:left`, `:right`.                |
| `**options` | Hash           | `{}`    | HTML attributes on the wrapper element.                                  |

## Stimulus controller

The `tooltip` Stimulus controller creates a tooltip element on `mouseenter` and removes it on `mouseleave`. It accepts the following values via `data-*` attributes (set automatically by the component):

| Value     | Description                        |
|-----------|------------------------------------|
| `content` | The tooltip text to display.       |
| `placement`| Preferred position for the tooltip.|
