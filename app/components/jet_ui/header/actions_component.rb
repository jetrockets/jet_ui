# frozen_string_literal: true

module JetUi
  module Header
    class ActionsComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :div, content, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names('header__actions', @options[:class])
      end
    end
  end
end
