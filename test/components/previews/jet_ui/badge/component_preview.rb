# frozen_string_literal: true

# @label Badge
class JetUi::Badge::ComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render(JetUi::Badge::Component.new) { 'Default' }
  end

  # @label Variants
  def variants
    render_with_template
  end

  # @label Sizes
  def sizes
    render_with_template
  end
end
