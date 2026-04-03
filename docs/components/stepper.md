# Stepper

Multi-step wizard and progress indicator.

## Usage

```erb
<%= jet_ui.stepper do %>
  <%= jet_ui.stepper_step "Cart", status: :completed %>
  <%= jet_ui.stepper_step "Shipping", status: :current %>
  <%= jet_ui.stepper_step "Payment", status: :pending %>
<% end %>

<%# With numbers %>
<%= jet_ui.stepper do %>
  <%= jet_ui.stepper_step "Account", number: 1, status: :completed, description: "Enter details" %>
  <%= jet_ui.stepper_step "Verification", number: 2, status: :current, description: "Verify email" %>
  <%= jet_ui.stepper_step "Finish", number: 3, status: :pending, description: "Complete setup" %>
<% end %>

<%# With icons %>
<%= jet_ui.stepper do %>
  <%= jet_ui.stepper_step "Cart", icon: "shopping-cart", status: :completed %>
  <%= jet_ui.stepper_step "Shipping", icon: "truck", status: :current %>
  <%= jet_ui.stepper_step "Payment", icon: "credit-card", status: :pending %>
<% end %>

<%# With links %>
<%= jet_ui.stepper do %>
  <%= jet_ui.stepper_step "Cart", status: :completed, url: "#cart" %>
  <%= jet_ui.stepper_step "Shipping", status: :current, url: "#shipping" %>
  <%= jet_ui.stepper_step "Payment", status: :pending, url: "#payment" %>
<% end %>
```

## Step options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `status` | Symbol | `:pending` | `:pending`, `:current`, `:completed` |
| `number` | Integer | `nil` | Display a number in the indicator |
| `icon` | String | `nil` | Icon name to display in the indicator |
| `description` | String | `nil` | Secondary text below the title |
| `url` | String | `nil` | Makes the step a link (only for non-pending steps) |

## CSS classes

| Class | Description |
|-------|-------------|
| `.stepper` | Nav wrapper |
| `.stepper__list` | Ordered list |
| `.stepper__item` | Single step |
| `.stepper__item-pending` | Pending state |
| `.stepper__item-current` | Current state |
| `.stepper__item-completed` | Completed state |
| `.stepper__item-has-url` | Step has a link |
| `.stepper__indicator` | Indicator circle |
| `.stepper__dot` | Dot for pending/current |
| `.stepper__number` | Number in indicator |
| `.stepper__title` | Step label |
| `.stepper__description` | Optional description |
| `.stepper__link` | Link wrapper |
