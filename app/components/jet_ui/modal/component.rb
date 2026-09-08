# frozen_string_literal: true

module JetUi
  module Modal
    # @deprecated Use {JetUi::Dialog::Component} with `position: :center` instead.
    #   Kept as a thin shim so existing `jet_ui.modal(...)` calls and
    #   `data: { turbo_frame: :modal }` links keep working. Will be removed in the next
    #   major version.
    class Component < JetUi::Dialog::Component
      def self.deprecator
        @deprecator ||= ActiveSupport::Deprecation.new('1.0', 'JetUi')
      end

      def initialize(title: nil, subtitle: nil, size: JetUi::Dialog::Component::DEFAULT_SIZE, id: nil)
        self.class.deprecator.warn(
          'JetUi::Modal::Component is deprecated and will be removed in the next major ' \
          'version. Use JetUi::Dialog::Component with position: :center instead ' \
          '(jet_ui.dialog).'
        )
        super(title: title, subtitle: subtitle, position: :center, size: size, id: id)
      end
    end
  end
end
