# frozen_string_literal: true

require 'test_helper'

class EngineTest < Minitest::Test
  def test_registers_the_component_previews_with_view_component
    config = config_without_preview_paths

    JetUi::Engine.instance.initializers.find { |initializer| initializer.name == 'jet_ui.view_component' }
                 .run(Struct.new(:config).new(config))

    assert_equal [JetUi::Engine.root.join('test/components/previews').to_s], preview_paths(config.view_component)
  end

  private

  def config_without_preview_paths
    config = ActiveSupport::OrderedOptions.new
    config.view_component = ViewComponent::Config.defaults
    view_component_4? ? config.view_component.previews.paths = [] : config.view_component.preview_paths = []
    config
  end

  def view_component_4?
    ViewComponent::VERSION::MAJOR >= 4
  end

  def preview_paths(view_component)
    view_component_4? ? view_component.previews.paths : view_component.preview_paths
  end
end
