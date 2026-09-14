# frozen_string_literal: true

require 'test_helper'
require 'active_model'

class JetUi::Fields::ChoicesComponentTest < ViewComponent::TestCase
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

  def test_renders_wrapper_with_choices_controller
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US CA]))

    assert_selector "div[data-controller='choices'] select"
  end

  def test_select_carries_choices_target
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US CA]))

    assert_selector "select[data-choices-target='select']"
  end

  def test_renders_each_choice_as_an_option
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :role, choices: %w[Admin Member]))

    assert_selector 'option', count: 2
  end

  def test_applies_field_classes_on_select
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US]))

    assert_selector 'select.form-field'
  end

  def test_marks_select_required_when_presence_validator_present
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US]))

    assert_selector 'select[required]'
  end

  def test_no_wrapper_size_modifier_by_default
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US]))

    refute_selector 'div.form-choices-sm'
    refute_selector 'div.form-choices-lg'
  end

  def test_applies_wrapper_size_modifier
    render_inline(
      JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US], size: :lg)
    )

    assert_selector 'div.form-choices-lg'
  end

  def test_applies_wrapper_errored_modifier_with_model_errors
    model = FakeModel.new
    model.valid?

    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form(model), method: :country, choices: %w[US]))

    assert_selector 'div.form-choices-errored'
  end

  def test_no_container_id_without_a_new_path
    render_inline(JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US]))

    refute_selector "div[id$='_container']"
  end

  def test_container_id_present_with_a_new_path
    render_inline(
      JetUi::Fields::ChoicesComponent.new(
        form: build_form, method: :country, choices: %w[US], data: { new: '/countries/new' }
      )
    )

    assert_selector "div[id='fake_country_container']"
  end

  def test_new_path_gets_container_and_target_params_appended
    render_inline(
      JetUi::Fields::ChoicesComponent.new(
        form: build_form, method: :country, choices: %w[US], data: { new: '/countries/new' }
      )
    )

    assert_selector "select[data-new='/countries/new?container=fake_country_container&target=fake_country']"
  end

  def test_new_path_preserves_existing_query_params
    render_inline(
      JetUi::Fields::ChoicesComponent.new(
        form: build_form, method: :country, choices: %w[US], data: { new: '/countries/new?embed=true' }
      )
    )

    assert_selector "select[data-new*='embed=true']"
    assert_selector "select[data-new*='container=fake_country_container']"
  end

  def test_passes_through_arbitrary_html_options
    render_inline(
      JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US], multiple: true)
    )

    assert_selector 'select[multiple]'
  end

  def test_preserves_other_data_attributes
    render_inline(
      JetUi::Fields::ChoicesComponent.new(form: build_form, method: :country, choices: %w[US], data: { search: '/countries/search' })
    )

    assert_selector "select[data-search='/countries/search'][data-choices-target='select']"
  end
end
