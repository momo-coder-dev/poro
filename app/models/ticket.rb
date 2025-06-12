class Ticket < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :account
  belongs_to :ticket_type
  belongs_to :event
  belongs_to :validator, optional: true
  before_create :generate_reference

  def validated?
    validated_at.present?
  end

  def can_be_validated?
    return false if validated?
    return false unless active?
    return false unless event.present?
    !event.past?
  end

  def qr_content
    self.id.to_json
  end

  generates_token_for :ticket_reference, expires_in: 24.hours do
    reference
  end


  private

  def generate_reference
    self.reference ||= SecureRandom.hex(10) # or urlsafe_base64(8) if you want shorter
  end
end
