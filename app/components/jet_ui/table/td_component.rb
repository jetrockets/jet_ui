# frozen_string_literal: true

module JetUi
  module Table
    class TdComponent < BaseComponent
      def initialize(actions: false, sticky: nil, **options)
        @actions = actions
        @sticky  = sticky
        @options = options
      end

      def call
        content_tag :td, content, class: classes, **@options
      end

      private

      def classes
        class_names(
          @options.delete(:class),
          { table__actions: @actions },
          { table__td_sticky: @sticky },
          { 'table__td_sticky-left': @sticky == :left },
          { 'table__td_sticky-right': @sticky == :right }
        )
      end
    end
  end
end
