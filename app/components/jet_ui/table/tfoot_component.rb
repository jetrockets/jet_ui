# frozen_string_literal: true

module JetUi
  module Table
    class TfootComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :tfoot, content, class: @options.delete(:class), **@options
      end
    end
  end
end
