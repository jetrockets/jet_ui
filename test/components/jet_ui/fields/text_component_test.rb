# frozen_string_literal: true

require 'test_helper'
require 'active_model'

class JetUi::Fields::TextComponentTest < ViewComponent::TestCase
  class FakeModel
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :name, :email, :age, :born_on, :meeting_at, :website, :color

    validates :name, presence: true
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
  # Field type
  # ---------------------------------------------------------------------------
  def test_defaults_to_text_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name))

    assert_selector "input[type='text']"
  end

  def test_renders_password_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name, field_type: :password_field))

    assert_selector "input[type='password']"
  end

  def test_renders_email_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :email, field_type: :email_field))

    assert_selector "input[type='email']"
  end

  def test_renders_number_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :age, field_type: :number_field))

    assert_selector "input[type='number']"
  end

  def test_renders_date_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :born_on, field_type: :date_field))

    assert_selector "input[type='date']"
  end

  def test_renders_range_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :age, field_type: :range_field))

    assert_selector "input[type='range']"
  end

  def test_renders_telephone_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name, field_type: :telephone_field))

    assert_selector "input[type='tel']"
  end

  def test_phone_field_is_an_alias_for_telephone_field
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name, field_type: :phone_field))

    assert_selector "input[type='tel']"
  end

  def test_falls_back_to_default_field_type_for_invalid_value
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name, field_type: :nonexistent_field))

    assert_selector "input[type='text']"
  end

  # ---------------------------------------------------------------------------
  # Shared behavior
  # ---------------------------------------------------------------------------
  def test_applies_field_classes
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name))

    assert_selector 'input.form-field'
  end

  def test_defaults_autocomplete_to_off
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name))

    assert_selector "input[autocomplete='off']"
  end

  def test_preserves_explicit_autocomplete
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :email, autocomplete: 'email'))

    assert_selector "input[autocomplete='email']"
  end

  def test_marks_required_when_presence_validator_present
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name))

    assert_selector 'input[required]'
  end

  def test_does_not_mark_required_without_presence_validator
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :email))

    refute_selector 'input[required]'
  end

  def test_passes_through_arbitrary_html_options
    render_inline(JetUi::Fields::TextComponent.new(form: build_form, method: :name, placeholder: 'Full name'))

    assert_selector "input[placeholder='Full name']"
  end
end
