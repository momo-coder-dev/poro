class TicketType < ApplicationRecord
  TICKET_HOLD_TIME = 10.minutes
  has_many :ticket_type_validators, dependent: :destroy
  has_many :validators, through: :ticket_type_validators
  has_many :order_items, dependent: :destroy
  has_many :tickets, dependent: :destroy
  belongs_to :event

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  scope :available, -> { where('quantity > 0') }

  # Returns the number of tickets that are still not issued (i.e., no Ticket record created).
  # Use this after an order is confirmed and tickets are generated, to track remaining stock.
  def available_quantity
    quantity - tickets.count
  end


  # Returns the number of tickets that are not yet reserved or sold.
  # It subtracts the quantity of all OrderItems linked to paid or recent pending orders.
  # Use this during checkout to ensure availability before allowing the purchase.
  def remaining_tickets

    available_quantity - order_items
      .joins(:order)
      .where(
        orders: {
          status: :pending,
          created_at: TICKET_HOLD_TIME.minutes.ago...Time.current
        }
      )
      .sum(:quantity)
  end
  
end
