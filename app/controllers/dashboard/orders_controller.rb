class Dashboard::OrdersController < Dashboard::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @orders = pagy(current_account.orders.order(created_at: :desc))
    @orders = @orders.decorate
  end

  def show
  end

  def new
    @order = current_account.orders.new
  end

  def edit
  end

  def create
    @order = current_account.orders.build(order_params)
    if @order.save
      redirect_to dashboard_order_path(@order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      redirect_to dashboard_order_path(@order), notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to dashboard_orders_url, notice: "Order was successfully destroyed."
  end

  private

  def set_order
    @order = current_account.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:payment_status, ticket_ids: [])
  end
end