# frozen_string_literal: true

class JetUi::Tooltip::ComponentPreview < ViewComponent::Preview
  def top
    render JetUi::Tooltip::Component.new(title: 'Top tooltip', placement: :top) { 'Hover (top)' }
  end

  def bottom
    render JetUi::Tooltip::Component.new(title: 'Bottom tooltip', placement: :bottom) { 'Hover (bottom)' }
  end

  def left
    render JetUi::Tooltip::Component.new(title: 'Left tooltip', placement: :left) { 'Hover (left)' }
  end

  def right
    render JetUi::Tooltip::Component.new(title: 'Right tooltip', placement: :right) { 'Hover (right)' }
  end
end
