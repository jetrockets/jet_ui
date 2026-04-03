# frozen_string_literal: true

class JetUi::TurboConfirm::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::TurboConfirm::Component.new
  end
end
