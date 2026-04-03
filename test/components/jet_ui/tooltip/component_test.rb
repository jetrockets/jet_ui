# frozen_string_literal: true

require 'test_helper'

class JetUi::Tooltip::ComponentTest < ViewComponent::TestCase
  def test_renders_span_by_default
    render_inline(JetUi::Tooltip::Component.new(title: 'Tooltip text')) { 'Hover me' }

    assert_selector 'span.w-fit'
    assert_text 'Hover me'
  end

  def test_has_tooltip_controller
    render_inline(JetUi::Tooltip::Component.new(title: 'Tooltip text')) { 'Hover me' }

    assert_selector '[data-controller="tooltip"]'
  end

  def test_sets_content_value
    render_inline(JetUi::Tooltip::Component.new(title: 'My tip')) { 'Hover me' }

    assert_selector '[data-tooltip-content-value="My tip"]'
  end

  def test_default_placement_top
    render_inline(JetUi::Tooltip::Component.new(title: 'tip')) { 'Hover' }

    assert_selector '[data-tooltip-placement-value="top"]'
  end

  def test_custom_placement
    render_inline(JetUi::Tooltip::Component.new(title: 'tip', placement: :right)) { 'Hover' }

    assert_selector '[data-tooltip-placement-value="right"]'
  end
end
