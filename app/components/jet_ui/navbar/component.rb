# frozen_string_literal: true

module JetUi
  module Navbar
    class Component < JetUi::BaseComponent
      def initialize(sticky: true, **options)
        @sticky = sticky
        @options = options
      end

      def call
        content_tag(:header, content, class: classes, **@options.except(:class))
      end

      private

      def classes
        class_names('navbar', { 'navbar-sticky' => @sticky }, @options[:class])
      end
    end
  end
end
