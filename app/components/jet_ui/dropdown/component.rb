# frozen_string_literal: true

module JetUi
  module Dropdown
    class Component < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      erb_template <<~ERB
        <%= content_tag :div, class: classes, **attrs do %>
          <%= content %>
        <% end %>
      ERB

      private

      def attrs
        data_attributes = { controller: 'dropdown' }.deep_merge(@options.fetch(:data, {}))
        @options.except(:class, :data).merge(data: data_attributes)
      end

      def classes
        class_names('dropdown', @options[:class])
      end
    end
  end
end
