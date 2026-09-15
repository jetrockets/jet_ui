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
        <li class="dropdown__item" role="none">
          <%= link_to content, @url, class: classes, role: 'menuitem',
                      data: { dropdown_target: 'item' }.merge(@options.fetch(:data, {})),
                      **@options.except(:class, :data) %>
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
