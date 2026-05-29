# frozen_string_literal: true

module JetUi
  class Engine < ::Rails::Engine
    config.autoload_paths << root.join('app/components')

    initializer 'jet_ui.view_component' do |app|
      if app.config.respond_to?(:view_component)
        app.config.view_component.preview_paths ||= []
        app.config.view_component.preview_paths << root.join('test/components/previews').to_s
      end
    end

    initializer 'jet_ui.importmap', after: 'importmap' do |app|
      if app.respond_to?(:importmap)
        app.importmap.pin_all_from(
          root.join('app/assets/javascripts/jet_ui'),
          under: 'jet_ui'
        )
        app.config.importmap.cache_sweepers << root.join('app/assets/javascripts')
      end
    end

    initializer 'jet_ui.helpers' do
      require root.join('app/helpers/jet_ui_helper').to_s
      ActiveSupport.on_load(:action_view) do
        include JetUiHelper
      end
    end
  end
end
