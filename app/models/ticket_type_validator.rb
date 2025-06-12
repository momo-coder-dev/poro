class TicketTypeValidator < ApplicationRecord
  belongs_to :validator
  belongs_to :ticket_type

  validates :validator_id, presence: true
  validates :ticket_type_id, presence: true
  validates :validator_id, uniqueness: { scope: :ticket_type_id }
end
