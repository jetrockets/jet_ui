# frozen_string_literal: true

# @label Stat
class JetUi::Stat::ComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render_with_template
  end

  # @label Positive trend
  def positive_trend
    render_with_template
  end

  # @label Negative trend
  def negative_trend
    render_with_template
  end
end
