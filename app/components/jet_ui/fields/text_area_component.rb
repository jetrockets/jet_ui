# frozen_string_literal: true

module JetUi
  module Fields
    # Ports FormBuilders::Fields::Text's :text_area usage into its own
    # component. Original wired an external `stimulus-textarea-autogrow`
    # controller; this attaches jet_ui's own built-in equivalent
    # (see textarea_autogrow_controller.js) instead of adding the gem's
    # first external JS dependency for something this small.
    class TextAreaComponent < TextComponent
      def initialize(**options)
        super(field_type: :text_area, **with_autogrow_controller(options))
      end

      private

      def with_autogrow_controller(options)
        options.merge(data: { controller: 'textarea-autogrow' }.merge(options[:data] || {}))
      end
    end
  end
end
