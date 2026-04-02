# Avatar

Displays a user avatar with three automatic fallback states: image → initials → icon.

**Variants:** `circle` (default), `rounded`, `square`

## Examples

```erb
<%# Icon fallback (no src or name) %>
<%= jet_ui.avatar %>

<%# Initials %>
<%= jet_ui.avatar name: "John Doe" %>

<%# With image %>
<%= jet_ui.avatar src: user.avatar_url, name: user.full_name %>

<%# Variants %>
<%= jet_ui.avatar name: "Jane Smith", variant: :circle %>
<%= jet_ui.avatar name: "Jane Smith", variant: :rounded %>
<%= jet_ui.avatar name: "Jane Smith", variant: :square %>

<%# Sizes %>
<%= jet_ui.avatar name: "John Doe", size: 8 %>
<%= jet_ui.avatar name: "John Doe", size: 16 %>
```

## Parameters

| Parameter   | Type    | Default   | Description                                                  |
|-------------|---------|-----------|--------------------------------------------------------------|
| `src`       | String  | `nil`     | Image URL — shown when present, takes priority over `name:`  |
| `name`      | String  | `nil`     | Full name — used to generate initials when no `src:`         |
| `size`      | Integer | `12`      | Size in spacing units (`12` = 3rem, `16` = 4rem)             |
| `variant`   | Symbol  | `:circle` | Shape: `circle`, `rounded`, `square`                         |
| `**options` | Hash    | `{}`      | Passed through as HTML attributes on the wrapper `<div>`     |

## Fallback order

1. **Image** — shown when `src:` is present
2. **Initials** — up to 2 characters extracted from `name:` (e.g. `"John Doe"` → `"JD"`)
3. **Icon** — `user` icon when neither `src:` nor `name:` is provided
