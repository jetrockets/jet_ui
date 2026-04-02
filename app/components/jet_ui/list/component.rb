# frozen_string_literal: true

module JetUi
  module List
    class Component < BaseComponent
      VARIANTS = %i[default divided].freeze
      DEFAULT_VARIANT = :default

      def initialize(variant: DEFAULT_VARIANT, **options)
        @variant = VARIANTS.include?(variant) ? variant : DEFAULT_VARIANT
        @options = options
      end

      def call
        content_tag :ul, content, class: classes, **@options
      end

      private

      def classes
        class_names(
          'list',
          { 'list--divided': @variant == :divided },
          @options.delete(:class)
        )
      end
    end
  end
end
