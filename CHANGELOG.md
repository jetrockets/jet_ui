# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.8] - 2026-07-09

### Added
- `@jetrockets/jet-ui` npm package for Vite/esbuild/Webpack users — import Stimulus controllers without vendoring
- `JsRuntime` module for auto-detecting JS bundler (Vite, esbuild, Webpack) vs importmap
- `jet_ui:install` generator now detects runtime and prints runtime-specific setup instructions

### Fixed
- Importmap crash (`Errno::EISDIR`) — removed invalid directory path from `importmap.paths`

## [0.2.7] - 2026-05-29

### Added
- Generator tests for `jet_ui:eject` and `jet_ui:install`

### Changed
- `jet_ui:eject --help` now lists all available components derived directly from `MANIFEST` — always accurate, never stale
- `jet_ui:install --help` updated with gem overview and pointer to `jet_ui:eject --help`
- Upgrade development Ruby version to 4.0.5

### Removed
- Stale `USAGE` files for `eject` and `install` generators — superseded by the class-level `desc`

## [0.2.6] - 2026-05-13

### Changed
- Upgrade development Ruby version to 4.0.4

## [0.2.5] - 2026-05-11

### Added
- `CONTRIBUTING.md` — contribution guide for the open source project

### Changed
- Upgrade development Ruby version to 4.0.3

## [0.2.4] - 2026-04-05

### Fixed
- Accordion component migrated from inline Tailwind utilities to a dedicated `accordion.css` with BEM classes — prevents class purging in consumer apps

## [0.2.3] - 2026-04-05

JS-dependent components — overlays, navigation, and interactive patterns. All Stimulus controllers auto-registered via the existing `eagerLoadControllersFrom("jet_ui", application)` line with no extra setup required.

### Added
- `jet_ui.accordion`, `jet_ui.accordion_summary`, `jet_ui.accordion_body` — native `<details>`/`<summary>` accordion with animated chevron; no JS required
- `jet_ui.clipboard` — copy-to-clipboard; accepts `value:` or `source_id:`; optional tooltip integration
- `jet_ui.sidebar`, `jet_ui.sidebar_menu`, `jet_ui.sidebar_section`, `jet_ui.sidebar_title`, `jet_ui.sidebar_link` — sidebar navigation with active-link detection
- `jet_ui.header`, `jet_ui.header_heading`, `jet_ui.header_title`, `jet_ui.header_subtitle`, `jet_ui.header_actions` — page header with `direction:`, `align:`, `justify:`, `sticky:`, and `bordered:` modifiers
- `jet_ui.navbar`, `jet_ui.navbar_brand`, `jet_ui.navbar_main`, `jet_ui.navbar_content`, `jet_ui.navbar_actions` — top navigation bar with optional sticky; responsive grid layout at `md` breakpoint
- `jet_ui.modal`, `jet_ui.modal_header`, `jet_ui.modal_body`, `jet_ui.modal_footer` — `<dialog>`-based modal; supports inline (id-based) and Turbo Frame patterns; size variants (`sm`…`6xl`); backdrop-click to close
- `jet_ui.drawer`, `jet_ui.drawer_header`, `jet_ui.drawer_body`, `jet_ui.drawer_footer` — `<dialog>`-based side drawer with swipe-to-close on mobile; same dual-mode support as Modal
- `jet_ui.dropdown`, `jet_ui.dropdown_trigger`, `jet_ui.dropdown_menu`, `jet_ui.dropdown_link`, `jet_ui.dropdown_button`, `jet_ui.dropdown_title`, `jet_ui.dropdown_divider` — floating dropdown with smart viewport-aware positioning; no external dependency
- `jet_ui.tooltip` — hover/focus tooltip with `placement:` (`top`, `bottom`, `left`, `right`) and configurable offset; no external dependency
- `jet_ui.popover`, `jet_ui.popover_trigger`, `jet_ui.popover_content` — click-triggered popover with title and body slots; same placement options as Tooltip
- `jet_ui.turbo_confirm` — replaces the default browser `confirm()` with a styled `<dialog>`; integrates with `data-turbo-confirm`
- Stimulus controllers: `clipboard`, `modal`, `modals`, `drawer`, `drawers`, `dropdown`, `tooltip`, `popover`, `turbo_confirm`
- CSS stylesheets for all new components; all files declare `@layer theme, base, components, utilities` for correct Tailwind v4 layer ordering
- Docs under `docs/components/` for all new components

### Fixed
- Navbar and Header CSS use native `@media` queries — Tailwind v4 strips responsive prefixes from `@apply` inside `@layer` blocks
- Popover parent container gets `position: relative` via `[data-controller~="popover"]` CSS attribute selector
- `modals` and `drawers` controllers use `open(e)` action to match `data-action` triggers
- `turbo_confirm` controller uses `window.Turbo` global instead of an ES module import

## [0.2.2] - 2026-04-03

### Added
- `jet_ui.flash` — flash message display with auto-dismiss and manual close; variants (`info`, `success`, `warning`, `error`); renders all flash types in one call via `messages: flash`
- `flash_controller.js` — Stimulus controller with configurable auto-dismiss timeout; safe to use when a controller with the same name is already registered in the host app
- `jet_ui:install` now also injects `eagerLoadControllersFrom("jet_ui", application)` into the Stimulus controllers index — all current and future JS controllers are registered automatically

