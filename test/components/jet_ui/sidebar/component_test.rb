# frozen_string_literal: true

require 'test_helper'

class JetUi::Sidebar::ComponentTest < ViewComponent::TestCase
  def test_renders_nav
    render_inline(JetUi::Sidebar::Component.new) { 'content' }

    assert_selector 'nav.sidebar'
  end

  def test_has_sidebar_target
    render_inline(JetUi::Sidebar::Component.new) { 'content' }

    assert_selector 'nav[data-sidebar-target="menu"]'
  end

  def test_custom_class
    render_inline(JetUi::Sidebar::Component.new(class: 'extra')) { 'content' }

    assert_selector 'nav.sidebar.extra'
  end

  def test_section_renders_div
    render_inline(JetUi::Sidebar::SectionComponent.new) { 'content' }

    assert_selector 'div.sidebar__section'
  end

  def test_title_renders_h4
    render_inline(JetUi::Sidebar::TitleComponent.new) { 'Navigation' }

    assert_selector 'h4.sidebar__title'
    assert_text 'Navigation'
  end

  def test_menu_renders_ul
    render_inline(JetUi::Sidebar::MenuComponent.new) { 'content' }

    assert_selector 'ul.sidebar__menu'
  end

  def test_link_renders_li_with_link
    render_inline(JetUi::Sidebar::LinkComponent.new(url: '/home')) { 'Home' }

    assert_selector 'li a.sidebar__link[href="/home"]'
    assert_text 'Home'
  end

  def test_disabled_link_renders_span
    render_inline(JetUi::Sidebar::LinkComponent.new(disabled: true)) { 'Coming Soon' }

    assert_selector 'li span.sidebar__link-disabled'
    assert_no_selector 'li a'
  end

  def test_active_link_has_active_class
    render_inline(JetUi::Sidebar::LinkComponent.new(url: '/home', active: true)) { 'Home' }

    assert_selector 'a.sidebar__link-active'
  end
end
