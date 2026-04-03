# frozen_string_literal: true

module JetUi
  module Timeline
    class DotComponent < BaseComponent
      VARIANTS = %i[default info success warning error].freeze
      DEFAULT_VARIANT = :default

      def initialize(variant: DEFAULT_VARIANT, icon: nil, **options)
        @variant = VARIANTS.include?(variant) ? variant : DEFAULT_VARIANT
        @icon    = icon
        @options = options
      end

      def call
        content_tag :div, icon_content, class: classes, **@options
      end

      private

      def icon_content
        return unless @icon

        render(JetUi::Icon::Component.new(@icon, size: 4))
      end

      def classes
        class_names(
          'timeline-dot',
          "timeline-dot-#{@variant}",
          { 'timeline-dot-icon': @icon.present? },
          @options.delete(:class)
        )
      end
    end
  end
end
