# frozen_string_literal: true

class JetUi::Popover::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Popover::Component.new do
      render(JetUi::Popover::TriggerComponent.new) { 'Hover me' }
      render(JetUi::Popover::ContentComponent.new(title: 'Popover Title')) { 'Some content.' }
    end
  end

  def placement_right
    render JetUi::Popover::Component.new(placement: :right) do
      render(JetUi::Popover::TriggerComponent.new) { 'Hover (right)' }
      render(JetUi::Popover::ContentComponent.new) { 'Appears to the right.' }
    end
  end

  def no_title
    render JetUi::Popover::Component.new do
      render(JetUi::Popover::TriggerComponent.new) { 'Hover me' }
      render(JetUi::Popover::ContentComponent.new) { 'Simple popover without title.' }
    end
  end
end
