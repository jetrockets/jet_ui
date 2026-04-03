# frozen_string_literal: true

require_relative 'lib/jet_ui/version'

Gem::Specification.new do |spec|
  spec.name        = 'jet_ui'
  spec.version     = JetUi::VERSION
  spec.authors     = ['JetRockets']
  spec.email       = ['hello@jetrockets.com']

  spec.summary     = 'ViewComponent-based UI library for Rails applications'
  spec.description = 'Reusable ViewComponent UI components matching the JetRockets design system at ui.jetrockets.com'
  spec.homepage    = 'https://ui.jetrockets.com'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jetrockets/jet_ui'
  spec.metadata['changelog_uri']   = 'https://github.com/jetrockets/jet_ui/blob/main/CHANGELOG.md'

  spec.files = Dir[
    'lib/**/*',
    'app/**/*',
    'config/**/*',
    'LICENSE.md',
    'README.md',
    'CHANGELOG.md'
  ]

  spec.require_paths = ['lib']

  spec.add_dependency 'railties', '>= 7.0'
  spec.add_dependency 'view_component', '>= 3.0'

  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rails', '8.1.3'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'turbo-rails'
end
