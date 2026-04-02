# frozen_string_literal: true

module JetUi
  module Tabs
    class Component < BaseComponent
      VARIANTS = %i[pill underline].freeze
      DEFAULT_VARIANT = :pill

      def initialize(variant: DEFAULT_VARIANT, **options)
        @variant = VARIANTS.include?(variant) ? variant : DEFAULT_VARIANT
        @options = options
      end

      def call
        content_tag :div, class: wrapper_classes do
          content_tag :ul, content, class: class_names('tabs__list', @options.delete(:class))
        end
      end

      private

      def wrapper_classes
        class_names(
          'tabs',
          { 'tabs--underline': @variant == :underline }
        )
      end
    end
  end
end
