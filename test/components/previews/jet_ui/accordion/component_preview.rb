# frozen_string_literal: true

class JetUi::Accordion::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Accordion::Component.new(name: 'faq', open: true) do
      render(JetUi::Accordion::SummaryComponent.new) { 'What is this?' }
      render(JetUi::Accordion::BodyComponent.new) { 'An accordion component.' }
    end
  end

  def group
    render_with_template
  end
end
