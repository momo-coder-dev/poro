class CreateTicketTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_types do |t|
      t.references :event, null: false, foreign_key: true
      t.text :description
      t.string :name
      t.decimal :price
      t.string :quantity

      t.timestamps
    end
  end
end
