# frozen_string_literal: true

class JetUi::Drawer::ComponentPreview < ViewComponent::Preview
  def sync_drawer
    render JetUi::Drawer::Component.new(title: 'Drawer Title', id: 'preview-drawer') do
      render(JetUi::Drawer::BodyComponent.new) { 'Drawer content goes here.' }
      render(JetUi::Drawer::FooterComponent.new) do
        render(JetUi::Btn::Component.new(variant: :secondary)) { 'Close' }
      end
    end
  end

  def header_only
    render JetUi::Drawer::HeaderComponent.new(title: 'Drawer Title', subtitle: 'Subtitle', closable: false)
  end

  def body
    render JetUi::Drawer::BodyComponent.new do
      'Drawer body content'
    end
  end
end
