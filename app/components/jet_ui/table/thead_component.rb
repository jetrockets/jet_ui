# frozen_string_literal: true

module JetUi
  module Table
    class TheadComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :thead, content, class: @options.delete(:class), **@options
      end
    end
  end
end
