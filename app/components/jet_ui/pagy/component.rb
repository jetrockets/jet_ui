# frozen_string_literal: true

module JetUi
  module Pagy
    class Component < BaseComponent
      def initialize(pagy:, **options)
        @pagy    = pagy
        @options = options
      end

      def render?
        @pagy.pages > 1
      end

      def call
        content_tag :div, class: class_names('flex flex-col md:items-center gap-x-6 gap-y-2 md:justify-between md:flex-row', @options.delete(:class)), **@options do
          safe_join([
            content_tag(:div, class: 'sticky left-0 text-muted-foreground') {
              content_tag(:div) {
                safe_join(['Page ', content_tag(:strong, @pagy.page.to_s), " of #{@pagy.pages}"])
              }
            },
            content_tag(:div, content, class: 'sticky left-0 md:right-0')
          ])
        end
      end
    end
  end
end
