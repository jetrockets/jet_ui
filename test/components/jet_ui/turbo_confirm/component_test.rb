# frozen_string_literal: true

require 'test_helper'

class JetUi::TurboConfirm::ComponentTest < ViewComponent::TestCase
  def test_renders_dialog
    render_inline(JetUi::TurboConfirm::Component.new)

    assert_selector 'dialog#turbo-confirm'
  end

  def test_has_turbo_confirm_controller
    render_inline(JetUi::TurboConfirm::Component.new)

    assert_selector 'dialog[data-controller="turbo-confirm"]'
  end

  def test_has_form_with_dialog_method
    render_inline(JetUi::TurboConfirm::Component.new)

    assert_selector 'form[method="dialog"]'
  end

  def test_has_cancel_button
    render_inline(JetUi::TurboConfirm::Component.new)

    assert_selector 'button[value="cancel"]'
    assert_text 'Cancel'
  end

  def test_has_confirm_button
    render_inline(JetUi::TurboConfirm::Component.new)

    assert_selector 'button[value="confirm"]'
  end

  def test_has_modal_classes
    render_inline(JetUi::TurboConfirm::Component.new)

    assert_selector 'dialog.modal'
  end
end
