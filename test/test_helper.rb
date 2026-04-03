# frozen_string_literal: true

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'turbo-rails'
require 'view_component'
require 'view_component/test_helpers'
require 'view_component/test_case'

class TestApp < Rails::Application
  config.root = File.expand_path('..', __dir__)
  config.eager_load = false
  config.secret_key_base = 'test_secret_key_base_for_jet_ui_tests_only'
  config.logger = Logger.new(nil)
  config.log_level = :fatal

  routes.draw do
    root to: ->(_env) { [200, {}, ['OK']] }
  end
end

require 'jet_ui'

TestApp.initialize!

class ApplicationController < ActionController::Base; end

require 'minitest/autorun'
