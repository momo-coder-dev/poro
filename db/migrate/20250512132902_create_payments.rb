class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.string :payment_method
      t.string :amount
      t.references :order, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
