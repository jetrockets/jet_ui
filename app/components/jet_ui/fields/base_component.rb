# frozen_string_literal: true

module JetUi
  module Fields
    # Shared foundation every form field component builds on: required/error
    # detection against the bound form object, size variants, and the CSS
    # class helpers field and label components reuse.
    class BaseComponent < JetUi::BaseComponent
      SIZES = %i[sm md lg].freeze
      DEFAULT_SIZE = :md

      def initialize(form:, method:, size: DEFAULT_SIZE, error: nil, **options)
        @form = form
        @method_name = method
        @size = SIZES.include?(size&.to_sym) ? size.to_sym : DEFAULT_SIZE
        @custom_error = error
        @options = options
      end

      private

      attr_reader :form, :method_name, :size, :custom_error, :options

      def object
        form.object
      end

      def errors?
        custom_error.presence || (object&.errors.present? && object.errors[method_name.to_sym].present?)
      end

      def required?
        return options[:required] if options.key?(:required)

        presence_validators_for(validation_method_name).any?
      end

      def validation_method_name
        method_without_id = method_name.to_s.chomp('_id').to_sym
        object.respond_to?(method_without_id) ? method_without_id : method_name.to_sym
      end

      def presence_validators_for(validation_method)
        return [] unless object&.class.try(:validators_on, validation_method)

        object.class.validators_on(validation_method).select { |validator| validator.kind == :presence }
      end

      def field_classes(*additional_classes)
        class_names(
          'form-field',
          additional_classes,
          { 'form-field-sm': size == :sm },
          { 'form-field-lg': size == :lg },
          { 'form-field-errored': errors? },
          options[:class]
        )
      end

      def label_classes(*additional_classes)
        class_names(
          'form-label',
          additional_classes,
          { 'form-label-disabled': options[:disabled] },
          { 'form-label-sm': size == :sm },
          { 'form-label-lg': size == :lg },
          { 'form-label-errored': errors? },
          options[:class]
        )
      end
    end
  end
end
