# frozen_string_literal: true

module JetUi
  module Table
    class Component < BaseComponent
      SIZES = %i[xs sm md lg].freeze
      DEFAULT_SIZE = :md

      def initialize(bordered: false, full: true, size: DEFAULT_SIZE, hovered: false, **options)
        @bordered = bordered
        @full     = full
        @size     = SIZES.include?(size) ? size : DEFAULT_SIZE
        @hovered  = hovered
        @options  = options
      end

      def call
        content_tag :div, class: 'scroller scroller-x' do
          content_tag :table, content, class: classes, **@options
        end
      end

      private

      def classes
        class_names(
          'table',
          "table-#{@size}",
          { 'table-bordered': @bordered },
          { 'table-full': @full },
          { 'table-hovered': @hovered },
          @options.delete(:class)
        )
      end
    end
  end
end
