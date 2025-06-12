# frozen_string_literal: true

class Forms::FieldComponent < ViewComponent::Base
  def initialize(form:, field_name:, label: nil, field_type: nil, field_data: nil, placeholder: nil)
    @form = form
    @field_name = field_name
    @label = label
    @field_type = field_type
    @field_data = field_data
    @placeholder = placeholder
  end

  def form
    @form
  end

  def field_name
    @field_name
  end
end
