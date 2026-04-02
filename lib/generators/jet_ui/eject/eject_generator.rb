# frozen_string_literal: true

require 'rails/generators'

module JetUi
  module Generators
    class EjectGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc <<~DESC
        Copies one or more JetUi component source files into your application
        so they can be customised locally. Ejected files take precedence over
        the gem's built-in versions automatically — no extra configuration needed.

        Available components: #{%w[btn card icon].join(', ')}

        Examples:
          rails generate jet_ui:eject btn
          rails generate jet_ui:eject card
          rails generate jet_ui:eject icon
          rails generate jet_ui:eject btn card
          rails generate jet_ui:eject btn --skip-test
          rails generate jet_ui:eject btn --skip-preview
          rails generate jet_ui:eject btn --skip-test --skip-preview
      DESC

      argument :components, type: :array, banner: 'component [component ...]',
                            desc: 'One or more component names to eject (e.g. btn card)'

      class_option :skip_test, type: :boolean, default: false,
                               desc: 'Skip ejecting the component test file'

      class_option :skip_preview, type: :boolean, default: false,
                                  desc: 'Skip ejecting the ViewComponent preview file'

      MANIFEST = {
        'btn' => {
          files: [
            { src: 'btn/component.rb',         dest: 'app/components/jet_ui/btn/component.rb' },
            { src: 'btn/btn.css',              dest: 'app/assets/stylesheets/jet_ui/btn.css' },
            { src: 'btn/component_test.rb',    dest: 'test/components/jet_ui/btn/component_test.rb',                    type: :test },
            { src: 'btn/component_preview.rb', dest: 'test/components/previews/jet_ui/btn/component_preview.rb',        type: :preview }
          ]
        },
        'card' => {
          files: [
            { src: 'card/component.rb',          dest: 'app/components/jet_ui/card/component.rb' },
            { src: 'card/header_component.rb',   dest: 'app/components/jet_ui/card/header_component.rb' },
            { src: 'card/footer_component.rb',   dest: 'app/components/jet_ui/card/footer_component.rb' },
            { src: 'card/body_component.rb',     dest: 'app/components/jet_ui/card/body_component.rb' },
            { src: 'card/title_component.rb',    dest: 'app/components/jet_ui/card/title_component.rb' },
            { src: 'card/subtitle_component.rb', dest: 'app/components/jet_ui/card/subtitle_component.rb' },
            { src: 'card/card.css',              dest: 'app/assets/stylesheets/jet_ui/card.css' },
            { src: 'card/component_test.rb',     dest: 'test/components/jet_ui/card/component_test.rb',                 type: :test },
            { src: 'card/component_preview.rb',  dest: 'test/components/previews/jet_ui/card/component_preview.rb',     type: :preview }
          ]
        },
        'icon' => {
          files: [
            { src: 'icon/component.rb',         dest: 'app/components/jet_ui/icon/component.rb' },
            { src: 'icon/icon.css',             dest: 'app/assets/stylesheets/jet_ui/icon.css' },
            { src: 'icon/component_test.rb',    dest: 'test/components/jet_ui/icon/component_test.rb',                   type: :test },
            { src: 'icon/component_preview.rb', dest: 'test/components/previews/jet_ui/icon/component_preview.rb',       type: :preview }
          ]
        }
      }.freeze

      def eject_components
        unknown = components.map(&:downcase) - MANIFEST.keys
        if unknown.any?
          say "\nUnknown component(s): #{unknown.join(', ')}", :red
          say "Available: #{MANIFEST.keys.join(', ')}\n", :red
          exit 1
        end

        components.map(&:downcase).each do |name|
          say "\nEjecting #{name}...", :cyan
          MANIFEST[name][:files].each do |entry|
            next if entry[:type] == :test    && options[:skip_test]
            next if entry[:type] == :preview && options[:skip_preview]

            template entry[:src], entry[:dest]
          end
          say "  #{name} ejected.", :green
        end
      end

      def show_summary
        skipped = []
        skipped << 'tests'    if options[:skip_test]
        skipped << 'previews' if options[:skip_preview]

        say "\nDone! Ejected: #{components.map(&:downcase).join(', ')}", :green
        say "  (skipped: #{skipped.join(', ')})" if skipped.any?
        say "\nThe local files in app/components/jet_ui/ now take precedence over the gem."
        say "Run your tests to confirm everything still works:\n"
        say "  bundle exec rake test\n"
      end
    end
  end
end
