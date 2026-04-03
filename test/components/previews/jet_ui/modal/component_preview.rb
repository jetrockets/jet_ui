# frozen_string_literal: true

class JetUi::Modal::ComponentPreview < ViewComponent::Preview
  def sync_modal
    render JetUi::Modal::Component.new(title: 'Modal Title', subtitle: 'Subtitle', id: 'preview-modal') do
      render(JetUi::Modal::BodyComponent.new) { 'Modal content goes here.' }
      render(JetUi::Modal::FooterComponent.new, justify: :end) do
        render(JetUi::Btn::Component.new(variant: :secondary)) { 'Cancel' }
        render(JetUi::Btn::Component.new) { 'Confirm' }
      end
    end
  end

  def header_only
    render JetUi::Modal::HeaderComponent.new(title: 'Header Title', subtitle: 'Header subtitle')
  end

  def body
    render JetUi::Modal::BodyComponent.new do
      'Body content'
    end
  end

  def footer_end
    render JetUi::Modal::FooterComponent.new(justify: :end) do
      render(JetUi::Btn::Component.new(variant: :outline)) { 'Cancel' }
      render(JetUi::Btn::Component.new) { 'Save' }
    end
  end
end
