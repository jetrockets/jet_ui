# Divider

A visual separator for content sections, with optional text and alignment control.

## Usage

```erb
<%# Simple line %>
<%= jet_ui.divider %>

<%# With text (centered by default) %>
<%= jet_ui.divider do %>or<% end %>

<%# Text aligned to start %>
<%= jet_ui.divider(align: :start) do %>Section<% end %>

<%# Text aligned to end %>
<%= jet_ui.divider(align: :end) do %>More<% end %>
```

## Options

| Option  | Type    | Default   | Description                              |
|---------|---------|-----------|------------------------------------------|
| `align` | Symbol  | `:center` | Text alignment: `:center`, `:start`, `:end` |

Any additional keyword arguments are passed through as HTML attributes.

## CSS classes

| Class            | Description                          |
|------------------|--------------------------------------|
| `.divider`       | Base class                           |
| `.divider-start` | Aligns text to the start of the line |
| `.divider-end`   | Aligns text to the end of the line   |
