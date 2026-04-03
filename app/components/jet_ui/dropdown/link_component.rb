# frozen_string_literal: true

module JetUi
  module Dropdown
    class LinkComponent < JetUi::BaseComponent
      def initialize(url: nil, active: false, **options)
        @url = url
        @active = active
        @options = options
      end

      erb_template <<~ERB
        <li class="dropdown__item">
          <%= link_to content, @url, class: classes, **@options.except(:class) %>
        </li>
      ERB

      private

      def classes
        class_names(
          'dropdown__link',
          ('dropdown__link-active' if @active),
          @options[:class]
        )
      end
    end
  end
end
