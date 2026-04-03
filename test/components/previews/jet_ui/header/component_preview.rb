# frozen_string_literal: true

class JetUi::Header::ComponentPreview < ViewComponent::Preview
  def default
    render JetUi::Header::Component.new do
      render(JetUi::Header::HeadingComponent.new) do
        render(JetUi::Header::TitleComponent.new) { 'Page Title' }
        render(JetUi::Header::SubtitleComponent.new) { 'A brief description.' }
      end
      render(JetUi::Header::ActionsComponent.new) do
        render(JetUi::Btn::Component.new) { 'Action' }
      end
    end
  end

  def bordered
    render JetUi::Header::Component.new(bordered: true) do
      render(JetUi::Header::HeadingComponent.new) do
        render(JetUi::Header::TitleComponent.new) { 'Bordered Header' }
      end
    end
  end
end
