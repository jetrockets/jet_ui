# frozen_string_literal: true

module JetUi
  module Drawer
    class BodyComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :div, content, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names('drawer__body', @options[:class])
      end
    end
  end
end
