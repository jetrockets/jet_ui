# Icon

Renders an inline SVG icon from the built-in library of 326 icons. Color inherits from the parent via `currentColor` — use Tailwind `text-*` classes to change it.

## Examples

```erb
<%# Basic %>
<%= jet_ui.icon "heart" %>

<%# With size %>
<%= jet_ui.icon "heart", size: 6 %>

<%# With color %>
<%= jet_ui.icon "check-circle", size: 5, class: "text-green-500" %>

<%# Inside a button label %>
<%= jet_ui.btn do %>
  <%= jet_ui.icon "plus", size: 4 %>
  Add item
<% end %>
```

## Parameters

| Parameter   | Type    | Default | Description                                          |
|-------------|---------|---------|------------------------------------------------------|
| `name`      | String  | —       | Icon name (e.g. `"heart"`, `"arrow-right"`)          |
| `size`      | Integer | `nil`   | Size in spacing units (`4` = 1rem, `6` = 1.5rem)    |
| `**options` | Hash    | `{}`    | Passed through as HTML attributes on the `<svg>`     |

## Available icons

326 icons from the Heroicons-compatible set. Some common names:

`academic-cap` `arrow-down` `arrow-left` `arrow-right` `arrow-up` `bars-3` `bell` `bolt` `bookmark` `calendar` `camera` `chart-bar` `check` `check-circle` `chevron-down` `chevron-left` `chevron-right` `chevron-up` `clipboard` `clock` `cog-6-tooth` `credit-card` `document` `envelope` `eye` `fire` `flag` `funnel` `gift` `globe-alt` `heart` `home` `identification` `inbox` `information-circle` `key` `link` `lock-closed` `magnifying-glass` `map-pin` `minus` `moon` `paper-airplane` `pencil` `phone` `photo` `plus` `question-mark-circle` `share` `shield-check` `shopping-bag` `spinner` `star` `sun` `tag` `trash` `user` `users` `wrench` `x-circle` `x-mark`

See all 326 names by listing `app/assets/images/jet_ui/icons/` in the gem.
