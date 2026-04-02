# frozen_string_literal: true

class JetUi::Avatar::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Avatar::Component.new(name: 'John Doe')
  end

  def variants
    render_with_template
  end

  def sizes
    render_with_template
  end

  def states
    render_with_template
  end
end
