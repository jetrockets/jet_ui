# frozen_string_literal: true

require 'rails/generators'

module JetUi
  module Generators
    # Sets up JetUi in the host Rails application.
    #
    # Usage:
    #   rails generate jet_ui:install
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc <<~DESC
        Sets up JetUi in your Rails application.

        1. CSS — Detects your Tailwind source file and injects a single @import
           that covers all JetUi component stylesheets. New components added in
           future gem updates are picked up automatically on the next CSS build.

        2. JS — Adds eagerLoadControllersFrom("jet_ui", application) to your
           Stimulus controllers index. All current and future JetUi Stimulus
           controllers (flash, modal, etc.) are registered automatically when
           you update the gem — no further changes needed.

        Safe to run multiple times — already-configured steps are skipped.

        Supported Tailwind source file locations:
          app/assets/tailwind/application.css
          app/assets/stylesheets/application.tailwind.css
          app/assets/stylesheets/application.postcss.css

        Example:
          rails generate jet_ui:install
      DESC

      def inject_css
        if (file = tailwind_source_file)
          content = File.read(File.join(destination_root, file))
          if content.include?('jet_ui')
            say "  JetUi CSS already imported in #{file}", :yellow
          else
            # Tailwind CSS v4: import each file with an absolute path so the
            # Tailwind CLI can process @apply directives at build time.
            append_to_file file, tailwind_imports
            say "  Injected JetUi imports into #{file}", :green
          end
        else
          say '  Could not detect a Tailwind CSS source file.', :yellow
          say '  Add the following to your Tailwind CSS source manually:', :yellow
          say tailwind_imports, :yellow
        end
      end

      def inject_js
        path = File.join(destination_root, JS_CONTROLLERS_FILE)
        unless File.exist?(path)
          say '  No Stimulus controllers index found — skipping JS setup.', :yellow
          say '  If you use Stimulus, add this line to your controllers index manually:', :yellow
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

      JS_CONTROLLERS_FILE = 'app/javascript/controllers/index.js'

      TAILWIND_SOURCE_FILES = %w[
        app/assets/tailwind/application.css
        app/assets/stylesheets/application.tailwind.css
        app/assets/stylesheets/application.postcss.css
      ].freeze

      private

      def tailwind_source_file
        TAILWIND_SOURCE_FILES.find { |f| File.exist?(File.join(destination_root, f)) }
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

      def tailwind_imports
        %(\n@import "#{File.join(gem_stylesheets_path, 'jet_ui.css')}";\n)
      end
    end
  end
end
