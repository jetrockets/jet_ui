# frozen_string_literal: true

module JetUi
  module Dialogs
    # Mount point for the dialog stack. Renders the `#dialogs` root that DialogsController
    # manages (see app/assets/javascripts/jet_ui/dialogs_controller.js) plus the sentinel
    # <turbo-frame id="dialog"> that every async dialog open (data: { turbo_frame: :dialog })
    # adopts into a freshly built <dialog> shell before Turbo navigates it. Render this once
    # in the host application's layout.
    class Component < JetUi::BaseComponent
      erb_template <<~ERB
        <div id="dialogs" data-dialogs-target="root" data-turbo-permanent data-turbo-cache="false">
          <%= helpers.turbo_frame_tag :dialog, data: { dialogs_target: 'sentinel' } %>
        </div>
      ERB
    end
  end
end
