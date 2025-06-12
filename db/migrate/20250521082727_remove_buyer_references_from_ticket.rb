class RemoveBuyerReferencesFromTicket < ActiveRecord::Migration[8.0]
  def change
    remove_reference :tickets, :buyer, null: false, foreign_key: true
  end
end
