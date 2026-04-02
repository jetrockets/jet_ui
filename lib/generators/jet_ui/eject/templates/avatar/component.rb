# frozen_string_literal: true

module JetUi
  module Avatar
    class Component < BaseComponent
      VARIANTS = %i[rounded circle square].freeze
      DEFAULT_VARIANT = :circle
      DEFAULT_SIZE = 12

      def initialize(src: nil, name: nil, size: DEFAULT_SIZE, variant: DEFAULT_VARIANT, **options)
        @src     = src
        @name    = name
        @size    = size
        @variant = VARIANTS.include?(variant) ? variant : DEFAULT_VARIANT
        @options = options
      end

      def call
        content_tag :div, inner_content, class: avatar_classes, style: avatar_style
      end

      private

      def inner_content
        if @src.present?
          helpers.image_tag @src, alt: @name.to_s, class: 'size-full object-cover'
        elsif @name.present?
          content_tag :span, initials
        else
          render JetUi::Icon::Component.new('user', class: 'w-8/12')
        end
      end

      def initials
        @name.split.pluck(0).join.upcase[0..1]
      end

      def avatar_classes
        class_names(
          'avatar',
          { 'avatar--circle': @variant == :circle },
          { 'avatar--rounded': @variant == :rounded },
          @options.delete(:class)
        )
      end

      def avatar_style
        size = "calc(var(--spacing) * #{@size})"
        font_size = (@size * 1.65).round(1)
        "width: #{size}; height: #{size}; font-size: #{font_size}px"
      end
    end
  end
end
