# frozen_string_literal: true

require 'test_helper'

class JetUi::Divider::ComponentTest < ViewComponent::TestCase
  # ---------------------------------------------------------------------------
  # Default rendering
  # ---------------------------------------------------------------------------
  def test_renders_div_element
    render_inline(JetUi::Divider::Component.new)

    assert_selector 'div'
  end

  def test_applies_base_divider_class
    render_inline(JetUi::Divider::Component.new)

    assert_selector 'div.divider'
  end

  def test_no_align_modifier_by_default
    render_inline(JetUi::Divider::Component.new)

    assert_no_selector 'div.divider-start'
    assert_no_selector 'div.divider-end'
  end

  # ---------------------------------------------------------------------------
  # Text content
  # ---------------------------------------------------------------------------
  def test_renders_without_content
    render_inline(JetUi::Divider::Component.new)

    assert_selector 'div.divider'
  end

  def test_renders_text_content
    render_inline(JetUi::Divider::Component.new) { 'or' }

    assert_text 'or'
  end

  # ---------------------------------------------------------------------------
  # Alignment
  # ---------------------------------------------------------------------------
  def test_align_start_adds_divider_start_class
    render_inline(JetUi::Divider::Component.new(align: :start)) { 'Section' }

    assert_selector 'div.divider-start'
  end

  def test_align_end_adds_divider_end_class
    render_inline(JetUi::Divider::Component.new(align: :end)) { 'More' }

    assert_selector 'div.divider-end'
  end

  def test_align_center_adds_no_modifier
    render_inline(JetUi::Divider::Component.new(align: :center)) { 'or' }

    assert_no_selector 'div.divider-start'
    assert_no_selector 'div.divider-end'
  end

  def test_unknown_align_falls_back_to_center
    render_inline(JetUi::Divider::Component.new(align: :left)) { 'or' }

    assert_no_selector 'div.divider-start'
    assert_no_selector 'div.divider-end'
  end

  # ---------------------------------------------------------------------------
  # HTML passthrough
  # ---------------------------------------------------------------------------
  def test_passes_through_id
    render_inline(JetUi::Divider::Component.new(id: 'sep'))

    assert_selector 'div#sep'
  end

  def test_merges_custom_class
    render_inline(JetUi::Divider::Component.new(class: 'my-4'))

    assert_selector 'div.divider.my-4'
  end
end
