# Dialog

Overlay component built on the native `<dialog>` element. Unifies what used to be separate
`Modal` and `Drawer` components into one, with five positions: `:center` (modal-like) or
`:left`/`:right`/`:top`/`:bottom` (drawer-like, sliding in from that edge).

Supports two rendering modes:

- **Async (Turbo Frame)** — open via a Turbo Frame request; the trigger links or forms use
  `data: { turbo_frame: :dialog }`. The `<dialog>` shell is built client-side by
  `DialogsController` before Turbo navigates the frame, so no ids need to be allocated by hand.
- **Sync** — pass an `id:` and open it by dispatching a click on any element with
  `data-action="click->dialogs#open" data-id="your-id"`.

Any number of dialogs can be nested — opening a dialog from a link or button **inside** an
already-open dialog stacks it on top; closing it returns focus to the one underneath. Only the
bottom-most dialog dims the page.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the `dialog` and
`dialogs` controllers automatically. Render `<%= jet_ui.dialogs %>` once in your layout — it
mounts the stack manager's root and the sentinel Turbo Frame that async opens adopt.

## Examples

```erb
<%# In your layout, once %>
<%= jet_ui.dialogs %>

<%# Async via Turbo Frame (in a partial loaded into the sentinel frame) %>
<%= jet_ui.dialog(title: "Edit User") do %>
  <%= jet_ui.dialog_body do %>
    <%= render "form", user: @user %>
  <% end %>
  <%= jet_ui.dialog_footer do %>
    <%= jet_ui.btn "Save", type: :submit, form: "edit_user_form" %>
  <% end %>
<% end %>

<%# The trigger picks the position/size — the server response only knows its own content %>
<%= jet_ui.btn "Edit", url: edit_user_path(user),
      data: { turbo_frame: :dialog, dialog_position: :right, dialog_size: :lg } %>

<%# Sync — button + pre-rendered dialog on the same page %>
<button data-action="click->dialogs#open" data-id="confirm-dialog">Delete</button>

<%= jet_ui.dialog(id: "confirm-dialog", title: "Are you sure?") do %>
  <%= jet_ui.dialog_body { "This action cannot be undone." } %>
  <%= jet_ui.dialog_footer justify: :end do %>
    <%= jet_ui.btn "Cancel", variant: :outline, data: { action: "click->dialog#close" } %>
    <%= jet_ui.btn "Delete", variant: :danger %>
  <% end %>
<% end %>

<%# Nested — open a second dialog from a link/button inside the first %>
<%= jet_ui.dialog(id: "level-1", title: "Level 1") do %>
  <%= jet_ui.dialog_body do %>
    <button data-action="click->dialogs#open" data-id="level-2">Open nested dialog</button>
  <% end %>
<% end %>

<%= jet_ui.dialog(id: "level-2", title: "Level 2", position: :right) do %>
  <%= jet_ui.dialog_body { "Stacks on top of level 1." } %>
<% end %>

<%# Custom size %>
<%= jet_ui.dialog(title: "Wide dialog", size: "4xl") do %>
  ...
<% end %>
```

## Parameters

### `dialog`

| Parameter     | Type    | Default    | Description                                                                                  |
|---------------|---------|------------|-----------------------------------------------------------------------------------------------|
| `title`       | String  | `nil`      | Header title text.                                                                             |
| `subtitle`    | String  | `nil`      | Header subtitle text.                                                                          |
| `position`    | Symbol  | `:center`  | `:center`, `:left`, `:right`, `:top`, `:bottom`.                                               |
| `size`        | String  | `'2xl'`    | `sm`, `md`, `lg`, `xl`, `2xl`, `3xl`, `4xl`, `5xl`, `6xl`. Controls width for `:center`/`:left`/`:right`, height for `:top`/`:bottom`. |
| `id`          | String  | `nil`      | Enables sync mode. Must match the `data-id` on the trigger.                                    |
| `closable`    | Boolean | `true`     | Shows the × close button in the header.                                                        |
| `dismissible` | Boolean | `true`     | Whether `Esc` and a backdrop click close the dialog. The close button always closes it.        |
| `swipe`       | Boolean | `true`     | Swipe-to-dismiss on touch. Only applies to edge positions — ignored for `:center`.              |

