# frozen_string_literal: true

require 'test_helper'

class JetUi::Modal::ComponentTest < ViewComponent::TestCase
  def test_renders_sync_dialog_with_id
    render_inline(JetUi::Modal::Component.new(id: 'my-modal'))

    assert_selector 'dialog#my-modal'
    assert_selector 'dialog[data-modals-target="dialog"]'
  end

  def test_renders_div_without_id_outside_turbo_frame
    render_inline(JetUi::Modal::Component.new)

    assert_selector 'div.modal'
    assert_no_selector 'dialog'
  end

  def test_header_renders_title
    render_inline(JetUi::Modal::HeaderComponent.new(title: 'My Modal'))

    assert_selector 'h3.modal__title'
    assert_text 'My Modal'
  end

  def test_header_renders_subtitle
    render_inline(JetUi::Modal::HeaderComponent.new(subtitle: 'Subtitle'))

    assert_selector 'div.modal__subtitle'
    assert_text 'Subtitle'
  end

  def test_closable_header_has_close_button
    render_inline(JetUi::Modal::HeaderComponent.new(closable: true))

    assert_selector 'button.modal__close'
  end

  def test_non_closable_header_has_no_close_button
    render_inline(JetUi::Modal::HeaderComponent.new(closable: false))

    assert_no_selector 'button.modal__close'
  end

  def test_header_bordered_by_default
    render_inline(JetUi::Modal::HeaderComponent.new)

    assert_selector 'div.modal__header-bordered'
  end

  def test_body_renders_div
    render_inline(JetUi::Modal::BodyComponent.new) { 'Body content' }

    assert_selector 'div.modal__body'
    assert_text 'Body content'
  end

  def test_footer_renders_div
    render_inline(JetUi::Modal::FooterComponent.new) { 'Footer' }

    assert_selector 'div.modal__footer'
  end

  def test_footer_bordered_by_default
    render_inline(JetUi::Modal::FooterComponent.new) { 'Footer' }

    assert_selector 'div.modal__footer-bordered'
  end

  def test_footer_justify_end
    render_inline(JetUi::Modal::FooterComponent.new(justify: :end)) { 'Footer' }

    assert_selector 'div.justify-end'
  end
end
