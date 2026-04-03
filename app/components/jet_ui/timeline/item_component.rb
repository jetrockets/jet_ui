# frozen_string_literal: true

module JetUi
  module Timeline
    class ItemComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :div, content, class: class_names('timeline-item', @options.delete(:class)), **@options
      end
    end
  end
end
