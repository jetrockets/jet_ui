# frozen_string_literal: true

require 'cgi'

module JetUi
  module Icon
    class Component < BaseComponent
      ICONS_PATH = JetUi::Engine.root.join('app', 'assets', 'images', 'jet_ui', 'icons')

      def initialize(name = nil, size: nil, **options)
        @name    = name.to_s
        @size    = size
        @options = options
      end

      def call
        icon_name = @name.presence || content.to_s.strip
        svg = File.read(ICONS_PATH.join("#{icon_name}.svg"))
        # rubocop:disable Rails/OutputSafety
        svg.sub('<svg', "<svg #{html_attributes(icon_name)}").html_safe
        # rubocop:enable Rails/OutputSafety
      end

      private

      def html_attributes(icon_name)
        attrs = {
          class: class_names('icon', @options.delete(:class)),
          style: size_style,
          'aria-hidden': 'true',
          'aria-label': icon_name.to_s.humanize
        }.merge(@options)
        attrs.compact!

        attrs.map { |k, v| "#{k}=\"#{CGI.escapeHTML(v.to_s)}\"" }.join(' ')
      end

      def size_style
        return unless @size

        size = "calc(var(--spacing) * #{@size})"
        "width: #{size}; height: #{size};"
      end
    end
  end
end
