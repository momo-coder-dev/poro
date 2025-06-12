# frozen_string_literal: true

class Forms::BaseElementComponent < ViewComponent::Base
  def initialize(form:, field_name:, label: nil, placeholder: nil, required: false, options: {}, class_string: nil, default: nil)
    @form = form
    @field_name = field_name
    @placeholder = placeholder
    @required = required
    @options = options.presence || {}
    @object = @form.object
    @class_string = class_string
    @default = default
    after_initialize
  end

  def form
    @form
  end

  def input_classes
    return @class_string if @class_string.present?
    classes = [ "input block shadow-sm rounded-md border outline-hidden px-3 py-2 mt-2 w-full border-gray-400 focus:outline-blue-600" ]
    classes << error_classes
    classes
  end

  def has_errors?
    return false if @object.nil? || @field_name.nil?
    @object.errors.respond_to?(:[]) && @object.errors[@field_name].any?
  end

  def error_classes
    {
      "border-gray-400 focus:outline-blue-600": !has_errors?,
      "border-red-400 focus:outline-red-600": has_errors?
    }
  end

  private

  def after_initialize
    puts "after_initialize"
  end
end
