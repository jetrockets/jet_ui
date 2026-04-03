# frozen_string_literal: true

module JetUi
  module Modal
    class HeaderComponent < JetUi::BaseComponent
      def initialize(title: nil, subtitle: nil, closable: true, id: nil, bordered: true, **options)
        @title = title
        @subtitle = subtitle
        @closable = closable
        @id = id
        @bordered = bordered
        @options = options
      end

      erb_template <<~ERB
        <div class="<%= classes %>">
          <div>
            <% if @title %>
              <h3 class="modal__title"><%= @title %></h3>
            <% end %>
            <% if @subtitle %>
              <div class="modal__subtitle"><%= @subtitle %></div>
            <% end %>
            <%= content %>
          </div>

          <% if @closable %>
            <button type="button" class="modal__close" data-action="click->modal#close click->modals#close" aria-label="Close" data-id="<%= @id %>">
              <%= helpers.jet_ui.icon("x-mark", size: 6) %>
            </button>
          <% end %>
        </div>
      ERB

      private

      def classes
        class_names(
          'modal__header',
          { 'modal__header-bordered' => @bordered },
          @options[:class]
        )
      end
    end
  end
end
