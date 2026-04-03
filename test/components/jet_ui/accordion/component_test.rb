# frozen_string_literal: true

require 'test_helper'

class JetUi::Accordion::ComponentTest < ViewComponent::TestCase
  def test_renders_details_element
    render_inline(JetUi::Accordion::Component.new) { 'content' }

    assert_selector 'details.group'
  end

  def test_closed_by_default
    render_inline(JetUi::Accordion::Component.new) { 'content' }

    assert_no_selector 'details[open]'
  end

  def test_open_prop
    render_inline(JetUi::Accordion::Component.new(open: true)) { 'content' }

    assert_selector 'details[open]'
  end

  def test_name_attribute
    render_inline(JetUi::Accordion::Component.new(name: 'faq')) { 'content' }

    assert_selector 'details[name="faq"]'
  end

  def test_custom_class
    render_inline(JetUi::Accordion::Component.new(class: 'my-class')) { 'content' }

    assert_selector 'details.group.my-class'
  end

  def test_summary_renders_summary_tag
    render_inline(JetUi::Accordion::SummaryComponent.new) { 'Question' }

    assert_selector 'summary'
    assert_text 'Question'
  end

  def test_summary_has_chevron_icon
    render_inline(JetUi::Accordion::SummaryComponent.new) { 'Q' }

    assert_selector 'summary svg, summary span'
  end

  def test_summary_no_icon_when_nil
    render_inline(JetUi::Accordion::SummaryComponent.new(icon: nil)) { 'Q' }

    assert_no_selector 'summary svg'
  end

  def test_body_renders_div
    render_inline(JetUi::Accordion::BodyComponent.new) { 'Answer' }

    assert_selector 'div'
    assert_text 'Answer'
  end
end
