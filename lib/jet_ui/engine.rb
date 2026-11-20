# frozen_string_literal: true

module JetUi
  class Engine < ::Rails::Engine
    config.autoload_paths << root.join('app/components')

    initializer 'jet_ui.view_component' do |app|
      if app.config.respond_to?(:view_component)
        previews_path = root.join('test/components/previews').to_s
        config = app.config.view_component

        # ViewComponent 4 moved `preview_paths` to `previews.paths` and raises on the old name.
        if config.previews
          config.previews.paths << previews_path
        else
          config.preview_paths ||= []
          config.preview_paths << previews_path
        end
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
