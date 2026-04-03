# frozen_string_literal: true

require 'test_helper'

class JetUi::Stepper::ComponentTest < ViewComponent::TestCase
  def test_renders_nav_with_stepper_class
    render_inline(JetUi::Stepper::Component.new)

    assert_selector 'nav.stepper'
  end

  def test_renders_ordered_list
    render_inline(JetUi::Stepper::Component.new)

    assert_selector 'nav.stepper ol.stepper__list'
  end

  def test_renders_step
    render_inline(JetUi::Stepper::StepComponent.new('Step 1', status: :pending))

    assert_selector 'li.stepper__item.stepper__item-pending'
    assert_text 'Step 1'
  end

  JetUi::Stepper::StepComponent::STATUSES.each do |status|
    define_method(:"test_step_status_#{status}") do
      render_inline(JetUi::Stepper::StepComponent.new('S', status: status))

      assert_selector "li.stepper__item-#{status}"
    end
  end

  def test_unknown_status_falls_back_to_pending
    render_inline(JetUi::Stepper::StepComponent.new('S', status: :unknown))

    assert_selector 'li.stepper__item-pending'
  end

  def test_completed_step_shows_check_icon
    render_inline(JetUi::Stepper::StepComponent.new('Done', status: :completed))

    assert_selector 'div.stepper__indicator svg'
    assert_no_selector 'span.stepper__dot'
    assert_no_selector 'span.stepper__number'
  end

  def test_pending_step_without_number_shows_dot
    render_inline(JetUi::Stepper::StepComponent.new('Next', status: :pending))

    assert_selector 'span.stepper__dot'
  end

  def test_step_with_number_shows_number
    render_inline(JetUi::Stepper::StepComponent.new('Profile', status: :current, number: 2))

    assert_selector 'span.stepper__number'
    assert_text '2'
  end

  def test_step_with_icon_shows_icon
    render_inline(JetUi::Stepper::StepComponent.new('Cart', status: :current, icon: 'shopping-cart'))

    assert_selector 'div.stepper__indicator svg'
  end

  def test_step_with_description
    render_inline(JetUi::Stepper::StepComponent.new('Account', status: :pending, description: 'Enter details'))

    assert_selector 'span.stepper__description'
    assert_text 'Enter details'
  end

  def test_step_with_url_and_completed_renders_link
    render_inline(JetUi::Stepper::StepComponent.new('Cart', status: :completed, url: '#cart'))

    assert_selector 'a.stepper__link[href="#cart"]'
  end

  def test_pending_step_with_url_does_not_render_link
    render_inline(JetUi::Stepper::StepComponent.new('Payment', status: :pending, url: '#payment'))

    assert_no_selector 'a.stepper__link'
    assert_selector 'li.stepper__item-has-url'
  end

  def test_merges_custom_class
    render_inline(JetUi::Stepper::Component.new(class: 'mt-4'))

    assert_selector 'nav.stepper.mt-4'
  end
end