## [0.2.1] - 2026-04-02

CI hardening, Rails/Ruby compatibility fixes, and remaining static components.

### Added
- `jet_ui.avatar` — avatar with image, initials fallback, sizes, and shape modifiers
- `jet_ui.breadcrumbs`, `jet_ui.breadcrumbs_item` — breadcrumb trail
- `jet_ui.divider` — horizontal rule with optional text and alignment (`start`, `center`, `end`)
- `jet_ui.empty`, `jet_ui.empty_icon`, `jet_ui.empty_title`, `jet_ui.empty_description`, `jet_ui.empty_actions` — empty-state container
- `jet_ui.icon` — SVG icon from the Tabler icon set; accepts `size:` and arbitrary HTML attributes
- `jet_ui.spinner` — loading spinner delegating to `jet_ui.icon`
- `jet_ui.list`, `jet_ui.list_item`, `jet_ui.list_icon`, `jet_ui.list_content`, `jet_ui.list_action` — structured list with divider and hover options
- `jet_ui.pagy` — pagination wrapper for [Pagy](https://github.com/ddnexus/pagy)
- `jet_ui.stepper`, `jet_ui.stepper_step` — multi-step progress indicator with `completed`, `current`, `pending` states; icon, number, and description variants
- `jet_ui.table`, `jet_ui.table_thead`, `jet_ui.table_tbody`, `jet_ui.table_tfoot`, `jet_ui.table_tr`, `jet_ui.table_th`, `jet_ui.table_td` — semantic HTML table with `hovered`, `bordered`, `striped` modifiers
- `jet_ui.tabs`, `jet_ui.tabs_item` — tab navigation with `underline` and `pill` variants
- `jet_ui.timeline`, `jet_ui.timeline_item`, `jet_ui.timeline_dot`, `jet_ui.timeline_time`, `jet_ui.timeline_content` — vertical timeline
- CSS stylesheets and docs for all new components
- CI matrix across Ruby 3.0–4.0 and Rails 7.0–8.1; RuboCop, bundler-audit, and generator smoke-test jobs; gem build validation job

### Changed
- Minimum Rails version raised to 7.0

### Security
- Updated `json`, `loofah`, and `action_text-trix` to fix known advisories

## [0.2.0] - 2026-03-27

**Major architectural overhaul** — component naming and usage completely redesigned to match the [ui.jetrockets.com](https://ui.jetrockets.com) design system. New short-form helper API replaces verbose class references throughout.

### Added
- `JetUi::Builder` — resolves `jet_ui.btn`, `jet_ui.card_header`, `jet_ui.alert_title`, etc. to their respective component classes automatically; no explicit class references needed in views
- `jet_ui.badge` — badge with variants (`default`, `info`, `success`, `warning`, `error`), sizes (`xs`, `sm`, `md`, `lg`), and `rounded` modifier
- `jet_ui.alert`, `jet_ui.alert_title`, `jet_ui.alert_description`, `jet_ui.alert_icon` — contextual alert; two-column layout when icon is present
- `jet_ui.group` — button group with sticky border merging
- `jet_ui.stat`, `jet_ui.stat_label`, `jet_ui.stat_value`, `jet_ui.stat_description` — metric stat card
- Full semantic color token system in `theme.css` — accent, muted, destructive, success, warning, info with soft/border/foreground variants; dark mode via `.dark` class; radius tokens
- Single CSS entry point `jet_ui.css` — one `@import` in the host app covers all current and future components; new additions are picked up automatically on the next CSS build

### Changed
- **Breaking:** Views now use short helpers (`jet_ui.btn`, `jet_ui.card`, `jet_ui.card_header`, etc.) instead of `render JetUi::Btn::Component.new(...)` — the `jet_ui` builder is available in all views via `JetUiHelper`
- **Breaking:** Btn variant `primary` renamed to `default`; `outlined:` modifier removed (use `variant: :outline` instead); `href:` renamed to `url:`; size `xl` removed; icon sizes added (`icon_xs`…`icon_lg`)
- **Breaking:** `jet_ui:install` now injects a single `@import "jet_ui.css"` instead of individual per-component imports
- Card header/footer layout now uses CSS modifier classes (`direction:`, `align:`, `justify:` params) instead of raw Tailwind utilities
- `jet_ui:eject` updated with `--skip-test` and `--skip-preview` flags and improved `--help` output

## [0.1.0] - 2026-03-13

Initial release.

### Added
- `JetUi::Engine` — Rails engine with auto-loaded components, helpers, and assets
- `JetUiHelper` with `jet_ui` view helper available in all views
- `JetUi::BtnComponent` — button with variants (`primary`, `secondary`, `danger`, `ghost`, `link`), sizes (`xs`, `sm`, `md`, `lg`, `xl`), and modifiers (`rounded`, `block`, `circle`, `outlined`); accepts `href:` for anchor rendering
- `JetUi::CardComponent` — card container with `header`, `body`, and `footer` slots via `JetUi::Card::HeaderComponent` and `JetUi::Card::FooterComponent`
- CSS stylesheets for btn and card components
- `jet_ui:install` generator — detects Tailwind CSS source file and injects per-component CSS imports; safe to re-run after upgrades
- `jet_ui:eject` generator — copies any component's Ruby, CSS, test, and preview files into the host app for local customisation
- ViewComponent previews and Minitest tests for all components
