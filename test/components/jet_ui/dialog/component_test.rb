# frozen_string_literal: true

require 'test_helper'

class JetUi::Dialog::ComponentTest < ViewComponent::TestCase
  def test_renders_sync_dialog_with_id
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog'))

    assert_selector 'dialog#my-dialog'
    assert_selector 'dialog[data-dialogs-target="dialog"]'
  end

  def test_renders_div_without_id_outside_turbo_frame
    render_inline(JetUi::Dialog::Component.new)

    assert_selector 'div.dialog-page'
    assert_no_selector 'dialog'
  end

  def test_default_position_is_center
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog'))

    assert_selector 'dialog.dialog-center'
  end

  def test_position_left
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', position: :left))

    assert_selector 'dialog.dialog-left'
    assert_selector 'dialog[data-dialog-swipe-value="true"]'
  end

  def test_position_value_serializes_without_symbol_colon
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', position: :left))

    # Regression guard: Stimulus reads this value as a plain string ("left"), not ":left".
    assert_selector 'dialog[data-dialog-position-value="left"]'
  end

  def test_position_right
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', position: :right))

    assert_selector 'dialog.dialog-right'
  end

  def test_position_top
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', position: :top))

    assert_selector 'dialog.dialog-top'
    assert_selector 'dialog.h-2xl'
  end

  def test_position_bottom
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', position: :bottom))

    assert_selector 'dialog.dialog-bottom'
  end

  def test_center_position_disables_swipe
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', position: :center, swipe: true))

    assert_selector 'dialog[data-dialog-swipe-value="false"]'
  end

  def test_size_controls_width_for_vertical_positions
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', size: 'lg'))

    assert_selector 'dialog.w-lg'
  end

  def test_dismissible_value_defaults_true
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog'))

    assert_selector 'dialog[data-dialog-dismissible-value="true"]'
  end

  def test_dismissible_can_be_disabled
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog', dismissible: false))

    assert_selector 'dialog[data-dialog-dismissible-value="false"]'
  end

  def test_has_flash_slot
    render_inline(JetUi::Dialog::Component.new(id: 'my-dialog'))

    assert_selector 'div.dialog__flash-slot'
  end

  def test_header_renders_title
    render_inline(JetUi::Dialog::HeaderComponent.new(title: 'My Dialog'))

    assert_selector 'h3.dialog__title'
    assert_text 'My Dialog'
  end

  def test_header_renders_subtitle
    render_inline(JetUi::Dialog::HeaderComponent.new(subtitle: 'Subtitle'))

    assert_selector 'div.dialog__subtitle'
    assert_text 'Subtitle'
  end

  def test_closable_header_has_close_button
    render_inline(JetUi::Dialog::HeaderComponent.new(closable: true))

    assert_selector 'button.dialog__close'
  end

  def test_non_closable_header_has_no_close_button
    render_inline(JetUi::Dialog::HeaderComponent.new(closable: false))

    assert_no_selector 'button.dialog__close'
  end

  def test_header_bordered_by_default
    render_inline(JetUi::Dialog::HeaderComponent.new)

    assert_selector 'div.dialog__header-bordered'
  end

  def test_body_renders_div
    render_inline(JetUi::Dialog::BodyComponent.new) { 'Body content' }

    assert_selector 'div.dialog__body'
    assert_text 'Body content'
  end

  def test_footer_renders_div
    render_inline(JetUi::Dialog::FooterComponent.new) { 'Footer' }

    assert_selector 'div.dialog__footer'
  end

  def test_footer_bordered_by_default
    render_inline(JetUi::Dialog::FooterComponent.new) { 'Footer' }

    assert_selector 'div.dialog__footer-bordered'
  end

  def test_footer_justify_end
    render_inline(JetUi::Dialog::FooterComponent.new(justify: :end)) { 'Footer' }

    assert_selector 'div.justify-end'
  end
end
