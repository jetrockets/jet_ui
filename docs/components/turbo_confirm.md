# Turbo Confirm

Custom confirmation dialog for Turbo-powered destructive actions. Replaces the browser's default `confirm()` prompt with a styled modal dialog. Integrates with Turbo's `data-turbo-confirm` attribute on links and forms.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Setup

Add the component once to your application layout (e.g. `app/views/layouts/application.html.erb`):

```erb
<%= jet_ui.turbo_confirm %>
```

That's it. Any link or form with `data-turbo-confirm` will now use the modal dialog instead of `window.confirm`.

## Usage in views

```erb
<%# Link with confirmation %>
<%= link_to "Delete account", user_path(@user),
      method: :delete,
      data: { turbo_confirm: true } %>

<%# Button/form %>
<%= button_to "Remove", membership_path(@membership),
      method: :delete,
      data: { turbo_confirm: true } %>
```

The dialog shows "Are you absolutely sure?" with a "Cancel" and "Yes, I'm sure" button. Clicking "Yes, I'm sure" proceeds with the action; clicking "Cancel" or pressing Escape cancels it.

## Customisation

The default dialog text is intentionally generic. To customise the copy, eject the component:

```bash
rails generate jet_ui:eject turbo_confirm
```

Then edit `app/components/jet_ui/turbo_confirm/component.html.erb` in your application.

## Stimulus controller

The `turbo-confirm` Stimulus controller registers itself as Turbo's confirmation handler in `connect()`:

```js
Turbo.config.forms.confirm = (message, element) => { ... }
```

The controller ID `turbo-confirm` is derived from `turbo_confirm_controller.js` by `eagerLoadControllersFrom("jet_ui", application)`.
