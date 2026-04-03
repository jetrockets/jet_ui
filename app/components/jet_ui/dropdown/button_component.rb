# frozen_string_literal: true

module JetUi
  module Dropdown
    class ButtonComponent < JetUi::BaseComponent
      def initialize(href: nil, **options)
        @href = href
        @options = options
      end

      erb_template <<~ERB
        <li class="dropdown__item">
          <%= button_to content, @href, **@options.except(:class), class: classes, form: { class: "dropdown__form" } %>
        </li>
      ERB

      private

      def classes
        class_names('dropdown__link', @options[:class])
      end
    end
  end
end
