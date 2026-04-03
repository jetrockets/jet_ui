# frozen_string_literal: true

module JetUi
  module Table
    class TrComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :tr, content, class: @options.delete(:class), **@options
      end
    end
  end
end
