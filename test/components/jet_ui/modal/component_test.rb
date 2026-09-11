# frozen_string_literal: true

require 'test_helper'

class JetUi::Modal::ComponentTest < ViewComponent::TestCase
  include ActiveSupport::Testing::Deprecation

  def test_emits_deprecation_warning
    assert_deprecated(/JetUi::Modal::Component is deprecated/, JetUi::Modal::Component.deprecator) do
      render_inline(JetUi::Modal::Component.new(id: 'my-modal'))
    end
  end

  def test_renders_as_a_centered_dialog
    render_inline_without_deprecation { JetUi::Modal::Component.new(id: 'my-modal') }

    assert_selector 'dialog#my-modal.dialog-center'
    assert_selector 'dialog[data-dialogs-target="dialog"]'
  end

  def test_renders_page_variant_without_id_outside_turbo_frame
    render_inline_without_deprecation { JetUi::Modal::Component.new }

    assert_selector 'div.dialog-page'
    assert_no_selector 'dialog'
  end

  def test_header_renders_title
    render_inline(JetUi::Modal::HeaderComponent.new(title: 'My Modal'))

    assert_selector 'h3.dialog__title'
    assert_text 'My Modal'
  end

  def test_header_accepts_legacy_id_param
    render_inline(JetUi::Modal::HeaderComponent.new(title: 'My Modal', id: 'ignored'))

    assert_selector 'h3.dialog__title'
  end

  def test_body_renders_div
    render_inline(JetUi::Modal::BodyComponent.new) { 'Body content' }

    assert_selector 'div.dialog__body'
    assert_text 'Body content'
  end

  def test_footer_renders_div
    render_inline(JetUi::Modal::FooterComponent.new) { 'Footer' }

    assert_selector 'div.dialog__footer'
  end

  private

  def render_inline_without_deprecation(&block)
    JetUi::Modal::Component.deprecator.silence { render_inline(block.call) }
  end
end
