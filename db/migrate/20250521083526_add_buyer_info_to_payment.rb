class AddBuyerInfoToPayment < ActiveRecord::Migration[8.0]
  def change
    add_column :payments, :buyer_email, :string
    add_column :payments, :buyer_phone, :string
  end
end
