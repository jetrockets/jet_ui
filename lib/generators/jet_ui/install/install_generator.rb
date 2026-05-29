# frozen_string_literal: true

require 'rails/generators'
require_relative '../eject/eject_generator'
require_relative '../js_runtime'

module JetUi
  module Generators
    # Sets up JetUi in the host Rails application.
    #
    # Usage:
    #   rails generate jet_ui:install
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      class_option :skip_install, type: :boolean, default: false,
                                  desc: 'Vite apps: skip running the package manager install, just print the command'

      desc <<~DESC
        JetUi is a ViewComponent-based UI library for Rails — #{EjectGenerator::MANIFEST.size} ready-made
        components styled with Tailwind CSS v4, matching the design system at
        ui.jetrockets.com.

        This generator detects how your app manages JavaScript and sets JetUi up
        accordingly — no flags needed:

        • Importmap apps — injects the gem's CSS @import into your Tailwind source
          and adds eagerLoadControllersFrom("jet_ui", application) to your Stimulus
          controllers index. Controllers are auto-registered, no npm needed.

        • Vite apps — installs the npm package with your package manager and
          prints the controller registration and stylesheet @import. Vite apps own
          their JS/CSS entry points, so those are not modified automatically.

        Safe to run multiple times — already-configured importmap steps are skipped.

        Importmap Tailwind source files detected for the CSS @import:
          app/assets/tailwind/application.css
          app/assets/stylesheets/application.tailwind.css
          app/assets/stylesheets/application.postcss.css

        To see all available components with descriptions:
          rails generate jet_ui:eject --help

        Example:
          rails generate jet_ui:install
      DESC

      def show_runtime
        case js_runtime
        when :importmap then say '  Detected importmap — wiring JetUi via the gem.', :green
        when :vite      then say '  Detected Vite — wiring JetUi via the npm package.', :green
        else say '  Could not detect importmap or Vite — printing both setups.', :yellow
        end
      end

      def setup
        case js_runtime
        when :importmap then setup_importmap
        when :vite      then setup_vite
        else setup_unknown
        end
      end

      def show_usage
        say "\nJetUi installed!\n", :green
        say 'Add flash messages to your layout (e.g. app/views/layouts/application.html.erb):'
        say %(  <%= jet_ui.flash(messages: flash) %>\n)
        say 'Usage in your views:'
        say %(  <%= jet_ui.btn variant: :default do %>Save<% end %>)
        say %(  <%= jet_ui.card do %>)
        say %(    <%= jet_ui.card_header do %>)
        say %(      <%= jet_ui.card_title "Hello" %>)
        say %(    <% end %>)
        say %(    <%= jet_ui.card_body do %>Content<% end %>)
        say %(  <% end %>\n)
        say 'To eject a component for local customization:'
        say '  rails generate jet_ui:eject btn'
        say '  rails generate jet_ui:eject card'
        say "  rails generate jet_ui:eject btn card\n"
      end

      NPM_PACKAGE = '@jetrockets/jet_ui'

      JS_CONTROLLERS_FILE = 'app/javascript/controllers/index.js'

      TAILWIND_SOURCE_FILES = %w[
        app/assets/tailwind/application.css
        app/assets/stylesheets/application.tailwind.css
        app/assets/stylesheets/application.postcss.css
      ].freeze

      private

      def js_runtime
        @js_runtime ||= JsRuntime.detect(destination_root)
      end

      # --- importmap: auto-wire from the gem -------------------------------

      def setup_importmap
        inject_importmap_css
        inject_importmap_controllers
      end

      def inject_importmap_css
        file = tailwind_source_file
        unless file
          say '  Could not detect a Tailwind CSS source file.', :yellow
          say '  Add the following to your Tailwind CSS source manually:', :yellow
          say gem_css_import, :yellow
          return
        end

        if File.read(File.join(destination_root, file)).include?('jet_ui')
          say "  JetUi CSS already imported in #{file}", :yellow
        else
          # Tailwind CSS v4: import the gem's stylesheet by absolute path so the
          # Tailwind CLI can process its @apply directives at build time.
          append_to_file file, gem_css_import
          say "  Injected JetUi CSS into #{file}", :green
        end
      end

      def inject_importmap_controllers
        path = File.join(destination_root, JS_CONTROLLERS_FILE)
        unless File.exist?(path)
          say '  No Stimulus controllers index found — add this line to it manually:', :yellow
          say %(    eagerLoadControllersFrom("jet_ui", application)), :yellow
          return
        end

        if File.read(path).include?('jet_ui')
          say "  JetUi controllers already registered in #{JS_CONTROLLERS_FILE}", :yellow
        else
          insert_into_file JS_CONTROLLERS_FILE, after: /eagerLoadControllersFrom\("controllers".*\n/ do
            %(eagerLoadControllersFrom("jet_ui", application)\n)
          end
          say "  Registered JetUi controllers in #{JS_CONTROLLERS_FILE}", :green
        end
      end

      # --- vite: install the package, but never touch the app's entry points ---

      def setup_vite
        install_npm_package
        say '  Ensure @hotwired/stimulus is installed — it is a peer dependency the controllers import.', :yellow
        say '  Register the controllers you use, in your Stimulus controllers index:'
        say %(    import { ModalController, DrawerController } from "#{NPM_PACKAGE}")
        say %(    application.register("modal", ModalController))
        say %(    application.register("drawer", DrawerController))
        say '  Import the styles, in your Tailwind/CSS entry point:'
        say %(    @import "#{NPM_PACKAGE}/css";)
      end

      def install_npm_package
        command = JsRuntime.install_command(destination_root, NPM_PACKAGE)
        if options[:skip_install]
          say '  Skipped install — run it yourself:', :yellow
          say "    #{command}"
        else
          say "  Installing #{NPM_PACKAGE}…", :green
          run command
        end
      end

      def setup_unknown
        say '  Importmap apps — add to your Stimulus controllers index:', :yellow
        say %(    eagerLoadControllersFrom("jet_ui", application))
        say '  Vite apps — install the npm package and import its styles:', :yellow
        say "    #{JsRuntime.install_command(destination_root, NPM_PACKAGE)}"
        say %(    @import "#{NPM_PACKAGE}/css";)
      end

      def tailwind_source_file
        TAILWIND_SOURCE_FILES.find { |f| File.exist?(File.join(destination_root, f)) }
      end

      def gem_css_import
        %(\n@import "#{File.join(gem_stylesheets_path, 'jet_ui.css')}";\n)
      end

      def gem_stylesheets_path
        spec = begin
          Gem::Specification.find_by_name('jet_ui')
        rescue
          nil
        end
        base = spec&.gem_dir || File.expand_path('../../../../..', __dir__)
        File.join(base, 'app/assets/stylesheets')
      end
    end
  end
end
