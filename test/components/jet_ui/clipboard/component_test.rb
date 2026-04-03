# frozen_string_literal: true

require 'test_helper'

class JetUi::Clipboard::ComponentTest < ViewComponent::TestCase
  def test_renders_span_by_default
    render_inline(JetUi::Clipboard::Component.new(value: 'text')) { 'Copy' }

    assert_selector 'span.cursor-pointer'
    assert_text 'Copy'
  end

  def test_has_clipboard_controller
    render_inline(JetUi::Clipboard::Component.new(value: 'text')) { 'Copy' }

    assert_selector '[data-controller="clipboard"]'
  end

  def test_sets_content_value
    render_inline(JetUi::Clipboard::Component.new(value: 'my text')) { 'Copy' }

    assert_selector '[data-clipboard-content-value="my text"]'
  end

  def test_sets_source_id_value
    render_inline(JetUi::Clipboard::Component.new(source_id: 'my_input')) { 'Copy' }

    assert_selector '[data-clipboard-source-id-value="my_input"]'
  end

  def test_sets_success_text_value
    render_inline(JetUi::Clipboard::Component.new(value: 'text', success_text: 'Done!')) { 'Copy' }

    assert_selector '[data-clipboard-success-text-value="Done!"]'
  end

  def test_has_copy_action
    render_inline(JetUi::Clipboard::Component.new(value: 'text')) { 'Copy' }

    assert_selector '[data-action="click->clipboard#copy"]'
  end

  def test_adds_tooltip_controller_when_tooltip_given
    render_inline(JetUi::Clipboard::Component.new(value: 'text', tooltip: 'Click to copy')) { 'Copy' }

    assert_selector '[data-controller="clipboard tooltip"]'
  end

  def test_custom_class
    render_inline(JetUi::Clipboard::Component.new(value: 'text', class: 'extra')) { 'Copy' }

    assert_selector 'span.cursor-pointer.extra'
  end
end
