# frozen_string_literal: true

module JetUi
  module Header
    class Component < JetUi::BaseComponent
      def initialize(direction: :row, align: :start, justify: :between,
                     sticky: false, bordered: false, **options)
        @direction = direction
        @align = align
        @justify = justify
        @sticky = sticky
        @bordered = bordered
        @options = options
      end

      def call
        content_tag :div, content, class: classes, **@options.except(:class)
      end

      private

      def classes
        class_names(
          'header',
          "header--#{@direction}",
          "header--align-#{@align}",
          "header--justify-#{@justify}",
          { 'header--sticky' => @sticky },
          { 'header--bordered' => @bordered },
          @options[:class]
        )
      end
    end
  end
end
