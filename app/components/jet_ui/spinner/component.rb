# frozen_string_literal: true

module JetUi
  module Spinner
    class Component < BaseComponent
      def initialize(size: 6, **options)
        @size    = size
        @options = options
      end

      def call
        render JetUi::Icon::Component.new('spinner', size: @size, **@options)
      end
    end
  end
end
