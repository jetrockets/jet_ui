# frozen_string_literal: true

module JetUi
  module Pagy
    class Component < BaseComponent
      WRAPPER_CLASSES = 'flex flex-col md:items-center gap-x-6 gap-y-2 md:justify-between md:flex-row'

      def initialize(pagy:, **options)
        @pagy    = pagy
        @options = options
      end

      def render?
        @pagy.pages > 1
      end

      def call
        content_tag :div, class: class_names(WRAPPER_CLASSES, @options.delete(:class)), **@options do
          safe_join([page_info, nav_wrapper])
        end
      end

      private

      def page_info
        content_tag(:div, class: 'sticky left-0 text-muted-foreground') do
          content_tag(:div) do
            safe_join(['Page ', content_tag(:strong, @pagy.page.to_s), " of #{@pagy.pages}"])
          end
        end
      end

      def nav_wrapper
        content_tag(:div, content, class: 'sticky left-0 md:right-0')
      end
    end
  end
end
