# frozen_string_literal: true

require 'test_helper'
require 'active_model'

class JetUi::Fields::TextAreaComponentTest < ViewComponent::TestCase
  class FakeModel
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :bio

    validates :bio, presence: true
  end

  def build_form(model = FakeModel.new)
    form = nil
    vc_test_controller.view_context.form_with(model: model, url: '#', scope: :fake) do |f|
      form = f
      ''
    end
    form
  end

  def test_renders_textarea_element
    render_inline(JetUi::Fields::TextAreaComponent.new(form: build_form, method: :bio))

    assert_selector 'textarea'
  end

  def test_attaches_autogrow_controller
    render_inline(JetUi::Fields::TextAreaComponent.new(form: build_form, method: :bio))

    assert_selector "textarea[data-controller='textarea-autogrow']"
  end

  def test_preserves_other_data_attributes_alongside_controller
    render_inline(JetUi::Fields::TextAreaComponent.new(form: build_form, method: :bio, data: { testid: 'bio-field' }))

    assert_selector "textarea[data-controller='textarea-autogrow'][data-testid='bio-field']"
  end

  def test_applies_field_classes
    render_inline(JetUi::Fields::TextAreaComponent.new(form: build_form, method: :bio))

    assert_selector 'textarea.form-field'
  end

  def test_marks_required_when_presence_validator_present
    render_inline(JetUi::Fields::TextAreaComponent.new(form: build_form, method: :bio))

    assert_selector 'textarea[required]'
  end
end
