module TicketsHelper
  COLUMNS = {
    reference: "Reference",
    event_name: "Event",
    ticket_type_name: "Type",
    price: "Price",
    status: "Status",
    buyer_name: "Buyer",
    created_at: "Created At"
  }

  ACTIONS = [ :show, :edit, :destroy ]
end
