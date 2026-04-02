# frozen_string_literal: true

require 'test_helper'

class JetUi::Tabs::ComponentTest < ViewComponent::TestCase
  def test_renders_wrapper
    render_inline(JetUi::Tabs::Component.new) { '' }

    assert_selector 'div.tabs'
  end

  def test_renders_list
    render_inline(JetUi::Tabs::Component.new) { '' }

    assert_selector 'ul.tabs__list'
  end

  def test_default_variant_pill
    render_inline(JetUi::Tabs::Component.new) { '' }

    assert_no_selector 'div.tabs--underline'
  end

  def test_underline_variant
    render_inline(JetUi::Tabs::Component.new(variant: :underline)) { '' }

    assert_selector 'div.tabs--underline'
  end

  def test_invalid_variant_falls_back_to_pill
    render_inline(JetUi::Tabs::Component.new(variant: :unknown)) { '' }

    assert_no_selector 'div.tabs--underline'
  end

  def test_item_renders_link
    render_inline(JetUi::Tabs::ItemComponent.new('Profile', href: '/profile'))

    assert_selector 'li.tabs__item a.tabs__link[href="/profile"]', text: 'Profile'
  end

  def test_item_active_class
    render_inline(JetUi::Tabs::ItemComponent.new('Active', href: '#', active: true))

    assert_selector 'a.tabs__link--active'
  end

  def test_item_inactive_no_active_class
    render_inline(JetUi::Tabs::ItemComponent.new('Inactive', href: '#'))

    assert_no_selector 'a.tabs__link--active'
  end

  def test_item_with_icon
    render_inline(JetUi::Tabs::ItemComponent.new('Settings', href: '#', icon: 'cog-6-tooth'))

    assert_selector 'li svg'
  end
end
