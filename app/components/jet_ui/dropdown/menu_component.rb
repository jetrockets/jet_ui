# frozen_string_literal: true

module JetUi
  module Dropdown
    class MenuComponent < JetUi::BaseComponent
      def initialize(**options)
        @options = options
      end

      erb_template <<~ERB
        <div class="dropdown__menu" data-dropdown-target="menu">
          <ul class="<%= classes %>">
            <%= content %>
          </ul>
        </div>
      ERB

      private

      def classes
        class_names('dropdown__wrapper', @options[:class])
      end
    end
  end
end
