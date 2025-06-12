class Validators::Dashboard::TicketsController < Validators::BaseController
  before_action :set_ticket, only: [:show]

  def scan
    @validator = current_validator
    # This is the main scanning interface
  end

  def show
    # Show ticket details
    if @ticket.nil?
      flash[:alert] = "Ticket not found"
      redirect_to validators_dashboard_new_scan_ticket_path and return
    end
  end

  def validate
    puts params.inspect
    puts params.inspect
    puts params.inspect
    puts params.inspect
    # Bad query cause ex: 62805d is interpreted as 62805
    @ticket = Ticket.find_by(id: params[:id])

    if @ticket.nil?
      flash[:alert] = "Ticket not found"
      redirect_to validators_dashboard_new_scan_ticket_path and return
    end

    if @ticket.can_be_validated?
      @ticket.update!(
        validated_at: Time.current,
        validator: current_validator
      )
      flash[:notice] = "Ticket successfully validated"
    else
      flash[:alert] = "Ticket cannot be validated"
    end

    redirect_to validators_dashboard_ticket_path(@ticket.reference)
  end

  private

  def set_ticket
    @ticket = Ticket.find_by(id: params[:reference])
  end
end