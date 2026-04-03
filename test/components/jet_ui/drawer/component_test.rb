# frozen_string_literal: true

require 'test_helper'

class JetUi::Drawer::ComponentTest < ViewComponent::TestCase
  def test_renders_sync_dialog_with_id
    render_inline(JetUi::Drawer::Component.new(id: 'my-drawer'))

    assert_selector 'dialog#my-drawer'
    assert_selector 'dialog[data-drawers-target="dialog"]'
  end

  def test_renders_div_without_id_outside_turbo_frame
    render_inline(JetUi::Drawer::Component.new)

    assert_selector 'div.bg-background'
    assert_no_selector 'dialog'
  end

  def test_header_renders_title
    render_inline(JetUi::Drawer::HeaderComponent.new(title: 'My Drawer'))

    assert_selector 'h3.drawer__title'
    assert_text 'My Drawer'
  end

  def test_header_renders_subtitle
    render_inline(JetUi::Drawer::HeaderComponent.new(subtitle: 'Info'))

    assert_selector 'div.drawer__subtitle'
    assert_text 'Info'
  end

  def test_closable_header_has_close_button
    render_inline(JetUi::Drawer::HeaderComponent.new(closable: true))

    assert_selector 'button.drawer__close'
  end

  def test_non_closable_header_omits_close_button
    render_inline(JetUi::Drawer::HeaderComponent.new(closable: false))

    assert_no_selector 'button.drawer__close'
  end

  def test_body_renders_div
    render_inline(JetUi::Drawer::BodyComponent.new) { 'Body' }

    assert_selector 'div.drawer__body'
    assert_text 'Body'
  end

  def test_footer_renders_div
    render_inline(JetUi::Drawer::FooterComponent.new) { 'Footer' }

    assert_selector 'div.drawer__footer'
  end

  def test_footer_bordered_by_default
    render_inline(JetUi::Drawer::FooterComponent.new) { 'Footer' }

    assert_selector 'div.drawer__footer-bordered'
  end
end
