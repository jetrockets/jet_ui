# frozen_string_literal: true

module JetUi
  module Empty
    class DescriptionComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :p, content, class: class_names('empty__description', @options.delete(:class)), **@options
      end
    end
  end
end
