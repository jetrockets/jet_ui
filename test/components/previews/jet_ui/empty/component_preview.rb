# frozen_string_literal: true

class JetUi::Empty::ComponentPreview < ViewComponent::Preview
  def with_actions
    render_with_template
  end

  def without_actions
    render_with_template
  end
end
