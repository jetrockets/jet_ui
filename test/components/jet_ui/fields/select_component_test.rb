# frozen_string_literal: true

require 'test_helper'
require 'active_model'

class JetUi::Fields::SelectComponentTest < ViewComponent::TestCase
  class FakeModel
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :country, :role

    validates :country, presence: true
  end

  def build_form(model = FakeModel.new)
    form = nil
    vc_test_controller.view_context.form_with(model: model, url: '#', scope: :fake) do |f|
      form = f
      ''
    end
    form
  end

  def test_renders_select_element
    render_inline(JetUi::Fields::SelectComponent.new(form: build_form, method: :country, choices: %w[US CA]))

    assert_selector 'select'
  end

  def test_renders_each_choice_as_an_option
    render_inline(JetUi::Fields::SelectComponent.new(form: build_form, method: :role, choices: %w[US CA MX]))

    assert_selector 'option', count: 3
    assert_selector "option[value='US']", text: 'US'
  end

  def test_required_field_gets_an_automatic_blank_option
    render_inline(JetUi::Fields::SelectComponent.new(form: build_form, method: :country, choices: %w[US CA]))

    assert_selector 'select[required] option', count: 3
  end

  def test_supports_label_value_pairs
    render_inline(
      JetUi::Fields::SelectComponent.new(form: build_form, method: :country, choices: [%w[Canada CA], %w[Mexico MX]])
    )

    assert_selector "option[value='CA']", text: 'Canada'
  end

  def test_passes_through_select_options_like_include_blank
    render_inline(
      JetUi::Fields::SelectComponent.new(
        form: build_form, method: :country, choices: %w[US], select_options: { include_blank: 'Choose one' }
      )
    )

    assert_selector "option[value='']", text: 'Choose one'
  end

  def test_passes_through_select_options_like_prompt
    render_inline(
      JetUi::Fields::SelectComponent.new(
        form: build_form, method: :role, choices: %w[Admin Member], select_options: { prompt: 'Select a role' }
      )
    )

    assert_selector "option[value='']", text: 'Select a role'
  end

  def test_applies_field_classes
    render_inline(JetUi::Fields::SelectComponent.new(form: build_form, method: :country, choices: %w[US]))

    assert_selector 'select.form-field'
  end

  def test_merges_custom_class
    render_inline(
      JetUi::Fields::SelectComponent.new(form: build_form, method: :country, choices: %w[US], class: 'my-select')
    )

    assert_selector 'select.form-field.my-select'
  end

  def test_marks_required_when_presence_validator_present
    render_inline(JetUi::Fields::SelectComponent.new(form: build_form, method: :country, choices: %w[US]))

    assert_selector 'select[required]'
  end

  def test_does_not_mark_required_without_presence_validator
    render_inline(JetUi::Fields::SelectComponent.new(form: build_form, method: :role, choices: %w[Admin]))

    refute_selector 'select[required]'
  end

  def test_passes_through_arbitrary_html_options
    render_inline(
      JetUi::Fields::SelectComponent.new(form: build_form, method: :role, choices: %w[Admin], multiple: true)
    )

    assert_selector 'select[multiple]'
  end

  def test_applies_errored_class_with_model_errors
    model = FakeModel.new
    model.valid?

    render_inline(JetUi::Fields::SelectComponent.new(form: build_form(model), method: :country, choices: %w[US]))

    assert_selector 'select.form-field-errored'
  end
end
