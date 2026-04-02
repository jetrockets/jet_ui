# frozen_string_literal: true

require 'test_helper'

class JetUi::Empty::ComponentTest < ViewComponent::TestCase
  def test_renders_container
    render_inline(JetUi::Empty::Component.new) { '' }

    assert_selector 'div.empty'
  end

  def test_custom_class
    render_inline(JetUi::Empty::Component.new(class: 'my-custom')) { '' }

    assert_selector 'div.empty.my-custom'
  end

  def test_title_renders_h3
    render_inline(JetUi::Empty::TitleComponent.new) { 'No items' }

    assert_selector 'h3.empty__title', text: 'No items'
  end

  def test_description_renders_paragraph
    render_inline(JetUi::Empty::DescriptionComponent.new) { 'Create one to get started.' }

    assert_selector 'p.empty__description', text: 'Create one to get started.'
  end

  def test_icon_renders_container_with_svg
    render_inline(JetUi::Empty::IconComponent.new('inbox'))

    assert_selector 'div.empty__icon svg'
  end

  def test_actions_renders_group
    render_inline(JetUi::Empty::ActionsComponent.new) { '' }

    assert_selector 'div.empty__actions'
  end

  def test_renders_content
    render_inline(JetUi::Empty::Component.new) { '<h3>No items</h3>'.html_safe }

    assert_selector 'div.empty h3'
  end
end
