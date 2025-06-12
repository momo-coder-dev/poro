class Elements::OrderComponent  < ViewComponent::Base
  def initialize(ticket_types:, order:, event:)
    @event = event 
    @ticket_types = ticket_types
    @order = order
  end
end