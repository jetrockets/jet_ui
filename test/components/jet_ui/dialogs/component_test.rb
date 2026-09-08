# frozen_string_literal: true

require 'test_helper'

class JetUi::Dialogs::ComponentTest < ViewComponent::TestCase
  def test_renders_root_mount_point
    render_inline(JetUi::Dialogs::Component.new)

    assert_selector 'div#dialogs[data-dialogs-target="root"]'
  end

  def test_renders_sentinel_turbo_frame
    render_inline(JetUi::Dialogs::Component.new)

    assert_selector 'turbo-frame#dialog[data-dialogs-target="sentinel"]'
  end

  def test_root_is_turbo_permanent_and_not_cached
    render_inline(JetUi::Dialogs::Component.new)

    assert_selector 'div#dialogs[data-turbo-permanent][data-turbo-cache="false"]'
  end
end
