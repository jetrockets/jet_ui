# frozen_string_literal: true

# @label Alert
class JetUi::Alert::ComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render(JetUi::Alert::Component.new) { 'This is a default alert.' }
  end

  # @label Success
  def success
    render_with_template
  end

  # @label Error
  def error
    render_with_template
  end
end
