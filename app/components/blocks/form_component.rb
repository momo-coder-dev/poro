class Blocks::FormComponent < ViewComponent::Base
  def initialize(item:, fields:, submit_text: nil)
    @item = item
    @fields = fields
    @submit_text = submit_text
  end
end
