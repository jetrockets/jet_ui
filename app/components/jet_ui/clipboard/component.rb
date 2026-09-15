# frozen_string_literal: true

module JetUi
  module Clipboard
    class Component < JetUi::BaseComponent
      def initialize(as: nil, value: nil, source_id: nil, success_text: 'Copied!',
                     tooltip: nil, tooltip_success: nil, tooltip_placement: 'top',
                     aria_label: 'Copy to clipboard', **options)
        @as = as
        @value = value
        @source_id = source_id
        @success_text = success_text
        @tooltip = tooltip
        @tooltip_success = tooltip_success || success_text
        @tooltip_placement = tooltip_placement
        @aria_label = aria_label
        @options = options
      end

      def call
        if @as
          helpers.jet_ui.public_send(@as, **attrs) { content }
        else
          # The default trigger is a <span>, which is not a native control — give it button
          # semantics, keyboard focusability and an accessible name. Keyboard activation
          # (Enter/Space) is handled by the Stimulus controller's copyOnKeydown action.
          content_tag :span, content, class: classes, role: 'button', tabindex: 0,
                                      aria: { label: @aria_label }, **attrs
        end
      end

      private

      def attrs
        @options.except(:class, :data).merge(data: data_attributes)
      end

      def data_attributes
        base = {
          controller: @tooltip ? 'clipboard tooltip' : 'clipboard',
          clipboard_success_text_value: @success_text,
          action: actions.join(' ')
        }

        base[:clipboard_content_value] = @value if @value
        base[:clipboard_source_id_value] = @source_id if @source_id
        base.merge!(tooltip_attributes) if @tooltip
        base.merge(@options.fetch(:data, {}))
      end

      def actions
        list = ['click->clipboard#copy']
        list << 'clipboard:change->tooltip#updateContent' if @tooltip
        # The span variant needs keyboard activation; a native control (`as:`) already copies
        # on Enter/Space via its own click.
        list << 'keydown->clipboard#copyOnKeydown' if @as.nil?
        list
      end

      def tooltip_attributes
        {
          tooltip_content_value: @tooltip,
          tooltip_placement_value: @tooltip_placement,
          clipboard_success_text_value: @success_text
        }
      end

      def classes
        class_names('cursor-pointer', @options[:class])
      end
    end
  end
end
