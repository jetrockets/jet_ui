# frozen_string_literal: true

require 'test_helper'

class JetUi::Spinner::ComponentTest < ViewComponent::TestCase
  def test_renders_svg
    render_inline(JetUi::Spinner::Component.new)

    assert_selector 'svg'
  end

  def test_default_size
    render_inline(JetUi::Spinner::Component.new)

    assert_selector 'svg[style*="calc(var(--spacing) * 6)"]'
  end

  def test_custom_size
    render_inline(JetUi::Spinner::Component.new(size: 10))

    assert_selector 'svg[style*="calc(var(--spacing) * 10)"]'
  end

  def test_custom_class
    render_inline(JetUi::Spinner::Component.new(class: 'text-blue-500'))

    assert_selector 'svg.text-blue-500'
  end

  def test_has_animation
    render_inline(JetUi::Spinner::Component.new)

    assert_selector 'svg circle animate'
  end
end
