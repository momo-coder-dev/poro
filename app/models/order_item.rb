class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type
  belongs_to :account

  before_validation :set_quantity, on: :create
  before_validation :set_unit_price, on: :create
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    quantity * unit_price
  end

  private

  def set_quantity
    self.quantity ||= 1
  end

  def set_unit_price
    self.unit_price ||= ticket_type.price
  end
end

