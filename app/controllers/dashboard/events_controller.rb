class Dashboard::EventsController < Dashboard::BaseController
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = current_account.events.order(start_at: :desc)
  end

  def show
    @tickets = @event.tickets.decorate
  end

  def new
    @event = current_account.events.new
  end

  def edit
  end

  def ticket_types
    @event = current_account.events.find(params[:id])
    render json: @event&.ticket_types
  end

  def create
    @event = current_account.events.build(event_params)
    if @event.save
      redirect_to event_path(@event), notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: "Event was successfully destroyed."
  end

  private

  def set_event
    @event = current_account.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :capacity, :start_at, :end_at, :status, :access_visibility, :entry_requirement, :cover_image, :category, ticket_types_attributes: [ :id, :name, :price, :quantity, :_destroy ], venue_attributes: [ :id, :name, :address, :longitude, :latitude, :_destroy ])
  end
end
