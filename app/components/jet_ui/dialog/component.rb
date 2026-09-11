# frozen_string_literal: true

module JetUi
  module Dialog
    class Component < JetUi::BaseComponent
      SIZES = %w[sm md lg xl 2xl 3xl 4xl 5xl 6xl].freeze
      DEFAULT_SIZE = '2xl'

      POSITIONS = %i[center left right top bottom].freeze
      DEFAULT_POSITION = :center

      EDGE_POSITIONS = %i[left right top bottom].freeze

      def initialize(title: nil, subtitle: nil, position: DEFAULT_POSITION, size: DEFAULT_SIZE,
                     id: nil, closable: true, dismissible: true, swipe: true)
        @title       = title
        @subtitle    = subtitle
        @position    = position.to_sym
        @size        = size.to_s
        @id          = id
        @closable    = closable
        @dismissible = dismissible
        @swipe       = swipe && edge_position?
      end

      erb_template <<~ERB
        <%= container_tag do %>
          <div class="dialog__panel" data-dialog-target="panel">
            <%= helpers.jet_ui.dialog_header(title: @title, subtitle: @subtitle, closable: closable?) %>
            <%= content %>
            <div class="dialog__flash-slot"></div>
          </div>
        <% end %>
      ERB

      private

      def edge_position?
        EDGE_POSITIONS.include?(@position)
      end

      def container_tag(&block)
        # If @id is provided, we assume it's a sync dialog defined inline on the page.
        return dialog_tag(id: @id, data: { dialogs_target: 'dialog' }, &block) if @id

        # Async open (e.g. opened via a link with data: { turbo_frame: :dialog }).
        # The <dialog> shell around this frame is created client-side by DialogsController
        # before Turbo navigates the frame — see app/assets/javascripts/jet_ui/dialogs_controller.js.
        return helpers.turbo_frame_tag(:dialog, &block) if helpers.turbo_frame_request?

        # Not a Turbo Frame request (direct visit, new tab) — render as a plain page section.
        content_tag :div, class: class_names('dialog-page', size_class), &block
      end

      def dialog_tag(**options, &block)
        content_tag :dialog, tabindex: '-1', class: dialog_classes, data: dialog_data(options.delete(:data)),
                             **options, &block
      end

      def dialog_classes
        class_names('dialog', "dialog-#{@position}", size_class)
      end

      def dialog_data(extra)
        {
          controller: 'dialog',
          dialog_position_value: @position,
          dialog_dismissible_value: @dismissible,
          dialog_swipe_value: @swipe
        }.merge(extra || {})
      end

      def size_class
        horizontal_edge? ? "h-#{@size}" : "w-#{@size}"
      end

      def horizontal_edge?
        %i[top bottom].include?(@position)
      end

      def closable?
        @closable && (helpers.turbo_frame_request? || @id)
      end
    end
  end
end
