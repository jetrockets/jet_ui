# Drawer

> **Deprecated.** `Drawer` is now a thin shim around [`Dialog`](dialog.md) with
> `position: :right`, and will be removed in the next major version. Existing
> `jet_ui.drawer(...)` calls keep working and emit an `ActiveSupport::Deprecation` warning — see
> [Migrating from Modal/Drawer](dialog.md#migrating-from-modaldrawer) for the full mapping,
> including CSS classes and Stimulus wiring, both of which changed under the hood. New code
> should use `jet_ui.dialog(position: :right, ...)` directly — or any of `:left`, `:top`,
> `:bottom` for other edges, which Drawer never supported.

## Example

```erb
<%= jet_ui.drawer(title: "User details", id: "user-details") do %>
  <%= jet_ui.drawer_body do %>
    <%= render "users/detail", user: @user %>
  <% end %>
<% end %>
```

## Parameters

Same as [`Dialog`](dialog.md#parameters), minus `position` (always `:right`).
`drawer_header`/`drawer_body`/`drawer_footer` accept the same parameters as their `dialog_*`
counterparts.
