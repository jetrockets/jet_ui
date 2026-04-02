# Spinner

An animated loading indicator. Renders the `spinner` SVG icon with a built-in SVG animation — no CSS animation needed.

## Examples

```erb
<%# Default %>
<%= jet_ui.spinner %>

<%# Custom size %>
<%= jet_ui.spinner size: 8 %>

<%# Custom color %>
<%= jet_ui.spinner size: 6, class: "text-blue-500" %>

<%# Inside a button %>
<%= jet_ui.btn disabled: true do %>
  <%= jet_ui.spinner size: 4 %>
  Saving...
<% end %>
```

## Parameters

| Parameter   | Type    | Default | Description                                      |
|-------------|---------|---------|--------------------------------------------------|
| `size`      | Integer | `6`     | Size in spacing units (`4` = 1rem, `6` = 1.5rem) |
| `**options` | Hash    | `{}`    | Passed through as HTML attributes on the `<svg>` |
