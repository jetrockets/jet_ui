# frozen_string_literal: true

module JetUi
  module Sidebar
    class TitleComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag(:h4, content, class: classes, **@options.except(:class))
      end

      private

      def classes
        class_names('sidebar__title', @options[:class])
      end
    end
  end
end
