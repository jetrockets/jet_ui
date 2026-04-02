# frozen_string_literal: true

module JetUi
  module Empty
    class ActionsComponent < BaseComponent
      def initialize(**options)
        @options = options
      end

      def call
        render JetUi::Group::Component.new(sticky: false,
                                           class: class_names('empty__actions', @options.delete(:class)),
                                           **@options) do
          content
        end
      end
    end
  end
end
