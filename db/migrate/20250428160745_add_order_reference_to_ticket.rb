class AddOrderReferenceToTicket < ActiveRecord::Migration[8.0]
  def change
    add_reference :tickets, :order, null: true, foreign_key: true
  end
end
