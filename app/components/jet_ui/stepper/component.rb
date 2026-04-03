# frozen_string_literal: true

module JetUi
  module Stepper
    class Component < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        content_tag :nav, class: class_names('stepper', @options.delete(:class)), 'aria-label': 'Progress',
                          **@options do
          content_tag :ol, content, class: 'stepper__list'
        end
      end
    end
  end
end
