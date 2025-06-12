# frozen_string_literal: true

class Forms::SubmitButtonComponent < Forms::BaseElementComponent
  def initialize(form:, options: {})
    @form = form
    @options = options
  end
end
