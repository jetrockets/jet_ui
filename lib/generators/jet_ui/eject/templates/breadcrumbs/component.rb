# frozen_string_literal: true

module JetUi
  module Breadcrumbs
    class Component < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :nav, class: class_names('breadcrumbs', @options.delete(:class)),
                          'aria-label': 'Breadcrumb', **@options do
          content_tag :ol, content, class: 'breadcrumbs__list'
        end
      end
    end
  end
end
