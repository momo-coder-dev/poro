class RemoveBuyerReferencesFromOrdersAndPayments < ActiveRecord::Migration[8.0]
  def change
    remove_reference :orders, :buyer, null: false, foreign_key: true
    remove_reference :payments, :buyer, null: false, foreign_key: true
  end
end
