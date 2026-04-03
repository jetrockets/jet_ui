# Modal

Dialog overlay component. Supports two rendering modes:

- **Async (Turbo Frame)** — open via a Turbo Frame request; the modal wraps itself in a `<turbo-frame id="modal">` and renders a `<dialog>` controlled by the `modal` Stimulus controller.
- **Sync** — pass an `id:` and place a `data-controller="modals"` wrapper on the page; open by dispatching a click on any element with `data-action="click->modals#open" data-id="your-id"`.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Async via Turbo Frame (in a partial loaded into turbo_frame_tag :modal) %>
<%= jet_ui.modal(title: "Edit User") do %>
  <%= jet_ui.modal_body do %>
    <%= render "form", user: @user %>
  <% end %>
  <%= jet_ui.modal_footer do %>
    <%= jet_ui.btn "Save", type: :submit, form: "edit_user_form" %>
  <% end %>
<% end %>

<%# Sync — button + pre-rendered dialog on the same page %>
<div data-controller="modals">
  <button data-action="click->modals#open" data-id="confirm-modal">Delete</button>

  <%= jet_ui.modal(id: "confirm-modal", title: "Are you sure?") do %>
    <%= jet_ui.modal_body { "This action cannot be undone." } %>
    <%= jet_ui.modal_footer do %>
      <%= jet_ui.btn "Cancel", variant: :outline,
            data: { action: "click->modals#close", id: "confirm-modal" } %>
      <%= jet_ui.btn "Delete", variant: :danger %>
    <% end %>
  <% end %>
</div>

<%# Custom size %>
<%= jet_ui.modal(title: "Wide modal", size: "4xl") do %>
  ...
<% end %>
```

## Parameters

### `modal`

| Parameter  | Type   | Default | Description                                                                                     |
|------------|--------|---------|-------------------------------------------------------------------------------------------------|
| `title`    | String | `nil`   | Header title text.                                                                              |
| `subtitle` | String | `nil`   | Header subtitle text.                                                                           |
| `size`     | String | `'2xl'` | Max-width token: `sm`, `md`, `lg`, `xl`, `2xl`, `3xl`, `4xl`, `5xl`, `6xl`.                   |
| `id`       | String | `nil`   | Enables sync mode. Must match the `data-id` on the trigger button.                              |

### `modal_header`

| Parameter  | Type    | Default | Description                                         |
|------------|---------|---------|-----------------------------------------------------|
| `title`    | String  | `nil`   | Title text.                                         |
| `subtitle` | String  | `nil`   | Subtitle text.                                      |
| `closable` | Boolean | `true`  | Shows the close button.                             |
| `bordered` | Boolean | `true`  | Adds a bottom border to the header.                 |
| `id`       | String  | `nil`   | Passed to the close button's `data-id` attribute.   |

### `modal_body`

Wrapper for modal content. Accepts `**options` (HTML attributes).

### `modal_footer`

Wrapper for modal actions. Accepts `**options` (HTML attributes).

## CSS classes

| Class                      | Description                    |
|----------------------------|--------------------------------|
| `.modal`                   | Root dialog/container element  |
| `.modal-page`              | Non-dialog inline variant      |
| `.modal__header`           | Header area                    |
| `.modal__header-bordered`  | Header with bottom border      |
| `.modal__title`            | Title `<h3>`                   |
| `.modal__subtitle`         | Subtitle element               |
| `.modal__close`            | Close button                   |
| `.modal__body`             | Content area                   |
| `.modal__footer`           | Footer area                    |
| `.modal__footer-bordered`  | Footer with top border         |
