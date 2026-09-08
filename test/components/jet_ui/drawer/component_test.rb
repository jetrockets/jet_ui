# frozen_string_literal: true

require 'test_helper'

class JetUi::Drawer::ComponentTest < ViewComponent::TestCase
  include ActiveSupport::Testing::Deprecation

  def test_emits_deprecation_warning
    assert_deprecated(/JetUi::Drawer::Component is deprecated/, JetUi::Drawer::Component.deprecator) do
      render_inline(JetUi::Drawer::Component.new(id: 'my-drawer'))
    end
  end

  def test_renders_as_a_right_positioned_dialog
    render_inline_without_deprecation { JetUi::Drawer::Component.new(id: 'my-drawer') }

    assert_selector 'dialog#my-drawer.dialog-right'
    assert_selector 'dialog[data-dialogs-target="dialog"]'
  end

  def test_renders_page_variant_without_id_outside_turbo_frame
    render_inline_without_deprecation { JetUi::Drawer::Component.new }

    assert_selector 'div.dialog-page'
    assert_no_selector 'dialog'
  end

  def test_header_renders_title
    render_inline(JetUi::Drawer::HeaderComponent.new(title: 'My Drawer'))

    assert_selector 'h3.dialog__title'
    assert_text 'My Drawer'
  end

  def test_body_renders_div
    render_inline(JetUi::Drawer::BodyComponent.new) { 'Body content' }

    assert_selector 'div.dialog__body'
    assert_text 'Body content'
  end

  def test_footer_renders_div
    render_inline(JetUi::Drawer::FooterComponent.new) { 'Footer' }

    assert_selector 'div.dialog__footer'
  end

  private

  def render_inline_without_deprecation(&block)
    JetUi::Drawer::Component.deprecator.silence { render_inline(block.call) }
  end
end
