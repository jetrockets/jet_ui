# frozen_string_literal: true

module JetUi
  module Fields
    # Ports FormBuilders::Fields::Choices. Wraps the native select helper
    # in a div the choices_controller.js Stimulus controller enhances into
    # a searchable, taggable select (via the choices.js library). The size
    # and error modifiers on the wrapper only override CSS custom
    # properties (see form_choices.css) that the generated widget reads,
    # they carry no visual styling of their own.
    class ChoicesComponent < BaseComponent
      def initialize(choices: nil, select_options: {}, **options)
        @choices = choices
        @select_options = select_options
        super(**options)
      end

      def call
        content_tag(:div, id: container_id, class: choices_wrapper_classes, data: { controller: 'choices' }) do
          render_native_field(:select, @choices, native_select_options, native_html_options)
        end
      end

      private

      def native_select_options
        @select_options.merge(required: required?)
      end

      def native_html_options
        options.merge(class: field_classes, data: choices_data_options)
      end

      def choices_data_options
        { choices_target: 'select' }.merge(new_path_data)
      end

      def new_path_data
        base = options[:data] || {}
        return base if base[:new].blank?

        base.merge(new: rewritten_new_path(base[:new]))
      end

      # Adds container/target query params to the "add new" link so the
      # created record's frame knows where to inject the result and which
      # select to update, same behavior as the original.
      def rewritten_new_path(path)
        uri = URI.parse(path)
        existing_params = URI.decode_www_form(uri.query || '')
        new_params = { container: container_id, target: form.field_id(method_name) }
        uri.query = URI.encode_www_form(existing_params.to_h.merge(new_params))
        uri.to_s
      end

      def container_id
        return unless new_path?

        form.field_id("#{method_name}_container")
      end

      def new_path?
        options.dig(:data, :new).present?
      end

      def choices_wrapper_classes
        class_names(
          { 'form-choices-sm': size == :sm },
          { 'form-choices-lg': size == :lg },
          { 'form-choices-errored': errors? }
        )
      end
    end
  end
end
