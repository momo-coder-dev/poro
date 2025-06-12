class Dashboard::HomeController < Dashboard::BaseController
  def index
    @events = current_account.events.all
    @tickets = current_account.tickets.all
  end
end
