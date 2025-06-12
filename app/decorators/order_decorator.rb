class OrderDecorator < Draper::Decorator
  delegate_all

  def buyer_name
    "LO"
  end

  def total_amount
    h.number_to_currency(tickets.joins(:ticket_type).sum("ticket_types.price"), unit: "FCFA", format: "%n %u")
  end

  def tickets_count
    tickets.count
  end

  def created_at
    h.l(object.created_at, format: :long)
  end

  def reference
    "##{object.id}"
  end

  def payment_status
    h.content_tag :span, object.status.titleize,
      class: payment_status_class
  end

  private

  def payment_status_class
    case object.status
    when "paid"
      "px-2 py-1 text-xs font-medium text-green-700 bg-green-100 rounded-full"
    when "pending"
      "px-2 py-1 text-xs font-medium text-yellow-700 bg-yellow-100 rounded-full"
    else
      "px-2 py-1 text-xs font-medium text-red-700 bg-red-100 rounded-full"
    end
  end
end
