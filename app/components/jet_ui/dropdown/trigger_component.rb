# frozen_string_literal: true

module JetUi
  module Dropdown
    class TriggerComponent < JetUi::BaseComponent
      def initialize(as: nil, **options)
        @as = as
        @options = options
        @options[:data] ||= {}
        @options[:data][:dropdown_target] = 'trigger'
      end

      def call
        if @as
          helpers.jet_ui.public_send(@as, **@options) { content }
        else
          content_tag :span, content, role: :button, class: classes, **@options.except(:class)
        end
      end

      private

      def classes
        class_names('dropdown__trigger', @options[:class])
      end
    end
  end
end
