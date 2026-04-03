# frozen_string_literal: true

require 'test_helper'

class JetUi::Dropdown::ComponentTest < ViewComponent::TestCase
  def test_renders_with_dropdown_class
    render_inline(JetUi::Dropdown::Component.new) { 'content' }

    assert_selector 'div.dropdown'
  end

  def test_has_stimulus_controller
    render_inline(JetUi::Dropdown::Component.new) { 'content' }

    assert_selector 'div[data-controller="dropdown"]'
  end

  def test_trigger_renders_span
    render_inline(JetUi::Dropdown::TriggerComponent.new) { 'Open' }

    assert_selector 'span[role="button"]'
    assert_text 'Open'
  end

  def test_trigger_has_dropdown_target
    render_inline(JetUi::Dropdown::TriggerComponent.new) { 'Open' }

    assert_selector '[data-dropdown-target="trigger"]'
  end

  def test_menu_renders_wrapper
    render_inline(JetUi::Dropdown::MenuComponent.new) { 'items' }

    assert_selector 'div.dropdown__menu'
    assert_selector 'div[data-dropdown-target="menu"]'
  end

  def test_link_renders_li_with_anchor
    render_inline(JetUi::Dropdown::LinkComponent.new(url: '/path')) { 'Link' }

    assert_selector 'li.dropdown__item a.dropdown__link'
    assert_text 'Link'
  end

  def test_active_link_has_active_class
    render_inline(JetUi::Dropdown::LinkComponent.new(url: '/path', active: true)) { 'Link' }

    assert_selector 'a.dropdown__link-active'
  end

  def test_title_renders_h6
    render_inline(JetUi::Dropdown::TitleComponent.new) { 'Title' }

    assert_selector 'h6.dropdown__title'
    assert_text 'Title'
  end

  def test_divider_renders_li
    render_inline(JetUi::Dropdown::DividerComponent.new)

    assert_selector 'li.dropdown__divider'
  end

  def test_custom_class
    render_inline(JetUi::Dropdown::Component.new(class: 'extra')) { 'content' }

    assert_selector 'div.dropdown.extra'
  end
end
