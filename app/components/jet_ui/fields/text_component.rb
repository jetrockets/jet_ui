# frozen_string_literal: true

module JetUi
  module Fields
    # Handles text_field and every native Rails input helper that only
    # needs the gem's styling on top (password, email, number, date, and
    # the rest of the single-value text-like inputs).
    class TextComponent < BaseComponent
      FIELD_TYPES = %i[
        text_field password_field color_field search_field telephone_field
        phone_field date_field time_field datetime_field datetime_local_field
        month_field week_field url_field email_field number_field range_field
        text_area
      ].freeze
      DEFAULT_FIELD_TYPE = :text_field

      def initialize(field_type: DEFAULT_FIELD_TYPE, **options)
        @field_type = FIELD_TYPES.include?(field_type&.to_sym) ? field_type.to_sym : DEFAULT_FIELD_TYPE
        super(**options)
      end

      def call
        render_native_field(@field_type, native_field_options)
      end

      private

      def native_field_options
        options.merge(
          class: field_classes,
          autocomplete: options[:autocomplete] || 'off',
          required: required?
        )
      end
    end
  end
end
