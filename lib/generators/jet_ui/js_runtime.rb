# frozen_string_literal: true

require 'json'

module JetUi
  module Generators
    # Detects how a host application manages its JavaScript, so the install
    # generator can wire JetUi the right way without asking: pin controllers via
    # importmap, or point the app at the npm package for Vite.
    module JsRuntime
      VITE_CONFIGS = %w[
        vite.config.js vite.config.mjs vite.config.ts
        config/vite.json
      ].freeze

      # Ordered: the first lockfile found wins.
      PACKAGE_MANAGERS = {
        'bun.lockb' => :bun,
        'pnpm-lock.yaml' => :pnpm,
        'yarn.lock' => :yarn,
        'package-lock.json' => :npm
      }.freeze

      module_function

      # Vite wins when both are present: a working Vite config is a stronger
      # signal than a leftover config/importmap.rb.
      def detect(root)
        return :vite if vite?(root)
        return :importmap if importmap?(root)

        :unknown
      end

      def vite?(root)
        VITE_CONFIGS.any? { |file| File.exist?(File.join(root, file)) } ||
          package_json_vite?(root)
      end

      def importmap?(root)
        File.exist?(File.join(root, 'config/importmap.rb'))
      end

      def package_manager(root)
        PACKAGE_MANAGERS.each { |lock, name| return name if File.exist?(File.join(root, lock)) }
        package_manager_field(root) || :npm
      end

      # corepack's `"packageManager": "yarn@4.5.0"` — the declared manager when
      # there's no lockfile yet (e.g. a fresh vite_rails clone).
      def package_manager_field(root)
        path = File.join(root, 'package.json')
        return unless File.exist?(path)

        field = JSON.parse(File.read(path))['packageManager']
        return unless field

        PACKAGE_MANAGERS.values.find { |name| name.to_s == field.split('@').first }
      rescue JSON::ParserError
        nil
      end

      def install_command(root, package)
        manager = package_manager(root)
        verb = manager == :npm ? 'install' : 'add'

        "#{manager} #{verb} #{package}"
      end

      def package_json_vite?(root)
        path = File.join(root, 'package.json')
        return false unless File.exist?(path)

        deps = JSON.parse(File.read(path)).values_at('dependencies', 'devDependencies').compact
        deps.flat_map(&:keys).include?('vite')
      rescue JSON::ParserError
        false
      end
    end
  end
end
