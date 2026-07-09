# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require 'fileutils'
require 'generators/jet_ui/js_runtime'

class JsRuntimeTest < Minitest::Test
  Runtime = JetUi::Generators::JsRuntime

  def test_detects_importmap_from_config_file
    in_app('config/importmap.rb' => 'pin "application"') do |root|
      assert_equal :importmap, Runtime.detect(root)
    end
  end

  def test_detects_vite_from_config
    in_app('vite.config.mjs' => 'export default {}') do |root|
      assert_equal :vite, Runtime.detect(root)
    end
  end

  def test_vite_wins_when_both_present
    in_app('config/importmap.rb' => 'pin "application"', 'vite.config.mjs' => 'export default {}') do |root|
      assert_equal :vite, Runtime.detect(root)
    end
  end

  def test_detects_vite_from_package_json_dependency
    in_app('package.json' => '{"devDependencies":{"vite":"^6"}}') do |root|
      assert_equal :vite, Runtime.detect(root)
    end
  end

  def test_package_json_without_vite_is_not_a_vite_app
    in_app('package.json' => '{"dependencies":{"left-pad":"^1"}}') do |root|
      assert_equal :unknown, Runtime.detect(root)
    end
  end

  def test_unknown_when_nothing_present
    in_app({}) do |root|
      assert_equal :unknown, Runtime.detect(root)
    end
  end

  def test_package_manager_from_lockfile
    {
      'yarn.lock' => :yarn,
      'pnpm-lock.yaml' => :pnpm,
      'bun.lockb' => :bun,
      'package-lock.json' => :npm
    }.each do |lockfile, manager|
      in_app(lockfile => '') do |root|
        assert_equal manager, Runtime.package_manager(root), "expected #{lockfile} → #{manager}"
      end
    end
  end

  def test_package_manager_reads_package_manager_field_without_lockfile
    in_app('package.json' => '{"packageManager":"yarn@4.5.0"}') do |root|
      assert_equal :yarn, Runtime.package_manager(root)
    end
  end

  def test_lockfile_beats_package_manager_field
    in_app('package.json' => '{"packageManager":"yarn@4.5.0"}', 'package-lock.json' => '{}') do |root|
      assert_equal :npm, Runtime.package_manager(root)
    end
  end

  def test_package_manager_defaults_to_npm
    in_app({}) { |root| assert_equal :npm, Runtime.package_manager(root) }
  end

  def test_install_command_uses_add_for_yarn_and_install_for_npm
    in_app('yarn.lock' => '') do |root|
      assert_equal 'yarn add @scope/pkg', Runtime.install_command(root, '@scope/pkg')
    end
    in_app({}) do |root|
      assert_equal 'npm install @scope/pkg', Runtime.install_command(root, '@scope/pkg')
    end
  end

  private

  def in_app(files)
    Dir.mktmpdir do |root|
      files.each do |path, content|
        full = File.join(root, path)
        FileUtils.mkdir_p(File.dirname(full))
        File.write(full, content)
      end
      yield root
    end
  end
end
