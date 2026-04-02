# frozen_string_literal: true

require 'test_helper'

class JetUi::List::ComponentTest < ViewComponent::TestCase
  def test_renders_default_list
    render_inline(JetUi::List::Component.new) { '' }

    assert_selector 'ul.list'
    refute_selector 'ul.list--divided'
  end

  def test_renders_divided_variant
    render_inline(JetUi::List::Component.new(variant: :divided)) { '' }

    assert_selector 'ul.list.list--divided'
  end

  def test_invalid_variant_falls_back_to_default
    render_inline(JetUi::List::Component.new(variant: :unknown)) { '' }

    refute_selector 'ul.list--divided'
  end

  def test_custom_class
    render_inline(JetUi::List::Component.new(class: 'my-list')) { '' }

    assert_selector 'ul.list.my-list'
  end

  def test_item_renders
    render_inline(JetUi::List::ItemComponent.new) { 'Item text' }

    assert_selector 'li.list__item', text: 'Item text'
  end

  def test_content_renders
    render_inline(JetUi::List::ContentComponent.new) { 'Content text' }

    assert_selector 'div.list__content', text: 'Content text'
  end

  def test_action_renders
    render_inline(JetUi::List::ActionComponent.new) { 'Action' }

    assert_selector 'div.list__action', text: 'Action'
  end
end
