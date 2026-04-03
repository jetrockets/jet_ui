# frozen_string_literal: true

class JetUi::Clipboard::ComponentPreview < ViewComponent::Preview
  def copy_value
    render JetUi::Clipboard::Component.new(value: 'Text to copy') { 'Copy' }
  end

  def with_success_text
    render JetUi::Clipboard::Component.new(value: 'https://example.com', success_text: 'URL copied!') { 'Copy URL' }
  end
end
