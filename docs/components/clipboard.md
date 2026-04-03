# Clipboard

Copy-to-clipboard component powered by the browser's native `navigator.clipboard` API. Supports optional tooltip feedback and rendering as any other JetUi component.

Requires Stimulus. Run `rails generate jet_ui:install` once to register the controller automatically.

## Examples

```erb
<%# Wrap any content — click copies the value %>
<%= jet_ui.clipboard(value: "npm install jet_ui") do %>
  <code>npm install jet_ui</code>
<% end %>

<%# Copy text from another element by ID %>
<%= jet_ui.clipboard(source_id: "my-input") do %>
  Copy
<% end %>
<input id="my-input" value="Hello world">

<%# Render as a button %>
<%= jet_ui.clipboard(as: :btn, value: "secret", variant: :outline) { "Copy token" } %>

<%# With tooltip feedback %>
<%= jet_ui.clipboard(value: "Hello", tooltip: "Copy", tooltip_success: "Copied!") do %>
  Copy
<% end %>
```

## Parameters

| Parameter          | Type   | Default     | Description                                                                     |
|--------------------|--------|-------------|---------------------------------------------------------------------------------|
| `value`            | String | `nil`       | Text to copy. If nil, `source_id` is used.                                      |
| `source_id`        | String | `nil`       | ID of a DOM element whose value/text is copied.                                 |
| `success_text`     | String | `'Copied!'` | Text restored to the element after the copy (when no tooltip is used).          |
| `as`               | Symbol | `nil`       | Render as another JetUi helper (e.g. `:btn`). Extra options are passed through. |
| `tooltip`          | String | `nil`       | Initial tooltip text. Enables tooltip integration when set.                     |
| `tooltip_success`  | String | `nil`       | Tooltip text shown after a successful copy. Defaults to `success_text`.         |
| `tooltip_placement`| String | `'top'`     | Tooltip placement: `top`, `bottom`, `left`, `right`.                            |
| `**options`        | Hash   | `{}`        | HTML attributes on the wrapper element.                                         |

## Stimulus controller

The `clipboard` Stimulus controller handles the copy action and success feedback. When a `tooltip` is provided, it co-operates with the `tooltip` controller via a `clipboard:change` event.
