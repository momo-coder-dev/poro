# frozen_string_literal: true

class Forms::SelectInputComponent < Forms::BaseElementComponent
  def after_initialize
    @collection = @options[:collection].presence || []
    @prompt = @options[:prompt].presence || @placeholder.presence || "Select an option"
    @multiple = @options[:multiple].presence || false
  end
end
