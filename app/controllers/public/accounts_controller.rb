class Public::AccountsController < Public::BaseController

  def show
    @account = Account.find(params[:id]).decorate
    @events = @account.events.published
                     .includes(:venue, :ticket_types)
                     .order(start_at: :desc)
                     .limit(45)
                     .decorate
  end
end