# frozen_string_literal: true

module JetUi
  module Empty
    class TitleComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :h3, content, class: class_names('empty__title', @options.delete(:class)), **@options
      end
    end
  end
end
