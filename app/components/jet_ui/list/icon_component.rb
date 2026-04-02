# frozen_string_literal: true

module JetUi
  module List
    class IconComponent < BaseComponent
      def initialize(name = nil, size: 5, **options)
        @name = name
        @size = size
        @options = options
      end

      def call
        content_tag :div, class: classes, **@options do
          render JetUi::Icon::Component.new(@name.presence || content.to_s.strip, size: @size)
        end
      end

      private

      def classes
        class_names('list__icon', @options.delete(:class))
      end
    end
  end
end
