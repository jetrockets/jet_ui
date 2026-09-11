# frozen_string_literal: true

class JetUi::Dialog::ComponentPreview < ViewComponent::Preview
  def sync_centered
    render JetUi::Dialog::Component.new(title: 'Dialog Title', subtitle: 'Subtitle', id: 'preview-dialog') do
      render(JetUi::Dialog::BodyComponent.new) { 'Dialog content goes here.' }
      render(JetUi::Dialog::FooterComponent.new(justify: :end)) do
        render(JetUi::Btn::Component.new(variant: :secondary)) { 'Cancel' }
        render(JetUi::Btn::Component.new) { 'Confirm' }
      end
    end
  end

  def position_right
    render JetUi::Dialog::Component.new(title: 'Right Dialog', position: :right, id: 'preview-dialog-right') do
      render(JetUi::Dialog::BodyComponent.new) { 'Slides in from the right, like the former Drawer.' }
    end
  end

  def position_left
    render JetUi::Dialog::Component.new(title: 'Left Dialog', position: :left, id: 'preview-dialog-left') do
      render(JetUi::Dialog::BodyComponent.new) { 'Slides in from the left.' }
    end
  end

  def position_top
    render JetUi::Dialog::Component.new(title: 'Top Dialog', position: :top, size: 'sm', id: 'preview-dialog-top') do
      render(JetUi::Dialog::BodyComponent.new) { 'Slides in from the top.' }
    end
  end

  def position_bottom
    render JetUi::Dialog::Component.new(title: 'Bottom Dialog', position: :bottom, size: 'sm', id: 'preview-dialog-bottom') do
      render(JetUi::Dialog::BodyComponent.new) { 'Slides in from the bottom.' }
    end
  end

  def header_only
    render JetUi::Dialog::HeaderComponent.new(title: 'Header Title', subtitle: 'Header subtitle')
  end

  def body
    render JetUi::Dialog::BodyComponent.new do
      'Body content'
    end
  end

  def footer_end
    render JetUi::Dialog::FooterComponent.new(justify: :end) do
      render(JetUi::Btn::Component.new(variant: :outline)) { 'Cancel' }
      render(JetUi::Btn::Component.new) { 'Save' }
    end
  end
end
