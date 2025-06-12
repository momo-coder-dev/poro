class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :status
      t.decimal :total_amount
      t.references :buyer, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
