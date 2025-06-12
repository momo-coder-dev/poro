class Public::TicketsController < Public::BaseController

  def show
    @token = params[:token]
    @ticket = Ticket.find_by_token_for(:ticket_reference, @token)

    redirect_to root_path, alert: "Not Found" if @ticket.nil?



    pdf_html = ActionController::Base.new.render_to_string(template: 'public/tickets/show', layout: 'pdf')
    pdf = WickedPdf.new.pdf_from_string(pdf_html)
    send_data pdf, filename: 'file.pdf'
  end
end