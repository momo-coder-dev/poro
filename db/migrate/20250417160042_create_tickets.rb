class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :account, null: false, foreign_key: true
      t.references :ticket_type, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: true
      t.datetime :validity_date

      t.timestamps
    end
  end
end
