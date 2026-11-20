# Flash

Toast-style notification component that displays Rails flash messages. Messages animate in from the right, auto-dismiss after 5 seconds, and can be manually closed.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Usage

Add to your application layout:

```erb
<%# app/views/layouts/application.html.erb %>
<%= jet_ui.flash(messages: flash) %>
```

Flash messages set in your controllers appear automatically:

```ruby
flash[:notice]  = "Changes saved successfully."
flash[:success] = "Account created."
flash[:alert]   = "Something went wrong."
flash[:warning] = "Session will expire soon."
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `messages` | Hash / nil | `nil` | Flash messages hash. Defaults to the view's `flash` helper when not provided. |
| `dismissible` | Boolean | `true` | Shows close button and auto-dismisses after 5 seconds. |
| `frame_id` | Symbol | `:flash` | Turbo frame ID. Override when rendering multiple instances on one page (e.g. demos). |

## Message types

| Key | Style |
|-----|-------|
| `notice` | Info (blue) |
| `success` | Success (green) |
| `warning` | Warning (yellow) |
| `alert` | Error (red) |
| `error` | Error (red) |
| Any other key | Uses `flash-item-{key}` class — style it yourself |

## Non-dismissible

```erb
<%= jet_ui.flash(messages: flash, dismissible: false) %>
```

Messages render without a close button and do not auto-dismiss.

## Accessibility

The Turbo frame is a polite live region (`role="status"`, `aria-live="polite"`, `aria-atomic="false"`), so screen readers announce each message as it is added. The region has to exist before a message arrives: keep the component in your layout on every page, even when there are no messages.

To show a message from a Turbo Stream, replace the frame with the component:

```erb
<%= turbo_stream.replace :flash, jet_ui.flash(messages: flash) %>
```

Do not wrap the component in `turbo_stream.update :flash`: that nests a second `turbo-frame#flash` inside the first.

## CSS classes

| Class | Description |
|-------|-------------|
| `.flash-container` | Fixed positioned wrapper (top-right) |
| `.flash-item` | Individual message element |
| `.flash-item--hidden` | Initial hidden state (removed by JS on connect) |
| `.flash-item--visible` | Visible state with CSS transition |
| `.flash-item-info` | Info style (notice) |
| `.flash-item-success` | Success style |
| `.flash-item-warning` | Warning style |
| `.flash-item-error` | Error style (alert / error) |
| `.flash-item__message` | Message text paragraph |
| `.flash-item__close` | Close button |

## Stimulus controller

The `flash` Stimulus controller handles show/hide animations. It is registered automatically via `eagerLoadControllersFrom("jet_ui", application)` when you run `jet_ui:install`.

Values used by the controller:

| Value | Type | Default | Description |
|-------|------|---------|-------------|
| `dismissAfter` | Number | — | Ms before auto-dismiss. Only set when `dismissible: true`. |
| `showDelay` | Number | `250` | Ms delay before the enter animation starts. Always set, also when `dismissible: false`. |
