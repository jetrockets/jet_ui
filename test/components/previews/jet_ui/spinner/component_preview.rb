# frozen_string_literal: true

class JetUi::Spinner::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Spinner::Component.new
  end

  def sizes
    render_with_template
  end

  def colors
    render_with_template
  end
end
