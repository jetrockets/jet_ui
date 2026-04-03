# frozen_string_literal: true

class JetUi::Sidebar::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Sidebar::Component.new do
      render(JetUi::Sidebar::SectionComponent.new) do
        render(JetUi::Sidebar::TitleComponent.new) { 'Navigation' }
        render(JetUi::Sidebar::MenuComponent.new) do
          render(JetUi::Sidebar::LinkComponent.new(url: '/')) { 'Home' }
          render(JetUi::Sidebar::LinkComponent.new(url: '/about')) { 'About' }
          render(JetUi::Sidebar::LinkComponent.new(disabled: true)) { 'Coming Soon' }
        end
      end
    end
  end

  def with_active_link
    render JetUi::Sidebar::Component.new do
      render(JetUi::Sidebar::SectionComponent.new) do
        render(JetUi::Sidebar::MenuComponent.new) do
          render(JetUi::Sidebar::LinkComponent.new(url: '/', active: true)) { 'Active Link' }
          render(JetUi::Sidebar::LinkComponent.new(url: '/other')) { 'Other Link' }
        end
      end
    end
  end
end
