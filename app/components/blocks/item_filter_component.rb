# frozen_string_literal: true

class Blocks::ItemFilterComponent < ViewComponent::Base
  def initialize(url:, main_fields:, secondary_fields:, export_options: {}, items: [])
    @url = url
    @items = items
    @export_options = export_options
    @main_fields = main_fields
    @secondary_fields = secondary_fields
  end

  def before_render
    @url = helpers.send(@url)
  end

  def may_export?
    @export_options.present? && @items.present?
  end
end
