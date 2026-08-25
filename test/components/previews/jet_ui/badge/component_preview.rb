# frozen_string_literal: true

# @label Badge
class JetUi::Badge::ComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render(JetUi::Badge::Component.new) { 'Default' }
  end

  # @label Variants
  def variants
    safe_join([
      render(JetUi::Badge::Component.new(variant: :info)) { 'Info' },
      render(JetUi::Badge::Component.new(variant: :success)) { 'Success' },
      render(JetUi::Badge::Component.new(variant: :warning)) { 'Warning' },
      render(JetUi::Badge::Component.new(variant: :error)) { 'Error' }
    ], ' ')
  end

  # @label Sizes
  def sizes
    safe_join(JetUi::Badge::Component::SIZES.map { |size|
      render(JetUi::Badge::Component.new(size: size)) { size.to_s.upcase }
    }, ' ')
  end
end
