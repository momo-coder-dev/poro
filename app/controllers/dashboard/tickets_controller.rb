class Dashboard::TicketsController < Dashboard::BaseController
  before_action :set_ticket, only: [ :show, :edit, :update, :destroy ]

  def index
    @event = current_account.events.find(params[:event_id])
    @pagy, @tickets = pagy(@event.tickets.order(created_at: :desc))
    @tickets = @tickets.decorate
  end

  def show
  end

  def new
    @ticket = current_account.tickets.new
  end

  def edit
  end

  def create
    @ticket = current_account.tickets.build(ticket_params)
    if @ticket.save
      redirect_to ticket_path(@ticket), notice: "Ticket was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: "Ticket was successfully destroyed."
  end

  private

  def set_ticket
    @ticket = current_account.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:event_id, :ticket_type_id, :status)
  end
end
