# frozen_string_literal: true

module JetUi
  module Dialog
    class HeaderComponent < JetUi::BaseComponent
      def initialize(title: nil, subtitle: nil, closable: true, bordered: true, title_id: nil, **options)
        @title    = title
        @subtitle = subtitle
        @closable = closable
        @bordered = bordered
        @title_id = title_id
        @options  = options
      end

      erb_template <<~ERB
        <div class="<%= classes %>">
          <div>
            <% if @title %>
              <%= tag.h3 @title, class: 'dialog__title', id: @title_id %>
            <% end %>
            <% if @subtitle %>
              <div class="dialog__subtitle"><%= @subtitle %></div>
            <% end %>
            <%= content %>
          </div>

          <% if @closable %>
            <button type="button" class="dialog__close" data-action="click->dialog#close" aria-label="Close">
              <%= helpers.jet_ui.icon('x-mark', size: 6) %>
            </button>
          <% end %>
        </div>
      ERB

      private

      def classes
        class_names(
          'dialog__header',
          { 'dialog__header-bordered' => @bordered },
          @options[:class]
        )
      end
    end
  end
end
