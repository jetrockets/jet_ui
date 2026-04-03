# frozen_string_literal: true

module JetUi
  module Accordion
    class Component < JetUi::BaseComponent
      def initialize(name: nil, open: false, **options)
        @name = name
        @open = open
        @options = options
      end

      def call
        content_tag :details, content, class: classes, name: @name, open: @open,
                                       **@options.except(:class)
      end

      private

      def classes
        class_names('group', @options[:class])
      end
    end
  end
end
