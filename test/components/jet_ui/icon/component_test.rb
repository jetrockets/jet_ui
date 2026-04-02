# frozen_string_literal: true

require 'test_helper'

class JetUi::Icon::ComponentTest < ViewComponent::TestCase
  def test_renders_svg
    render_inline(JetUi::Icon::Component.new('heart'))

    assert_selector 'svg'
  end

  def test_renders_correct_icon_path
    render_inline(JetUi::Icon::Component.new('check'))

    assert_selector 'svg path'
  end

  def test_default_classes
    render_inline(JetUi::Icon::Component.new('heart'))

    assert_selector 'svg.inline-block.shrink-0.align-middle'
  end

  def test_size_class
    render_inline(JetUi::Icon::Component.new('heart', size: 6))

    assert_selector 'svg.size-6'
  end

  def test_custom_class
    render_inline(JetUi::Icon::Component.new('heart', class: 'text-red-500'))

    assert_selector 'svg.text-red-500'
  end

  def test_aria_hidden
    render_inline(JetUi::Icon::Component.new('heart'))

    assert_selector 'svg[aria-hidden="true"]'
  end

  def test_aria_label
    render_inline(JetUi::Icon::Component.new('arrow-right'))

    assert_selector 'svg[aria-label="Arrow-right"]'
  end

  def test_extra_html_attributes
    render_inline(JetUi::Icon::Component.new('heart', id: 'my-icon'))

    assert_selector 'svg#my-icon'
  end

  def test_uses_current_color
    render_inline(JetUi::Icon::Component.new('heart'))

    assert_includes page.native.to_s, 'currentColor'
  end

  def test_no_hardcoded_dimensions
    render_inline(JetUi::Icon::Component.new('heart'))

    assert_no_selector 'svg[width]'
    assert_no_selector 'svg[height]'
  end

  def test_viewbox_preserved
    render_inline(JetUi::Icon::Component.new('heart'))

    assert_selector 'svg[viewbox="0 0 24 24"]'
  end
end
