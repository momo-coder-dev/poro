class Validator < ApplicationRecord
  belongs_to :account
  belongs_to :event

  has_many :ticket_type_validators, dependent: :destroy
  has_many :ticket_types, through: :ticket_type_validators
end
