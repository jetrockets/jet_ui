# frozen_string_literal: true

require 'test_helper'
require 'rails/generators/test_case'
require 'generators/jet_ui/install/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests JetUi::Generators::InstallGenerator
  destination File.expand_path('../../tmp/install_generator', __dir__)
  setup :prepare_destination

  PACKAGE = JetUi::Generators::InstallGenerator::NPM_PACKAGE
  TAILWIND_HEADER = %(@import "tailwindcss";\n)
  TAILWIND_SOURCE = 'app/assets/tailwind/application.css'
  CONTROLLERS_INDEX = 'app/javascript/controllers/index.js'

  def test_desc_includes_gem_overview
    assert_match(/ViewComponent/, description)
  end

  def test_desc_includes_pointer_to_eject_help
    assert_match(/jet_ui:eject/, description)
  end

  def test_desc_includes_component_count
    count = JetUi::Generators::EjectGenerator::MANIFEST.size.to_s

    assert_includes description, count
  end

  def test_vite_app_prints_setup_and_uses_detected_package_manager
    scaffold_vite_app
    write('app/assets/entrypoints/tailwind.css', TAILWIND_HEADER)

    output = run_generator(['--skip-install'])

    assert_match(/yarn add #{Regexp.escape(PACKAGE)}/, output)
    assert_match(%r{@hotwired/stimulus}, output)
    assert_match(%r{@import "#{Regexp.escape(PACKAGE)}/css";}, output)
    assert_no_match(/eagerLoadControllersFrom\("jet_ui"/, output)
    # Vite apps own their entry points — the generator must not edit them.
    assert_file 'app/assets/entrypoints/tailwind.css' do |content|
      assert_equal TAILWIND_HEADER, content
    end
  end

  def test_importmap_app_injects_eager_load_and_gem_css
    scaffold_importmap_app

    run_generator

    assert_file CONTROLLERS_INDEX do |content|
      assert_match(/eagerLoadControllersFrom\("jet_ui", application\)/, content)
    end
    assert_file TAILWIND_SOURCE do |content|
      assert_match(/jet_ui\.css/, content)
    end
  end

  def test_unknown_runtime_prints_both_setups
    write(TAILWIND_SOURCE, TAILWIND_HEADER)

    output = run_generator

    assert_match(/eagerLoadControllersFrom\("jet_ui", application\)/, output)
    assert_match(/npm install #{Regexp.escape(PACKAGE)}/, output)
  end

  private

  def description
    JetUi::Generators::InstallGenerator.desc
  end

  def scaffold_vite_app
    write('vite.config.mjs', 'export default {}')
    write('yarn.lock', '')
  end

  def scaffold_importmap_app
    write('config/importmap.rb', 'pin "application"')
    write(TAILWIND_SOURCE, TAILWIND_HEADER)
    write(CONTROLLERS_INDEX, %(eagerLoadControllersFrom("controllers", application)\n))
  end

  def write(path, content)
    full = File.join(destination_root, path)
    FileUtils.mkdir_p(File.dirname(full))
    File.write(full, content)
  end
end
