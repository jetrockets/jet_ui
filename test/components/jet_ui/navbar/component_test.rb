# frozen_string_literal: true

require 'test_helper'

class JetUi::Navbar::ComponentTest < ViewComponent::TestCase
  def test_renders_header
    render_inline(JetUi::Navbar::Component.new) { 'content' }

    assert_selector 'header.navbar'
  end

  def test_sticky_by_default
    render_inline(JetUi::Navbar::Component.new) { 'content' }

    assert_selector 'header.navbar-sticky'
  end

  def test_non_sticky
    render_inline(JetUi::Navbar::Component.new(sticky: false)) { 'content' }

    assert_no_selector 'header.navbar-sticky'
  end

  def test_brand_renders_div
    render_inline(JetUi::Navbar::BrandComponent.new) { 'Logo' }

    assert_selector 'div.navbar__brand'
    assert_text 'Logo'
  end

  def test_content_renders_div
    render_inline(JetUi::Navbar::ContentComponent.new) { 'content' }

    assert_selector 'div.navbar__content'
  end

  def test_main_renders_div
    render_inline(JetUi::Navbar::MainComponent.new) { 'main' }

    assert_selector 'div.navbar__main'
  end

  def test_actions_renders_div
    render_inline(JetUi::Navbar::ActionsComponent.new) { 'actions' }

    assert_selector 'div.navbar__actions'
  end

  def test_custom_class
    render_inline(JetUi::Navbar::Component.new(class: 'border-b')) { 'content' }

    assert_selector 'header.navbar.border-b'
  end
end