### `dialog_header`

| Parameter  | Type    | Default | Description                          |
|------------|---------|---------|---------------------------------------|
| `title`    | String  | `nil`   | Title text.                           |
| `subtitle` | String  | `nil`   | Subtitle text.                        |
| `closable` | Boolean | `true`  | Shows the close button.               |
| `bordered` | Boolean | `true`  | Adds a bottom border to the header.   |

### `dialog_body`

Wrapper for dialog content. Accepts `**options` (HTML attributes).

### `dialog_footer`

| Parameter   | Type   | Default  | Description                                             |
|-------------|--------|----------|----------------------------------------------------------|
| `direction` | Symbol | `:row`   | `:row` or `:col`.                                        |
| `align`     | Symbol | `:start` | `:start`, `:center`, `:end`.                             |
| `justify`   | Symbol | `:start` | `:start`, `:center`, `:end`, `:between`.                 |
| `bordered`  | Boolean| `true`   | Adds a top border to the footer.                         |

## Triggers

**Async — position/size on the trigger:**

```erb
<%= jet_ui.btn "Edit", url: edit_post_path(post),
      data: { turbo_frame: :dialog, dialog_position: :right, dialog_size: :lg } %>
```

**Sync — dialog markup already on the page:**

```erb
<button data-action="click->dialogs#open" data-id="my-dialog">Open</button>
```

## CSS classes

| Class                      | Description                          |
|----------------------------|---------------------------------------|
| `.dialog`                  | Root dialog positioning shell         |
| `.dialog-center`           | `:center` position                    |
| `.dialog-left`             | `:left` position                      |
| `.dialog-right`            | `:right` position                     |
| `.dialog-top`              | `:top` position                       |
| `.dialog-bottom`           | `:bottom` position                    |
| `.dialog-page`             | Non-dialog inline variant             |
| `.dialog__panel`           | Visible card (background, shadow, rounded corners, animation) |
| `.dialog__header`          | Header area                           |
| `.dialog__header-bordered` | Header with bottom border             |
| `.dialog__title`           | Title `<h3>`                          |
| `.dialog__subtitle`        | Subtitle element                      |
| `.dialog__close`           | Close button                          |
| `.dialog__body`            | Content area                          |
| `.dialog__footer`          | Footer area                           |
| `.dialog__footer-bordered` | Footer with top border                |

## Migrating from Modal/Drawer

`Modal` and `Drawer` are deprecated in favor of `Dialog` and will be removed in the next major
version. Existing code keeps working — `jet_ui.modal(...)` and `jet_ui.drawer(...)` are thin
shims that render a `Dialog` at `position: :center` / `position: :right` respectively, and emit
an `ActiveSupport::Deprecation` warning.

| Old                                          | New                                                        |
|-----------------------------------------------|-------------------------------------------------------------|
| `jet_ui.modal(...)`                            | `jet_ui.dialog(position: :center, ...)`                     |
| `jet_ui.drawer(...)`                           | `jet_ui.dialog(position: :right, ...)`                      |
| `jet_ui.modal_header/body/footer`              | `jet_ui.dialog_header/body/footer`                          |
| `data: { turbo_frame: :modal }`                | still works — resolved to `:dialog`, presets `position: :center` |
| `data: { turbo_frame: :drawer }`               | still works — resolved to `:dialog`, presets `position: :right`  |
| `.modal__*` / `.drawer__*` CSS                 | `.dialog__*`                                                 |
| `<%= turbo_frame_tag :modal %>` / `:drawer` in layout | `<%= jet_ui.dialogs %>` sentinel in layout            |
| `data-controller="modals"` + `click->modals#open` | `data-action="click->dialogs#open"` (no wrapper controller needed) |
| `data-controller="drawers"` + `click->drawers#open` | `data-action="click->dialogs#open"` (no wrapper controller needed) |

The async `data-turbo-frame="modal"`/`"drawer"` aliases keep working automatically — no changes
needed to existing async links. The old standalone `modal`/`modals`/`drawer`/`drawers` Stimulus
controllers no longer match the markup rendered by the sync-mode shims (which now target
`data-dialogs-target`); if you registered those controllers directly on custom markup, migrate
your `data-controller` and `data-action` attributes to `dialogs`/`click->dialogs#open`.
