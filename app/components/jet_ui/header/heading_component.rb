# frozen_string_literal: true

module JetUi
  module Header
    class HeadingComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :div, content, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names('header__heading', @options[:class])
      end
    end
  end
end
