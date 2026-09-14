# Form Builders

Custom form builders (`CoreFormBuilder`, `DefaultFormBuilder`) and their field components — a styled drop-in replacement for Rails' native `form_with` helpers.

Ported from `ui.jetrockets.com`. This page grows as each field gets ported (tracked under the `v0.4.0` milestone); it isn't complete until that milestone ships.

## Setup

_Documented once `CoreFormBuilder`/`DefaultFormBuilder` land — until then, the fields below exist as `JetUi::Fields::*Component` ViewComponents, not yet wired up to `f.text_field`-style calls._

## Common options

Every field shares these, inherited from `JetUi::Fields::BaseComponent`:

| Parameter | Type | Default | Description |
|---|---|---|---|
| `size` | Symbol | `:md` | `:sm`, `:md`, `:lg` |
| `error` | String | `nil` | Manual error message. ActiveRecord errors on the attribute are picked up automatically. |
| `required` | Boolean | auto-detected | Explicit override; otherwise inferred from a `presence` validator on the attribute. |
| `class` | String | `nil` | Merged into the computed field/label classes, not replacing them. |
| `disabled` | Boolean | `false` | Also toggles a disabled style on the field's label. |

## Fields

### Text-type fields

`JetUi::Fields::TextComponent`. Covers `text_field` and every native Rails input helper that only needs the gem's styling on top: `password_field`, `email_field`, `number_field`, `date_field`, `range_field`, `telephone_field` (and its `phone_field` alias), `color_field`, `search_field`, `time_field`, `datetime_field`, `datetime_local_field`, `month_field`, `week_field`, `url_field`.

```erb
<%= f.text_field :name %>
<%= f.email_field :email %>
<%= f.password_field :password %>
<%= f.date_field :born_on %>
```

`autocomplete` defaults to `"off"` unless set explicitly.

### TextArea

`JetUi::Fields::TextAreaComponent`.

```erb
<%= f.text_area :bio %>
```

Autogrows as content changes, including on window resize (the resize check is debounced 100ms by default, tunable via `data: { textarea_autogrow_resize_debounce_delay_value: 200 }`, or disabled entirely by setting it to `0`).

**Migrating from `ui.jetrockets.com`:** that version depends on the third-party `stimulus-textarea-autogrow` package. jet_ui has no external JS dependencies (every other controller in the gem is hand-written), so this is a small built-in controller instead of adding the first one. Behavior matches, including the resize recalculation.

### Select

`JetUi::Fields::SelectComponent`. Wraps Rails' native `select` helper.

```erb
<%= f.select :country, ["US", "CA", "MX"] %>
<%= f.select :country, ["US", "CA"], select_options: { include_blank: "Choose one" } %>
```

`select_options` maps to Rails' own select options (`include_blank`, `prompt`, `selected`, and so on) — kept separate from the field's own options (`size`, `error`, `class`, etc.) since Rails' `select` takes two different hashes.

Note: if the field ends up `required` (explicitly or via a presence validator) and no `include_blank`/`prompt` is given, Rails automatically adds a blank first option — that's native Rails behavior, not something jet_ui adds.
