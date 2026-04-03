# Table

Table component for displaying tabular data with optional borders, sizes, hover, and sticky columns.

## Usage

```erb
<%= jet_ui.table do %>
  <%= jet_ui.table_thead do %>
    <%= jet_ui.table_tr do %>
      <%= jet_ui.table_th "Name" %>
      <%= jet_ui.table_th "Status" %>
      <%= jet_ui.table_th "Amount" %>
    <% end %>
  <% end %>
  <%= jet_ui.table_tbody do %>
    <%= jet_ui.table_tr do %>
      <%= jet_ui.table_td "Item 1" %>
      <%= jet_ui.table_td "Active" %>
      <%= jet_ui.table_td "$100" %>
    <% end %>
  <% end %>
  <%= jet_ui.table_tfoot do %>
    <%= jet_ui.table_tr do %>
      <%= jet_ui.table_td "Total", colspan: 2 %>
      <%= jet_ui.table_td "$100" %>
    <% end %>
  <% end %>
<% end %>
```

## Table options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `size` | Symbol | `:md` | `:xs`, `:sm`, `:md`, `:lg` |
| `bordered` | Boolean | `false` | Add borders to all cells |
| `full` | Boolean | `true` | Full width table |
| `hovered` | Boolean | `false` | Highlight rows on hover |

## Subcomponents

| Helper | Description |
|--------|-------------|
| `jet_ui.table_thead` | Table header section |
| `jet_ui.table_tbody` | Table body section |
| `jet_ui.table_tfoot` | Table footer section |
| `jet_ui.table_tr` | Table row |
| `jet_ui.table_th` | Header cell — accepts `sticky: :left` or `:right` |
| `jet_ui.table_td` | Data cell — accepts `actions: true`, `sticky: :left` or `:right` |
