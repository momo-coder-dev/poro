class Public::PaymentsController < Public::BaseController
  before_action :set_order

  def new
    @payment = @order.build_payment
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.order = @order

    if @payment.save
      # Here you would integrate with your payment provider
      # For example, with Stripe:
      # payment_intent = create_payment_intent
      # redirect_to payment_intent.checkout_url
      
      # For now, we'll just simulate a successful payment
      @payment.update(status: 'succeeded')
      flash.now[:notice] = 'Payment successful!'
      render :confirmation, status: :ok
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @token = params[:token]
    @order = Order.find_by_token_for(:order_reference, @token)
    @event = @order.event
    @account = @order.account
    
    redirect_to root_path, alert: "Not Found" if @order.nil?
    redirect_back fallback_location: root_path, alert: "Payment already processed." if @order.paid?
  
  end

  def payment_params
    params.require(:payment).permit(:payment_method, :buyer_email, :buyer_phone)
  end
end