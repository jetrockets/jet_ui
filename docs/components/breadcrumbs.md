# Breadcrumbs

Navigation trail showing the current page's location within the site hierarchy. Standalone implementation — no external gem required.

## Examples

```erb
<%= jet_ui.breadcrumbs do %>
  <%= jet_ui.breadcrumbs_item "Home", href: root_path %>
  <%= jet_ui.breadcrumbs_item "Products", href: products_path %>
  <%= jet_ui.breadcrumbs_item "iPhone 15" %>
<% end %>

<%# With custom class %>
<%= jet_ui.breadcrumbs class: "hidden md:flex" do %>
  <%= jet_ui.breadcrumbs_item "Home", href: root_path %>
  <%= jet_ui.breadcrumbs_item "Current page" %>
<% end %>
```

## Parameters

### `breadcrumbs`

| Parameter   | Type   | Default | Description                              |
|-------------|--------|---------|------------------------------------------|
| `**options` | Hash   | `{}`    | HTML attributes on the `<nav>` element   |

### `breadcrumbs_item`

| Parameter   | Type   | Default | Description                                                  |
|-------------|--------|---------|--------------------------------------------------------------|
| `label`     | String | —       | Text label (positional argument)                             |
| `href`      | String | `nil`   | URL — renders a link when present, plain span when absent    |
| `**options` | Hash   | `{}`    | HTML attributes passed to the `<a>` or `<span>` element     |

The last item (no `href:`) automatically receives `aria-current="page"`. The separator between items is rendered via CSS — no configuration needed.
