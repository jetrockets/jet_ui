# frozen_string_literal: true

module JetUi
  module Tabs
    class ItemComponent < BaseComponent
      def initialize(label = nil, href:, icon: nil, active: false, **options)
        @label   = label
        @href    = href
        @icon    = icon
        @active  = active
        @options = options
      end

      def call
        content_tag :li, class: 'tabs__item' do
          link_to @href, class: link_classes, **@options do
            concat render(JetUi::Icon::Component.new(@icon, size: 4)) if @icon
            concat(@label.presence || content)
          end
        end
      end

      private

      def link_classes
        class_names(
          'tabs__link',
          { 'tabs__link--active': @active },
          @options.delete(:class)
        )
      end
    end
  end
end
