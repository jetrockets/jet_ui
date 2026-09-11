# frozen_string_literal: true

# @label Group
class JetUi::Group::ComponentPreview < ViewComponent::Preview
  # @label Sticky
  def sticky
    render_with_template
  end

  # @label Non-sticky
  def non_sticky
    render_with_template
  end
end
