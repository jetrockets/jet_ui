# frozen_string_literal: true

require 'test_helper'

class JetUi::Table::ComponentTest < ViewComponent::TestCase
  def test_renders_scroller_wrapper
    render_inline(JetUi::Table::Component.new)

    assert_selector 'div.scroller.scroller-x'
  end

  def test_renders_table_element
    render_inline(JetUi::Table::Component.new)

    assert_selector 'table.table'
  end

  def test_default_size_is_md
    render_inline(JetUi::Table::Component.new)

    assert_selector 'table.table-md'
  end

  def test_default_is_full_width
    render_inline(JetUi::Table::Component.new)

    assert_selector 'table.table-full'
  end

  JetUi::Table::Component::SIZES.each do |size|
    define_method(:"test_size_#{size}") do
      render_inline(JetUi::Table::Component.new(size: size))

      assert_selector "table.table-#{size}"
    end
  end

  def test_bordered
    render_inline(JetUi::Table::Component.new(bordered: true))

    assert_selector 'table.table-bordered'
  end

  def test_not_bordered_by_default
    render_inline(JetUi::Table::Component.new)

    assert_no_selector 'table.table-bordered'
  end

  def test_hovered
    render_inline(JetUi::Table::Component.new(hovered: true))

    assert_selector 'table.table-hovered'
  end

  def test_full_false
    render_inline(JetUi::Table::Component.new(full: false))

    assert_no_selector 'table.table-full'
  end

  def test_renders_thead
    render_inline(JetUi::Table::TheadComponent.new) { '' }

    assert_selector 'thead'
  end

  def test_renders_tbody
    render_inline(JetUi::Table::TbodyComponent.new) { '' }

    assert_selector 'tbody'
  end

  def test_renders_tfoot
    render_inline(JetUi::Table::TfootComponent.new) { '' }

    assert_selector 'tfoot'
  end

  def test_renders_tr
    render_inline(JetUi::Table::TrComponent.new) { '' }

    assert_selector 'tr'
  end

  def test_renders_th
    render_inline(JetUi::Table::ThComponent.new) { 'Name' }

    assert_selector 'th'
    assert_text 'Name'
  end

  def test_th_sticky_left
    render_inline(JetUi::Table::ThComponent.new(sticky: :left)) { 'Name' }

    assert_selector 'th.table__th_sticky.table__th_sticky-left'
  end

  def test_renders_td
    render_inline(JetUi::Table::TdComponent.new) { 'Value' }

    assert_selector 'td'
    assert_text 'Value'
  end

  def test_td_actions
    render_inline(JetUi::Table::TdComponent.new(actions: true)) { '' }

    assert_selector 'td.table__actions'
  end

  def test_td_sticky_left
    render_inline(JetUi::Table::TdComponent.new(sticky: :left)) { 'Value' }

    assert_selector 'td.table__td_sticky.table__td_sticky-left'
  end
end
