# frozen_string_literal: true

class Blocks::ItemEmptyComponent < ViewComponent::Base
  def initialize(title: "No items found", description: "Get started by creating a new item.", button_text: nil, button_path: nil)
    @title = title
    @description = description
    @button_text = button_text
    @button_path = button_path
  end

  private

  attr_reader :title, :description, :button_text, :button_path

  def show_button?
    button_text.present? && button_path.present?
  end
end 