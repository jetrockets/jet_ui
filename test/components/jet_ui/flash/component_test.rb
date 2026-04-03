# frozen_string_literal: true

require 'test_helper'

class JetUi::Flash::ComponentTest < ViewComponent::TestCase
  def test_renders_turbo_frame
    render_inline(JetUi::Flash::Component.new(messages: {}))

    assert_selector 'turbo-frame#flash'
  end

  def test_empty_messages_renders_no_items
    render_inline(JetUi::Flash::Component.new(messages: {}))

    assert_no_selector 'div.flash-item'
  end

  def test_renders_notice_message
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Saved!' }))

    assert_selector 'div.flash-item.flash-item-info'
    assert_text 'Saved!'
  end

  def test_renders_alert_message
    render_inline(JetUi::Flash::Component.new(messages: { alert: 'Error!' }))

    assert_selector 'div.flash-item.flash-item-error'
    assert_text 'Error!'
  end

  def test_renders_success_message
    render_inline(JetUi::Flash::Component.new(messages: { success: 'Done!' }))

    assert_selector 'div.flash-item.flash-item-success'
  end

  def test_renders_warning_message
    render_inline(JetUi::Flash::Component.new(messages: { warning: 'Watch out!' }))

    assert_selector 'div.flash-item.flash-item-warning'
  end

  def test_unknown_type_uses_type_as_class
    render_inline(JetUi::Flash::Component.new(messages: { custom: 'Hello' }))

    assert_selector 'div.flash-item.flash-item-custom'
  end

  def test_dismissible_renders_close_button
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }))

    assert_selector 'button.flash-item__close'
  end

  def test_not_dismissible_hides_close_button
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }, dismissible: false))

    assert_no_selector 'button.flash-item__close'
  end

  def test_dismissible_sets_stimulus_values
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }))

    assert_selector 'div[data-flash-dismiss-after-value]'
    assert_selector 'div[data-flash-show-delay-value]'
  end

  def test_not_dismissible_omits_stimulus_values
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }, dismissible: false))

    assert_no_selector 'div[data-flash-dismiss-after-value]'
  end

  def test_item_has_stimulus_controller
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }))

    assert_selector 'div[data-controller="flash"]'
  end

  def test_item_starts_hidden
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }))

    assert_selector 'div.flash-item--hidden'
  end

  def test_blank_messages_are_skipped
    render_inline(JetUi::Flash::Component.new(messages: { notice: '', alert: 'Real error' }))

    assert_selector 'div.flash-item', count: 1
  end

  def test_item_id_includes_flash_type
    render_inline(JetUi::Flash::Component.new(messages: { notice: 'Hi' }))

    assert_selector 'div#flash-notice'
  end
end
