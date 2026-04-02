# frozen_string_literal: true

module JetUi
  module Empty
    class Component < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :div, content, class: class_names('empty', @options.delete(:class)), **@options
      end
    end
  end
end
