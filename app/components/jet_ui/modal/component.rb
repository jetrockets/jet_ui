# frozen_string_literal: true

module JetUi
  module Modal
    class Component < JetUi::BaseComponent
      SIZES = %w[sm md lg xl 2xl 3xl 4xl 5xl 6xl].freeze
      DEFAULT_SIZE = '2xl'

      def initialize(title: nil, subtitle: nil, size: DEFAULT_SIZE, id: nil)
        @title = title
        @subtitle = subtitle
        @size = size
        @id = id
      end

      erb_template <<~ERB
        <%= container_tag do %>
          <%= helpers.jet_ui.modal_header(title: @title, subtitle: @subtitle, closable: closable?, id: @id) %>
          <%= content %>
        <% end %>
      ERB

      private

      def container_tag(&block)
        return sync_dialog(&block) if @id
        return turbo_frame_dialog(&block) if helpers.turbo_frame_request?

        content_tag :div, class: class_names('modal modal-page', "w-#{@size}"), &block
      end

      def sync_dialog(&block)
        dialog_tag(id: @id, data: { modals_target: 'dialog' }, &block)
      end

      def turbo_frame_dialog(&block)
        helpers.turbo_frame_tag :modal do
          dialog_tag(id: :modalDialog, data: { controller: 'modal' }) do
            helpers.turbo_frame_tag(:modalContent, &block)
          end
        end
      end

      def dialog_tag(**options, &block)
        attrs = { tabindex: '-1', class: class_names('modal', 'animate-slide-up', "w-#{@size}") }
        content_tag :dialog, **attrs, **options, &block
      end

      def closable?
        helpers.turbo_frame_request? || @id
      end
    end
  end
end
