# frozen_string_literal: true

module JetUi
  module Drawer
    # @deprecated Use {JetUi::Dialog::HeaderComponent} instead.
    class HeaderComponent < JetUi::Dialog::HeaderComponent
      # `id:` accepted and ignored for signature compatibility with the pre-deprecation API.
      def initialize(title: nil, subtitle: nil, closable: true, id: nil, bordered: true, # rubocop:disable Lint/UnusedMethodArgument
                     **options)
        super(title: title, subtitle: subtitle, closable: closable, bordered: bordered, **options)
      end
    end
  end
end
