class Public::OrdersController < Public::BaseController
  def create
    @order = Order.new(order_params)
    @order.account = @order.event&.account

    a = @order.order_items.select do |o|
      o.account = @order.event&.account
      o.quantity > 0
    end

    @order.order_items = a


    if @order.save
      
      redirect_to new_payment_path(token: @order.generate_token_for(:order_reference)), notice: "Process Payment"
    else
      redirect_back fallback_location: root_path, alert: "Failed to create order. Please check the form and try again: #{@order.errors.first.full_message}."
    end
  end

  def order_params
    params.require(:order).permit(:event_id, :account_id, order_items_attributes: [:id, :ticket_type_id, :quantity])
  end
end
