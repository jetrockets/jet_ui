# frozen_string_literal: true

require 'test_helper'

class JetUi::Header::ComponentTest < ViewComponent::TestCase
  def test_renders_div
    render_inline(JetUi::Header::Component.new) { 'content' }

    assert_selector 'div'
    assert_text 'content'
  end

  def test_default_justify_between
    render_inline(JetUi::Header::Component.new) { 'content' }

    assert_selector 'div.header--justify-between'
  end

  def test_sticky_adds_classes
    render_inline(JetUi::Header::Component.new(sticky: true)) { 'content' }

    assert_selector 'div.header--sticky'
  end

  def test_bordered_adds_class
    render_inline(JetUi::Header::Component.new(bordered: true)) { 'content' }

    assert_selector 'div.header--bordered'
  end

  def test_heading_renders_div
    render_inline(JetUi::Header::HeadingComponent.new) { 'content' }

    assert_selector 'div.header__heading'
  end

  def test_title_renders_h1
    render_inline(JetUi::Header::TitleComponent.new) { 'Page Title' }

    assert_selector 'h1'
    assert_text 'Page Title'
  end

  def test_subtitle_renders_p
    render_inline(JetUi::Header::SubtitleComponent.new) { 'Subtitle text' }

    assert_selector 'p.header__subtitle'
    assert_text 'Subtitle text'
  end

  def test_actions_renders_div
    render_inline(JetUi::Header::ActionsComponent.new) { 'actions' }

    assert_selector 'div.header__actions'
  end
end
