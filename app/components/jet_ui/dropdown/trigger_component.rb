# frozen_string_literal: true

module JetUi
  module Dropdown
    class TriggerComponent < JetUi::BaseComponent
      def initialize(as: nil, **options)
        @as = as
        @options = options
        configure_accessibility
      end

      def call
        if @as
          helpers.jet_ui.public_send(@as, **@options) { content }
        else
          content_tag :span, content, role: :button, tabindex: 0, class: classes, **@options.except(:class)
        end
      end

      private

      def configure_accessibility
        @options[:data] ||= {}
        @options[:aria] ||= {}
        @options[:data][:dropdown_target] = 'trigger'
        unless @as
          @options[:data][:action] = [
            @options[:data][:action],
            'keydown.enter->dropdown#toggle keydown.space->dropdown#toggle'
          ].compact.join(' ')
        end
        @options[:aria].reverse_merge!(haspopup: 'menu', expanded: false)
      end

      def classes
        class_names('dropdown__trigger', @options[:class])
      end
    end
  end
end
