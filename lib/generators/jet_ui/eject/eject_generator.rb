# frozen_string_literal: true

require 'rails/generators'

module JetUi
  module Generators
    class EjectGenerator < Rails::Generators::Base
      def self.source_paths
        [File.expand_path('../../../..', __dir__)]
      end

      desc <<~DESC
        Copies one or more JetUi component source files into your application
        so they can be customised locally. Ejected files take precedence over
        the gem's built-in versions automatically — no extra configuration needed.

        Available components: #{%w[btn card icon spinner avatar breadcrumbs tabs empty list divider timeline stepper table pagy].join(', ')}

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
            { src: 'app/components/jet_ui/btn/component.rb',                                                    dest: 'app/components/jet_ui/btn/component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/btn.css',                                                     dest: 'app/assets/stylesheets/jet_ui/btn.css' },
            { src: 'test/components/jet_ui/btn/component_test.rb',                                              dest: 'test/components/jet_ui/btn/component_test.rb',                           type: :test },
            { src: 'test/components/previews/jet_ui/btn/component_preview.rb',                                  dest: 'test/components/previews/jet_ui/btn/component_preview.rb',               type: :preview }
          ]
        },
        'card' => {
          files: [
            { src: 'app/components/jet_ui/card/component.rb',                                                   dest: 'app/components/jet_ui/card/component.rb' },
            { src: 'app/components/jet_ui/card/header_component.rb',                                            dest: 'app/components/jet_ui/card/header_component.rb' },
            { src: 'app/components/jet_ui/card/footer_component.rb',                                            dest: 'app/components/jet_ui/card/footer_component.rb' },
            { src: 'app/components/jet_ui/card/body_component.rb',                                              dest: 'app/components/jet_ui/card/body_component.rb' },
            { src: 'app/components/jet_ui/card/title_component.rb',                                             dest: 'app/components/jet_ui/card/title_component.rb' },
            { src: 'app/components/jet_ui/card/subtitle_component.rb',                                          dest: 'app/components/jet_ui/card/subtitle_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/card.css',                                                    dest: 'app/assets/stylesheets/jet_ui/card.css' },
            { src: 'test/components/jet_ui/card/component_test.rb',                                             dest: 'test/components/jet_ui/card/component_test.rb',                          type: :test },
            { src: 'test/components/previews/jet_ui/card/component_preview.rb',                                 dest: 'test/components/previews/jet_ui/card/component_preview.rb',              type: :preview }
          ]
        },
        'icon' => {
          files: [
            { src: 'app/components/jet_ui/icon/component.rb',                                                   dest: 'app/components/jet_ui/icon/component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/icon.css',                                                    dest: 'app/assets/stylesheets/jet_ui/icon.css' },
            { src: 'test/components/jet_ui/icon/component_test.rb',                                             dest: 'test/components/jet_ui/icon/component_test.rb',                          type: :test },
            { src: 'test/components/previews/jet_ui/icon/component_preview.rb',                                 dest: 'test/components/previews/jet_ui/icon/component_preview.rb',              type: :preview },
            { src: 'test/components/previews/jet_ui/icon/component_preview/sizes.html.erb',                     dest: 'test/components/previews/jet_ui/icon/component_preview/sizes.html.erb',  type: :preview },
            { src: 'test/components/previews/jet_ui/icon/component_preview/colors.html.erb',                    dest: 'test/components/previews/jet_ui/icon/component_preview/colors.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/icon/component_preview/catalog.html.erb',                   dest: 'test/components/previews/jet_ui/icon/component_preview/catalog.html.erb', type: :preview }
          ]
        },
        'spinner' => {
          files: [
            { src: 'app/components/jet_ui/spinner/component.rb',                                                dest: 'app/components/jet_ui/spinner/component.rb' },
            { src: 'test/components/jet_ui/spinner/component_test.rb',                                          dest: 'test/components/jet_ui/spinner/component_test.rb',                       type: :test },
            { src: 'test/components/previews/jet_ui/spinner/component_preview.rb',                              dest: 'test/components/previews/jet_ui/spinner/component_preview.rb',           type: :preview },
            { src: 'test/components/previews/jet_ui/spinner/component_preview/sizes.html.erb',                  dest: 'test/components/previews/jet_ui/spinner/component_preview/sizes.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/spinner/component_preview/colors.html.erb',                 dest: 'test/components/previews/jet_ui/spinner/component_preview/colors.html.erb', type: :preview }
          ]
        },
        'avatar' => {
          files: [
            { src: 'app/components/jet_ui/avatar/component.rb',                                                 dest: 'app/components/jet_ui/avatar/component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/avatar.css',                                                  dest: 'app/assets/stylesheets/jet_ui/avatar.css' },
            { src: 'test/components/jet_ui/avatar/component_test.rb',                                           dest: 'test/components/jet_ui/avatar/component_test.rb',                        type: :test },
            { src: 'test/components/previews/jet_ui/avatar/component_preview.rb',                               dest: 'test/components/previews/jet_ui/avatar/component_preview.rb',            type: :preview },
            { src: 'test/components/previews/jet_ui/avatar/component_preview/variants.html.erb',                dest: 'test/components/previews/jet_ui/avatar/component_preview/variants.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/avatar/component_preview/sizes.html.erb',                   dest: 'test/components/previews/jet_ui/avatar/component_preview/sizes.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/avatar/component_preview/states.html.erb',                  dest: 'test/components/previews/jet_ui/avatar/component_preview/states.html.erb', type: :preview }
          ]
        },
        'breadcrumbs' => {
          files: [
            { src: 'app/components/jet_ui/breadcrumbs/component.rb',                                            dest: 'app/components/jet_ui/breadcrumbs/component.rb' },
            { src: 'app/components/jet_ui/breadcrumbs/item_component.rb',                                       dest: 'app/components/jet_ui/breadcrumbs/item_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/breadcrumbs.css',                                             dest: 'app/assets/stylesheets/jet_ui/breadcrumbs.css' },
            { src: 'test/components/jet_ui/breadcrumbs/component_test.rb',                                      dest: 'test/components/jet_ui/breadcrumbs/component_test.rb',                   type: :test },
            { src: 'test/components/previews/jet_ui/breadcrumbs/component_preview.rb',                          dest: 'test/components/previews/jet_ui/breadcrumbs/component_preview.rb',       type: :preview },
            { src: 'test/components/previews/jet_ui/breadcrumbs/component_preview/default.html.erb',            dest: 'test/components/previews/jet_ui/breadcrumbs/component_preview/default.html.erb', type: :preview }
          ]
        },
        'tabs' => {
          files: [
            { src: 'app/components/jet_ui/tabs/component.rb',                                                   dest: 'app/components/jet_ui/tabs/component.rb' },
            { src: 'app/components/jet_ui/tabs/item_component.rb',                                              dest: 'app/components/jet_ui/tabs/item_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/tabs.css',                                                    dest: 'app/assets/stylesheets/jet_ui/tabs.css' },
            { src: 'test/components/jet_ui/tabs/component_test.rb',                                             dest: 'test/components/jet_ui/tabs/component_test.rb',                          type: :test },
            { src: 'test/components/previews/jet_ui/tabs/component_preview.rb',                                 dest: 'test/components/previews/jet_ui/tabs/component_preview.rb',              type: :preview },
            { src: 'test/components/previews/jet_ui/tabs/component_preview/pill.html.erb',                      dest: 'test/components/previews/jet_ui/tabs/component_preview/pill.html.erb',   type: :preview },
            { src: 'test/components/previews/jet_ui/tabs/component_preview/underline.html.erb',                 dest: 'test/components/previews/jet_ui/tabs/component_preview/underline.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/tabs/component_preview/with_icons.html.erb',                dest: 'test/components/previews/jet_ui/tabs/component_preview/with_icons.html.erb', type: :preview }
          ]
        },
        'empty' => {
          files: [
            { src: 'app/components/jet_ui/empty/component.rb',                                                  dest: 'app/components/jet_ui/empty/component.rb' },
            { src: 'app/components/jet_ui/empty/title_component.rb',                                            dest: 'app/components/jet_ui/empty/title_component.rb' },
            { src: 'app/components/jet_ui/empty/description_component.rb',                                      dest: 'app/components/jet_ui/empty/description_component.rb' },
            { src: 'app/components/jet_ui/empty/icon_component.rb',                                             dest: 'app/components/jet_ui/empty/icon_component.rb' },
            { src: 'app/components/jet_ui/empty/actions_component.rb',                                          dest: 'app/components/jet_ui/empty/actions_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/empty.css',                                                   dest: 'app/assets/stylesheets/jet_ui/empty.css' },
            { src: 'test/components/jet_ui/empty/component_test.rb',                                            dest: 'test/components/jet_ui/empty/component_test.rb',                         type: :test },
            { src: 'test/components/previews/jet_ui/empty/component_preview.rb',                                dest: 'test/components/previews/jet_ui/empty/component_preview.rb',             type: :preview },
            { src: 'test/components/previews/jet_ui/empty/component_preview/with_actions.html.erb',             dest: 'test/components/previews/jet_ui/empty/component_preview/with_actions.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/empty/component_preview/without_actions.html.erb',          dest: 'test/components/previews/jet_ui/empty/component_preview/without_actions.html.erb', type: :preview }
          ]
        },
        'pagy' => {
          files: [
            { src: 'app/components/jet_ui/pagy/component.rb',                                                     dest: 'app/components/jet_ui/pagy/component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/pagy.css',                                                      dest: 'app/assets/stylesheets/jet_ui/pagy.css' },
            { src: 'test/components/jet_ui/pagy/component_test.rb',                                               dest: 'test/components/jet_ui/pagy/component_test.rb',                        type: :test },
            { src: 'test/components/previews/jet_ui/pagy/component_preview.rb',                                   dest: 'test/components/previews/jet_ui/pagy/component_preview.rb',            type: :preview },
            { src: 'test/components/previews/jet_ui/pagy/component_preview/default.html.erb',                     dest: 'test/components/previews/jet_ui/pagy/component_preview/default.html.erb', type: :preview }
          ]
        },
        'table' => {
          files: [
            { src: 'app/components/jet_ui/table/component.rb',                                                    dest: 'app/components/jet_ui/table/component.rb' },
            { src: 'app/components/jet_ui/table/thead_component.rb',                                              dest: 'app/components/jet_ui/table/thead_component.rb' },
            { src: 'app/components/jet_ui/table/tbody_component.rb',                                              dest: 'app/components/jet_ui/table/tbody_component.rb' },
            { src: 'app/components/jet_ui/table/tfoot_component.rb',                                              dest: 'app/components/jet_ui/table/tfoot_component.rb' },
            { src: 'app/components/jet_ui/table/tr_component.rb',                                                 dest: 'app/components/jet_ui/table/tr_component.rb' },
            { src: 'app/components/jet_ui/table/th_component.rb',                                                 dest: 'app/components/jet_ui/table/th_component.rb' },
            { src: 'app/components/jet_ui/table/td_component.rb',                                                 dest: 'app/components/jet_ui/table/td_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/table.css',                                                     dest: 'app/assets/stylesheets/jet_ui/table.css' },
            { src: 'test/components/jet_ui/table/component_test.rb',                                              dest: 'test/components/jet_ui/table/component_test.rb',                       type: :test },
            { src: 'test/components/previews/jet_ui/table/component_preview.rb',                                  dest: 'test/components/previews/jet_ui/table/component_preview.rb',           type: :preview },
            { src: 'test/components/previews/jet_ui/table/component_preview/default.html.erb',                    dest: 'test/components/previews/jet_ui/table/component_preview/default.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/table/component_preview/bordered.html.erb',                   dest: 'test/components/previews/jet_ui/table/component_preview/bordered.html.erb', type: :preview }
          ]
        },
        'stepper' => {
          files: [
            { src: 'app/components/jet_ui/stepper/component.rb',                                                  dest: 'app/components/jet_ui/stepper/component.rb' },
            { src: 'app/components/jet_ui/stepper/step_component.rb',                                             dest: 'app/components/jet_ui/stepper/step_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/stepper.css',                                                   dest: 'app/assets/stylesheets/jet_ui/stepper.css' },
            { src: 'test/components/jet_ui/stepper/component_test.rb',                                            dest: 'test/components/jet_ui/stepper/component_test.rb',                     type: :test },
            { src: 'test/components/previews/jet_ui/stepper/component_preview.rb',                                dest: 'test/components/previews/jet_ui/stepper/component_preview.rb',         type: :preview },
            { src: 'test/components/previews/jet_ui/stepper/component_preview/basic.html.erb',                    dest: 'test/components/previews/jet_ui/stepper/component_preview/basic.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/stepper/component_preview/with_numbers.html.erb',             dest: 'test/components/previews/jet_ui/stepper/component_preview/with_numbers.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/stepper/component_preview/with_descriptions.html.erb',        dest: 'test/components/previews/jet_ui/stepper/component_preview/with_descriptions.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/stepper/component_preview/with_icons.html.erb',               dest: 'test/components/previews/jet_ui/stepper/component_preview/with_icons.html.erb', type: :preview }
          ]
        },
        'timeline' => {
          files: [
            { src: 'app/components/jet_ui/timeline/component.rb',                                                 dest: 'app/components/jet_ui/timeline/component.rb' },
            { src: 'app/components/jet_ui/timeline/item_component.rb',                                            dest: 'app/components/jet_ui/timeline/item_component.rb' },
            { src: 'app/components/jet_ui/timeline/dot_component.rb',                                             dest: 'app/components/jet_ui/timeline/dot_component.rb' },
            { src: 'app/components/jet_ui/timeline/content_component.rb',                                         dest: 'app/components/jet_ui/timeline/content_component.rb' },
            { src: 'app/components/jet_ui/timeline/time_component.rb',                                            dest: 'app/components/jet_ui/timeline/time_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/timeline.css',                                                  dest: 'app/assets/stylesheets/jet_ui/timeline.css' },
            { src: 'test/components/jet_ui/timeline/component_test.rb',                                           dest: 'test/components/jet_ui/timeline/component_test.rb',                     type: :test },
            { src: 'test/components/previews/jet_ui/timeline/component_preview.rb',                               dest: 'test/components/previews/jet_ui/timeline/component_preview.rb',         type: :preview },
            { src: 'test/components/previews/jet_ui/timeline/component_preview/default.html.erb',                 dest: 'test/components/previews/jet_ui/timeline/component_preview/default.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/timeline/component_preview/with_icons.html.erb',              dest: 'test/components/previews/jet_ui/timeline/component_preview/with_icons.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/timeline/component_preview/variants.html.erb',                dest: 'test/components/previews/jet_ui/timeline/component_preview/variants.html.erb', type: :preview }
          ]
        },
        'divider' => {
          files: [
            { src: 'app/components/jet_ui/divider/component.rb',                                                  dest: 'app/components/jet_ui/divider/component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/divider.css',                                                   dest: 'app/assets/stylesheets/jet_ui/divider.css' },
            { src: 'test/components/jet_ui/divider/component_test.rb',                                            dest: 'test/components/jet_ui/divider/component_test.rb',                      type: :test },
            { src: 'test/components/previews/jet_ui/divider/component_preview.rb',                                dest: 'test/components/previews/jet_ui/divider/component_preview.rb',          type: :preview },
            { src: 'test/components/previews/jet_ui/divider/component_preview/with_text.html.erb',                dest: 'test/components/previews/jet_ui/divider/component_preview/with_text.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/divider/component_preview/aligned.html.erb',                  dest: 'test/components/previews/jet_ui/divider/component_preview/aligned.html.erb', type: :preview }
          ]
        },
        'list' => {
          files: [
            { src: 'app/components/jet_ui/list/component.rb',                                                   dest: 'app/components/jet_ui/list/component.rb' },
            { src: 'app/components/jet_ui/list/item_component.rb',                                              dest: 'app/components/jet_ui/list/item_component.rb' },
            { src: 'app/components/jet_ui/list/icon_component.rb',                                              dest: 'app/components/jet_ui/list/icon_component.rb' },
            { src: 'app/components/jet_ui/list/content_component.rb',                                           dest: 'app/components/jet_ui/list/content_component.rb' },
            { src: 'app/components/jet_ui/list/action_component.rb',                                            dest: 'app/components/jet_ui/list/action_component.rb' },
            { src: 'app/assets/stylesheets/jet_ui/list.css',                                                    dest: 'app/assets/stylesheets/jet_ui/list.css' },
            { src: 'test/components/jet_ui/list/component_test.rb',                                             dest: 'test/components/jet_ui/list/component_test.rb',                          type: :test },
            { src: 'test/components/previews/jet_ui/list/component_preview.rb',                                 dest: 'test/components/previews/jet_ui/list/component_preview.rb',              type: :preview },
            { src: 'test/components/previews/jet_ui/list/component_preview/default.html.erb',                   dest: 'test/components/previews/jet_ui/list/component_preview/default.html.erb', type: :preview },
            { src: 'test/components/previews/jet_ui/list/component_preview/divided.html.erb',                   dest: 'test/components/previews/jet_ui/list/component_preview/divided.html.erb', type: :preview }
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

            copy_file entry[:src], entry[:dest]
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
