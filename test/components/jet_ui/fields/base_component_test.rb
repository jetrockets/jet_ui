# frozen_string_literal: true

require 'test_helper'
require 'active_model'

class JetUi::Fields::BaseComponentTest < ViewComponent::TestCase
  class FakeModel
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :name

    validates :name, presence: true
  end

  class UnvalidatedModel
    include ActiveModel::Model

    attr_accessor :label
  end

  class ProbeComponent < JetUi::Fields::BaseComponent
    def call
      content_tag(:div, nil, class: field_classes, data: { required: required?, errors: errors? })
    end
  end

  def build_form(model = FakeModel.new)
    form = nil
    vc_test_controller.view_context.form_with(model: model, url: '#', scope: :fake) do |f|
      form = f
      ''
    end
    form
  end

  # ---------------------------------------------------------------------------
  # Size
  # ---------------------------------------------------------------------------
  def test_default_size_is_md
    render_inline(ProbeComponent.new(form: build_form, method: :name))

    assert_selector 'div.form-field'
    refute_selector 'div.form-field-sm'
    refute_selector 'div.form-field-lg'
  end

  def test_applies_size_sm
    render_inline(ProbeComponent.new(form: build_form, method: :name, size: :sm))

    assert_selector 'div.form-field-sm'
  end

  def test_applies_size_lg
    render_inline(ProbeComponent.new(form: build_form, method: :name, size: :lg))

    assert_selector 'div.form-field-lg'
  end

  def test_falls_back_to_default_size_for_invalid_value
    render_inline(ProbeComponent.new(form: build_form, method: :name, size: :xl))

    refute_selector 'div.form-field-sm'
    refute_selector 'div.form-field-lg'
  end

  # ---------------------------------------------------------------------------
  # required?
  # ---------------------------------------------------------------------------
  def test_required_true_when_presence_validator_present
    render_inline(ProbeComponent.new(form: build_form, method: :name))

    assert_selector "div[data-required='true']"
  end

  def test_required_false_without_presence_validator
    render_inline(ProbeComponent.new(form: build_form(UnvalidatedModel.new), method: :label))

    assert_selector "div[data-required='false']"
  end

  def test_required_option_overrides_validator_detection
    render_inline(ProbeComponent.new(form: build_form, method: :name, required: false))

    assert_selector "div[data-required='false']"
  end

  # ---------------------------------------------------------------------------
  # errors?
  # ---------------------------------------------------------------------------
  def test_errored_class_absent_without_errors
    render_inline(ProbeComponent.new(form: build_form, method: :name))

    refute_selector 'div.form-field-errored'
    assert_selector "div[data-errors='false']"
  end

  def test_errored_class_present_with_model_errors
    model = FakeModel.new
    model.valid?

    render_inline(ProbeComponent.new(form: build_form(model), method: :name))

    assert_selector 'div.form-field-errored'
    assert_selector "div[data-errors='true']"
  end

  def test_custom_error_forces_errored_class
    render_inline(ProbeComponent.new(form: build_form, method: :name, error: 'Something went wrong'))

    assert_selector 'div.form-field-errored'
  end
end
