class Order < ApplicationRecord
  TICKET_QUANTITY_LIMIT = 10
  belongs_to :event
  belongs_to :account
  has_many :order_items, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_one :payment

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :reference, presence: true, uniqueness: true
  validate :validates_ticket_quantity, on: :create
  validate :validates_ticket_availability, on: :create
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  after_create :calculate_total_amount

  after_commit :generate_tickets_if_paid, on: :update

  def generate_tickets_if_paid
    generate_tickets if saved_change_to_status? && status == 'paid'
  end

  enum :status, { 
    pending: 'pending', paid: 'paid', expired: 'expired',
    cancelled: 'cancelled', refunded: 'refunded', 
    failed: 'failed' 
  }, default: 'pending'

  # TODO Create a worker that set expired orders to expired

  before_validation :generate_reference, on: :create

  generates_token_for :order_reference, expires_in: 24.hours do
    reference
  end

  def validates_ticket_quantity
    # ToDO validates ticket lendht in order
    errors.add(:base, "You cannot order more than #{TICKET_QUANTITY_LIMIT} tickets at a time") if order_items.sum(&:quantity) > TICKET_QUANTITY_LIMIT 
  end

  def validates_ticket_availability
    order_items.each do |item|
      errors.add(:base, 'There are no more tickets available') if item.quantity > item.ticket_type.remaining_tickets
    end
  end

  scope :pending, -> { where(status: 'pending') }

  def generate_tickets
    return if status != 'paid'
    return if tickets.exists?
    return if tickets_generated?

    # Loop through order items and generate tickets
    transaction do
      order_items.each do |item|
        item.quantity.times do
          Ticket.create!(
            order: self,
            ticket_type: item.ticket_type,
            account: account,
            event: event
          )
        end
      end

      update!(tickets_generated: true)
    end
  end

  def total_amount
    tickets.joins(:ticket_type).sum('ticket_types.price')
  end

  private

  def calculate_total_amount
    self.update_columns(total_amount: order_items.sum(&:total_price))
  end

  def generate_reference
    self.reference ||= "ORD#{SecureRandom.hex(5).upcase}"
  end
end
