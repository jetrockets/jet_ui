# frozen_string_literal: true

# @label Stat
class JetUi::Stat::ComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render_stat(label: 'Total revenue', value: '$24,780', description: 'This month')
  end

  # @label Positive trend
  def positive_trend
    render_stat(
      label: 'Active users',
      value: '2,340',
      description: '12% from last month',
      variant: :success
    )
  end

  # @label Negative trend
  def negative_trend
    render_stat(
      label: 'Conversion rate',
      value: '3.2%',
      description: '0.8% from last month',
      variant: :error
    )
  end

  private

  def render_stat(label:, value:, description:, variant: :default)
    render(JetUi::Stat::Component.new) do
      safe_join([
        render(JetUi::Stat::LabelComponent.new) { label },
        render(JetUi::Stat::ValueComponent.new) { value },
        render(JetUi::Stat::DescriptionComponent.new(variant: variant)) { description }
      ])
    end
  end
end
