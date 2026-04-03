# frozen_string_literal: true

class JetUi::Flash::ComponentPreview < ViewComponent::Preview
  def notice
    render JetUi::Flash::Component.new(messages: { notice: 'Changes saved successfully.' })
  end

  def alert
    render JetUi::Flash::Component.new(messages: { alert: 'Something went wrong. Please try again.' })
  end

  def success
    render JetUi::Flash::Component.new(messages: { success: 'Your account has been created.' })
  end

  def warning
    render JetUi::Flash::Component.new(messages: { warning: 'Your session will expire soon.' })
  end

  def multiple
    render JetUi::Flash::Component.new(
      messages: {
        notice: 'Profile updated.',
        warning: 'Email not verified yet.'
      }
    )
  end

  def non_dismissible
    render JetUi::Flash::Component.new(
      messages: { notice: 'This message cannot be dismissed.' },
      dismissible: false
    )
  end
end
