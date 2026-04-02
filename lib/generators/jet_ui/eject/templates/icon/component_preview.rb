# frozen_string_literal: true

class JetUi::Icon::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Icon::Component.new('heart')
  end

  def sizes
    render_with_template
  end

  def colors
    render_with_template
  end

  def catalog
    render_with_template
  end
end
