# Timeline

Vertical timeline for displaying events and activity feed.

## Usage

```erb
<%= jet_ui.timeline do %>
  <%= jet_ui.timeline_item do %>
    <%= jet_ui.timeline_dot variant: :success %>
    <%= jet_ui.timeline_content do %>
      <%= jet_ui.timeline_time { "2 hours ago" } %>
      <p>User signed up for the platform</p>
    <% end %>
  <% end %>
  <%= jet_ui.timeline_item do %>
    <%= jet_ui.timeline_dot variant: :info, icon: "check" %>
    <%= jet_ui.timeline_content do %>
      <%= jet_ui.timeline_time { "Yesterday" } %>
      <p>Order completed</p>
    <% end %>
  <% end %>
<% end %>
```

## Subcomponents

| Helper | Description |
|--------|-------------|
| `jet_ui.timeline_item` | Single item container |
| `jet_ui.timeline_dot` | Visual dot/marker |
| `jet_ui.timeline_content` | Content wrapper |
| `jet_ui.timeline_time` | Time/date label |

## Dot options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `variant` | Symbol | `:default` | `:default`, `:info`, `:success`, `:warning`, `:error` |
| `icon` | String | `nil` | Icon name to display inside the dot |

## CSS classes

| Class | Description |
|-------|-------------|
| `.timeline` | Wrapper container |
| `.timeline-item` | Single item |
| `.timeline-dot` | Dot marker |
| `.timeline-dot-{variant}` | Variant modifier |
| `.timeline-dot-icon` | Applied when icon is present |
| `.timeline-content` | Content area |
| `.timeline-time` | Time label |
