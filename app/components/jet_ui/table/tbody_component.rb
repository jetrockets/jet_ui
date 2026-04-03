# frozen_string_literal: true

module JetUi
  module Table
    class TbodyComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :tbody, content, class: @options.delete(:class), **@options
      end
    end
  end
end
