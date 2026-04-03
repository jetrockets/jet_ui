# frozen_string_literal: true

class JetUi::Dropdown::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Dropdown::Component.new do
      render(JetUi::Dropdown::TriggerComponent.new) { 'Open Menu' }
      render(JetUi::Dropdown::MenuComponent.new) do
        render(JetUi::Dropdown::LinkComponent.new(url: '#')) { 'Profile' }
        render(JetUi::Dropdown::LinkComponent.new(url: '#')) { 'Settings' }
        render(JetUi::Dropdown::DividerComponent.new)
        render(JetUi::Dropdown::LinkComponent.new(url: '#')) { 'Sign Out' }
      end
    end
  end

  def with_title
    render JetUi::Dropdown::Component.new do
      render(JetUi::Dropdown::TriggerComponent.new) { 'Menu' }
      render(JetUi::Dropdown::MenuComponent.new) do
        render(JetUi::Dropdown::TitleComponent.new) { 'Account' }
        render(JetUi::Dropdown::LinkComponent.new(url: '#')) { 'Profile' }
        render(JetUi::Dropdown::LinkComponent.new(url: '#', active: true)) { 'Dashboard' }
      end
    end
  end
end
