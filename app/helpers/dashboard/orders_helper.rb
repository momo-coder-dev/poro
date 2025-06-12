module Dashboard::OrdersHelper
  COLUMNS = {
    reference: "Reference",
    buyer_name: "Buyer",
    total_amount: "Total Amount",
    tickets_count: "Tickets",
    payment_status: "Payment Status",
    created_at: "Created At"
  }

  ACTIONS = [ :show, :edit, :destroy ]
end 