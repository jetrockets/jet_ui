# frozen_string_literal: true

# @label Group
class JetUi::Group::ComponentPreview < ViewComponent::Preview
  # @label Sticky
  def sticky
    render(JetUi::Group::Component.new) do
      safe_join([
        render(JetUi::Btn::Component.new(variant: :outline)) { 'Cancel' },
        render(JetUi::Btn::Component.new) { 'Save changes' }
      ], ' ')
    end
  end

  # @label Non-sticky
  def non_sticky
    render(JetUi::Group::Component.new(sticky: false)) do
      safe_join([
        render(JetUi::Btn::Component.new(variant: :outline)) { 'Back' },
        render(JetUi::Btn::Component.new(variant: :secondary)) { 'Continue' }
      ], ' ')
    end
  end
end
