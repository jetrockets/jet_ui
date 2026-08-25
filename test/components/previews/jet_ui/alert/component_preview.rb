# frozen_string_literal: true

# @label Alert
class JetUi::Alert::ComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render(JetUi::Alert::Component.new) { 'This is a default alert.' }
  end

  # @label Success
  def success
    render(JetUi::Alert::Component.new(variant: :success)) do
      safe_join([
        render(JetUi::Alert::TitleComponent.new) { 'Success' },
        render(JetUi::Alert::DescriptionComponent.new) { 'Your changes have been saved.' }
      ])
    end
  end

  # @label Error
  def error
    render(JetUi::Alert::Component.new(variant: :error)) do
      safe_join([
        render(JetUi::Alert::TitleComponent.new) { 'Unable to save changes' },
        render(JetUi::Alert::DescriptionComponent.new) { 'Check the form and try again.' }
      ])
    end
  end
end
