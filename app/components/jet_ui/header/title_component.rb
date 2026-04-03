# frozen_string_literal: true

module JetUi
  module Header
    class TitleComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :h1, content, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names('header__title', @options[:class])
      end
    end
  end
end
