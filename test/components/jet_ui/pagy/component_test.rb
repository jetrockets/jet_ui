# frozen_string_literal: true

require 'test_helper'

class JetUi::Pagy::ComponentTest < ViewComponent::TestCase
  PagyStub = Struct.new(:page, :pages)

  def test_does_not_render_when_single_page
    pagy = PagyStub.new(1, 1)
    render_inline(JetUi::Pagy::Component.new(pagy: pagy))

    assert_predicate page.text, :blank?
  end

  def test_renders_when_multiple_pages
    pagy = PagyStub.new(3, 10)
    render_inline(JetUi::Pagy::Component.new(pagy: pagy)) { 'nav' }

    assert_selector 'div'
  end

  def test_shows_current_page
    pagy = PagyStub.new(3, 10)
    render_inline(JetUi::Pagy::Component.new(pagy: pagy)) { '' }

    assert_text '3'
  end

  def test_shows_total_pages
    pagy = PagyStub.new(3, 10)
    render_inline(JetUi::Pagy::Component.new(pagy: pagy)) { '' }

    assert_text '10'
  end

  def test_renders_block_content
    pagy = PagyStub.new(1, 5)
    render_inline(JetUi::Pagy::Component.new(pagy: pagy)) { 'nav content' }

    assert_text 'nav content'
  end

  def test_merges_custom_class
    pagy = PagyStub.new(1, 5)
    render_inline(JetUi::Pagy::Component.new(pagy: pagy, class: 'mt-4')) { '' }

    assert_selector 'div.mt-4'
  end
end
