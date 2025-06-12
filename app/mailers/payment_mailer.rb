class PaymentMailer < ApplicationMailer

  def payment_success_email(payment)
    mail(to: "buyer@example.com", subject: "Your Order Confirmation -")
  end
end
