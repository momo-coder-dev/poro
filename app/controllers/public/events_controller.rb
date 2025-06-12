class Public::EventsController < Public::BaseController

  def index
    @events = Event.published.includes(:venue, :ticket_types)
    
    # Apply filters
    @events = @events.by_category(params[:category]) if params[:category].present?
    @events = @events.by_date_range(params[:start_date], params[:end_date]) if params[:start_date].present?
    @events = @events.by_venue(params[:venue]) if params[:venue].present?
    
    @pagy, @events = pagy(@events.order(start_at: :asc))
    @events = @events.decorate
    
    # Get filter options
    @categories = Event.categories.keys
    @venues = Venue.pluck(:name).uniq
  end

  def show
    @event = Event.published.includes(:venue, :ticket_types).find(params[:id]).decorate
    @ticket_types = @event.ticket_types.available
    @order = Order.new
    @ticket_types.each do |ticket_type|
      @order.order_items.build(ticket_type: ticket_type)
    end
  end

  private

  def set_event
    @event = Event.published.find(params[:id])
  end
end