class Public::HomeController < Public::BaseController
  def show
    @events = Event.published.includes(:venue, :ticket_types).order(start_at: :desc).limit(3).decorate
  end
end
