# frozen_string_literal: true

module JetUi
  module Popover
    class TriggerComponent < JetUi::BaseComponent
      def initialize(as: nil, **options)
        @as = as
        @options = options
      end

      def call
        if @as
          helpers.jet_ui.public_send(@as, **@options) { content }
        else
          content_tag :span, content, **@options
        end
      end
    end
  end
end
