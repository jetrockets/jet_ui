# frozen_string_literal: true

module JetUi
  module Stepper
    class StepComponent < BaseComponent
      STATUSES = %i[pending current completed].freeze
      DEFAULT_STATUS = :pending

      def initialize(text = nil, status: DEFAULT_STATUS, number: nil, icon: nil, description: nil, url: nil, **options)
        @text        = text
        @status      = STATUSES.include?(status) ? status : DEFAULT_STATUS
        @number      = number
        @icon        = icon
        @description = description
        @url         = url
        @options     = options
      end

      def call
        content_tag :li, class: item_classes, **@options do
          if @url && @status != :pending
            content_tag(:a, href: @url, class: 'stepper__link') { inner_content }
          else
            inner_content
          end
        end
      end

      private

      def inner_content
        safe_join([indicator, step_content])
      end

      def indicator
        content_tag(:div, class: 'stepper__indicator') { indicator_inner }
      end

      def indicator_inner
        if @status == :completed && !@icon
          render(JetUi::Icon::Component.new('check', size: 5))
        elsif @icon
          render(JetUi::Icon::Component.new(@icon, size: 5))
        elsif @number
          content_tag(:span, @number.to_s, class: 'stepper__number')
        else
          content_tag(:span, nil, class: 'stepper__dot')
        end
      end

      def step_content
        content_tag(:div, class: 'stepper__content') do
          parts = [content_tag(:span, @text || content, class: 'stepper__title')]
          parts << content_tag(:span, @description, class: 'stepper__description') if @description
          safe_join(parts)
        end
      end

      def item_classes
        class_names(
          'stepper__item',
          "stepper__item-#{@status}",
          { 'stepper__item-has-url': @url.present? },
          @options.delete(:class)
        )
      end
    end
  end
end
