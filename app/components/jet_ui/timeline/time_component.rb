# frozen_string_literal: true

module JetUi
  module Timeline
    class TimeComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :time, content, class: class_names('timeline-time', @options.delete(:class)), **@options
      end
    end
  end
end
