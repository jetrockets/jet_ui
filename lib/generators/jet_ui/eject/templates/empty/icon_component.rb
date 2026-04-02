# frozen_string_literal: true

module JetUi
  module Empty
    class IconComponent < BaseComponent
      def initialize(name = nil, **options)
        @name    = name
        @options = options
      end

      def call
        content_tag :div, class: class_names('empty__icon', @options.delete(:class)), **@options do
          render JetUi::Icon::Component.new(@name.presence || content.to_s.strip, size: 6)
        end
      end
    end
  end
end
