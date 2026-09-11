# Modal

> **Deprecated.** `Modal` is now a thin shim around [`Dialog`](dialog.md) with
> `position: :center`, and will be removed in the next major version. Existing
> `jet_ui.modal(...)` calls keep working and emit an `ActiveSupport::Deprecation` warning — see
> [Migrating from Modal/Drawer](dialog.md#migrating-from-modaldrawer) for the full mapping,
> including CSS classes and Stimulus wiring, both of which changed under the hood. New code
> should use `jet_ui.dialog(position: :center, ...)` directly.

## Example

```erb
<%= jet_ui.modal(title: "Edit User", id: "edit-user") do %>
  <%= jet_ui.modal_body do %>
    <%= render "form", user: @user %>
  <% end %>
  <%= jet_ui.modal_footer do %>
    <%= jet_ui.btn "Save", type: :submit, form: "edit_user_form" %>
  <% end %>
<% end %>
```

## Parameters

Same as [`Dialog`](dialog.md#parameters), minus `position` (always `:center`).
`modal_header`/`modal_body`/`modal_footer` accept the same parameters as their `dialog_*`
counterparts.
