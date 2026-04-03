# frozen_string_literal: true

module JetUi
  module Dropdown
    class DividerComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :li, nil, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names('dropdown__divider', @options[:class])
      end
    end
  end
end
