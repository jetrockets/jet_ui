# frozen_string_literal: true

module JetUi
  module Accordion
    class SummaryComponent < JetUi::BaseComponent
      def initialize(icon: 'chevron-down', **options)
        @icon = icon
        @options = options
      end

      erb_template <<~ERB
        <summary class="<%= classes %>">
          <%= content %>
          <%= helpers.jet_ui.icon(@icon, class: icon_classes) if @icon %>
        </summary>
      ERB

      private

      def classes
        class_names(
          'flex items-center justify-between gap-3 py-3.5 font-medium cursor-pointer',
          @options[:class]
        )
      end

      def icon_classes
        'transition-transform size-4 group-open:-rotate-180'
      end
    end
  end
end
