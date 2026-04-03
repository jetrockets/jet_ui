# frozen_string_literal: true

module JetUi
  module Flash
    class Component < BaseComponent
      DISMISS_AFTER = 5000
      SHOW_DELAY    = 250

      TYPE_CLASSES = {
        'notice' => 'flash-item-info',
        'success' => 'flash-item-success',
        'alert' => 'flash-item-error',
        'error' => 'flash-item-error',
        'warning' => 'flash-item-warning'
      }.freeze

      def initialize(messages: nil, dismissible: true, frame_id: :flash)
        @messages    = messages
        @dismissible = dismissible
        @frame_id    = frame_id
      end

      private

      def flash_messages
        @messages || flash
      end

      def item_class(flash_type)
        type_class = TYPE_CLASSES[flash_type.to_s] || "flash-item-#{flash_type}"
        class_names('flash-item', 'flash-item--hidden', type_class)
      end

      def item_data
        attrs = { controller: 'flash', action: 'turbo:morph@window->flash#connect' }
        if @dismissible
          attrs[:flash_dismiss_after_value] = DISMISS_AFTER
          attrs[:flash_show_delay_value]    = SHOW_DELAY
        end
        attrs
      end
    end
  end
end
