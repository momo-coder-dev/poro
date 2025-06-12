class EventDecorator < Draper::Decorator
  delegate_all

  def formatted_date
    start_at.strftime("%B %d, %Y")
  end

  def formatted_time
    start_at.strftime("%I:%M %p")
  end

  def venue_name
    venue&.name || "TBA"
  end

  def min_ticket_price
    price = ticket_types.minimum(:price)
    h.number_to_currency(price, unit: 'FCFA', format: "%n %u")
  end
end 