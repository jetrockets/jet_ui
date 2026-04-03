# frozen_string_literal: true

module JetUi
  module Header
    class SubtitleComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :p, content, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names('header__subtitle', @options[:class])
      end
    end
  end
end
