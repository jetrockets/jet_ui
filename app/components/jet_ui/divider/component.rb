# frozen_string_literal: true

module JetUi
  module Divider
    class Component < BaseComponent
      ALIGNS = %i[center start end].freeze
      DEFAULT_ALIGN = :center

      def initialize(align: DEFAULT_ALIGN, **options)
        @align = ALIGNS.include?(align) ? align : DEFAULT_ALIGN
        @options = options
      end

      def call
        content_tag :div, content.presence, class: classes, **@options
      end

      private

      def classes
        class_names(
          'divider',
          { 'divider-start': @align == :start },
          { 'divider-end': @align == :end },
          @options.delete(:class)
        )
      end
    end
  end
end
