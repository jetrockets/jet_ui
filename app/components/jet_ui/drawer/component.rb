# frozen_string_literal: true

module JetUi
  module Drawer
    # @deprecated Use {JetUi::Dialog::Component} with `position: :right` instead.
    #   Kept as a thin shim so existing `jet_ui.drawer(...)` calls and
    #   `data: { turbo_frame: :drawer }` links keep working. Will be removed in the next
    #   major version.
    class Component < JetUi::Dialog::Component
      def self.deprecator
        @deprecator ||= ActiveSupport::Deprecation.new('1.0', 'JetUi')
      end

      def initialize(title: nil, subtitle: nil, size: JetUi::Dialog::Component::DEFAULT_SIZE, id: nil)
        self.class.deprecator.warn(
          'JetUi::Drawer::Component is deprecated and will be removed in the next major ' \
          'version. Use JetUi::Dialog::Component with position: :right instead ' \
          '(jet_ui.dialog).'
        )
        super(title: title, subtitle: subtitle, position: :right, size: size, id: id)
      end
    end
  end
end
