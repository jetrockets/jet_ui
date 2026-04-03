# frozen_string_literal: true

require 'test_helper'

class JetUi::Timeline::ComponentTest < ViewComponent::TestCase
  def test_renders_timeline_wrapper
    render_inline(JetUi::Timeline::Component.new)

    assert_selector 'div.timeline'
  end

  def test_renders_item
    render_inline(JetUi::Timeline::ItemComponent.new)

    assert_selector 'div.timeline-item'
  end

  def test_dot_default_variant
    render_inline(JetUi::Timeline::DotComponent.new)

    assert_selector 'div.timeline-dot.timeline-dot-default'
  end

  JetUi::Timeline::DotComponent::VARIANTS.each do |variant|
    define_method(:"test_dot_variant_#{variant}") do
      render_inline(JetUi::Timeline::DotComponent.new(variant: variant))

      assert_selector "div.timeline-dot.timeline-dot-#{variant}"
    end
  end

  def test_dot_unknown_variant_falls_back_to_default
    render_inline(JetUi::Timeline::DotComponent.new(variant: :nonexistent))

    assert_selector 'div.timeline-dot.timeline-dot-default'
  end

  def test_dot_without_icon_has_no_icon_class
    render_inline(JetUi::Timeline::DotComponent.new)

    assert_no_selector 'div.timeline-dot-icon'
  end

  def test_dot_with_icon_adds_icon_class
    render_inline(JetUi::Timeline::DotComponent.new(icon: 'check'))

    assert_selector 'div.timeline-dot.timeline-dot-icon'
  end

  def test_renders_content
    render_inline(JetUi::Timeline::ContentComponent.new) { 'Event happened' }

    assert_selector 'div.timeline-content'
    assert_text 'Event happened'
  end

  def test_renders_time
    render_inline(JetUi::Timeline::TimeComponent.new) { '2 hours ago' }

    assert_selector 'time.timeline-time'
    assert_text '2 hours ago'
  end

  def test_merges_custom_class_on_wrapper
    render_inline(JetUi::Timeline::Component.new(class: 'mt-4'))

    assert_selector 'div.timeline.mt-4'
  end
end
