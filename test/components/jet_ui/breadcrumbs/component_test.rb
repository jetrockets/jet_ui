# frozen_string_literal: true

require 'test_helper'

class JetUi::Breadcrumbs::ComponentTest < ViewComponent::TestCase
  def test_renders_nav
    render_inline(JetUi::Breadcrumbs::Component.new) { '' }

    assert_selector 'nav.breadcrumbs'
  end

  def test_renders_ordered_list
    render_inline(JetUi::Breadcrumbs::Component.new) { '' }

    assert_selector 'nav ol.breadcrumbs__list'
  end

  def test_aria_label
    render_inline(JetUi::Breadcrumbs::Component.new) { '' }

    assert_selector 'nav[aria-label="Breadcrumb"]'
  end

  def test_custom_class
    render_inline(JetUi::Breadcrumbs::Component.new(class: 'hidden md:flex')) { '' }

    assert_selector 'nav.hidden'
  end

  def test_item_renders_link
    render_inline(JetUi::Breadcrumbs::ItemComponent.new('Home', href: '/'))

    assert_selector 'li.breadcrumbs__item a.breadcrumbs__link[href="/"]', text: 'Home'
  end

  def test_item_without_href_renders_current
    render_inline(JetUi::Breadcrumbs::ItemComponent.new('Current'))

    assert_selector 'li.breadcrumbs__item span.breadcrumbs__current', text: 'Current'
  end

  def test_item_current_has_aria
    render_inline(JetUi::Breadcrumbs::ItemComponent.new('Current'))

    assert_selector 'span[aria-current="page"]'
  end
end
