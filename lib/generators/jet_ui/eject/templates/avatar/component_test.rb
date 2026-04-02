# frozen_string_literal: true

require 'test_helper'

class JetUi::Avatar::ComponentTest < ViewComponent::TestCase
  def test_renders_icon_fallback_when_no_src_or_name
    render_inline(JetUi::Avatar::Component.new)

    assert_selector 'div svg'
  end

  def test_renders_initials_when_name_provided
    render_inline(JetUi::Avatar::Component.new(name: 'John Doe'))

    assert_selector 'div span', text: 'JD'
  end

  def test_renders_image_when_src_provided
    render_inline(JetUi::Avatar::Component.new(src: '/avatar.jpg', name: 'Jane Smith'))

    assert_selector 'div img[src="/avatar.jpg"]'
  end

  def test_image_takes_priority_over_name
    render_inline(JetUi::Avatar::Component.new(src: '/avatar.jpg', name: 'John Doe'))

    assert_selector 'img'
    assert_no_selector 'span'
  end

  def test_default_variant_circle
    render_inline(JetUi::Avatar::Component.new)

    assert_selector 'div.avatar--circle'
  end

  def test_rounded_variant
    render_inline(JetUi::Avatar::Component.new(variant: :rounded))

    assert_selector 'div.avatar--rounded'
    assert_no_selector 'div.avatar--circle'
  end

  def test_square_variant
    render_inline(JetUi::Avatar::Component.new(variant: :square))

    assert_no_selector 'div.avatar--circle'
    assert_no_selector 'div.avatar--rounded'
  end

  def test_invalid_variant_falls_back_to_circle
    render_inline(JetUi::Avatar::Component.new(variant: :unknown))

    assert_selector 'div.avatar--circle'
  end

  def test_custom_class
    render_inline(JetUi::Avatar::Component.new(class: 'border-2'))

    assert_selector 'div.border-2'
  end

  def test_initials_two_chars_max
    render_inline(JetUi::Avatar::Component.new(name: 'Alice Bob Carol'))

    assert_selector 'div span', text: 'AB'
  end

  def test_single_name_initial
    render_inline(JetUi::Avatar::Component.new(name: 'Alice'))

    assert_selector 'div span', text: 'A'
  end
end
