# frozen_string_literal: true

module JetUi
  module Fields
    # Ports FormBuilders::Fields::Select. Wraps Rails' native select
    # helper, which takes its own options hash (include_blank, prompt,
    # selected...) separate from the HTML attributes every other field
    # gets via **options.
    class SelectComponent < BaseComponent
      def initialize(choices: nil, select_options: {}, **options)
        @choices = choices
        @select_options = select_options
        super(**options)
      end

      def call
        render_native_field(:select, @choices, @select_options, native_html_options)
      end

      private

      def native_html_options
        options.merge(class: field_classes, required: required?)
      end
    end
  end
end
