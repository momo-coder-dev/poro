class CreateTicketTypeValidators < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_type_validators do |t|
      t.references :validator, null: false, foreign_key: true
      t.references :ticket_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
