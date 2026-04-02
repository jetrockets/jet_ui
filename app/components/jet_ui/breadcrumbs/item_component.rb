# frozen_string_literal: true

module JetUi
  module Breadcrumbs
    class ItemComponent < BaseComponent
      def initialize(label = nil, href: nil, **options)
        @label  = label
        @href   = href
        @options = options
      end

      def call
        content_tag :li, class: 'breadcrumbs__item' do
          text = @label.presence || content
          if @href
            link_to text, @href, class: class_names('breadcrumbs__link', @options.delete(:class)), **@options
          else
            content_tag :span, text, class: class_names('breadcrumbs__current', @options.delete(:class)),
                                     'aria-current': 'page', **@options
          end
        end
      end
    end
  end
end
