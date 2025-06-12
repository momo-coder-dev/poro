class TicketDecorator < Draper::Decorator
  delegate_all

  def event_name
    event.name
  end

  def ticket_type_name
    ticket_type.name
  end

  def buyer_name
    "N/A"
  end

  def price
    h.number_to_currency(ticket_type.price, unit: "FCFA", format: "%n %u")
  end

  def created_at
    h.l(object.created_at, format: :long)
  end
end
