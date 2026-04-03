# frozen_string_literal: true

require 'test_helper'

class JetUi::Popover::ComponentTest < ViewComponent::TestCase
  def test_renders_wrapper_div
    render_inline(JetUi::Popover::Component.new) { 'content' }

    assert_selector 'div.w-fit'
  end

  def test_has_popover_controller
    render_inline(JetUi::Popover::Component.new) { 'content' }

    assert_selector '[data-controller="popover"]'
  end

  def test_default_placement_bottom
    render_inline(JetUi::Popover::Component.new) { 'content' }

    assert_selector '[data-popover-placement-value="bottom"]'
  end

  def test_custom_placement
    render_inline(JetUi::Popover::Component.new(placement: :right)) { 'content' }

    assert_selector '[data-popover-placement-value="right"]'
  end

  def test_trigger_renders_span
    render_inline(JetUi::Popover::TriggerComponent.new) { 'Open' }

    assert_selector 'span'
    assert_text 'Open'
  end

  def test_content_renders_popover_div
    render_inline(JetUi::Popover::ContentComponent.new) { 'Popover body' }

    assert_selector 'div.popover'
    assert_selector 'div[data-popover-target="content"]'
    assert_text 'Popover body'
  end

  def test_content_with_title
    render_inline(JetUi::Popover::ContentComponent.new(title: 'My Title')) { 'Body' }

    assert_selector 'div.popover__title'
    assert_text 'My Title'
  end

  def test_content_without_title
    render_inline(JetUi::Popover::ContentComponent.new) { 'Body' }

    assert_no_selector 'div.popover__title'
  end
end
