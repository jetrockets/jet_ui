# frozen_string_literal: true

class JetUi::Navbar::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Navbar::Component.new do
      render(JetUi::Navbar::BrandComponent.new) { 'App Name' }
      render(JetUi::Navbar::MainComponent.new) do
        render(JetUi::Navbar::ActionsComponent.new) do
          render(JetUi::Btn::Component.new(variant: :outline, size: :sm)) { 'Sign In' }
        end
      end
    end
  end

  def non_sticky
    render JetUi::Navbar::Component.new(sticky: false) do
      render(JetUi::Navbar::BrandComponent.new) { 'Logo' }
    end
  end
end
