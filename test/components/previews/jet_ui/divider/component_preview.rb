# frozen_string_literal: true

class JetUi::Divider::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Divider::Component.new
  end

  def with_text
    render_with_template
  end

  def aligned
    render_with_template
  end
end
