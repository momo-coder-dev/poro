class Payment < ApplicationRecord
  belongs_to :order

  after_update :trigger_ticket_generation_if_successful


  enum :status, {
     pending: 'pending',  processing: 'processing', 
     succeeded: 'succeeded', failed: 'failed',
     refunded: 'refunded', cancelled: 'cancelled'
  }, default: 'pending'


  def send_success_email
    return unless status == 'succeeded'
    PaymentMailer.payment_success_email(self).deliver_later
  end

  private

  def trigger_ticket_generation_if_successful
    return unless saved_change_to_status? && status == 'succeeded'
    send_success_email
    order.paid!
  end
end
