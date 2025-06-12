class AddValidatorReferenceToTicket < ActiveRecord::Migration[8.0]
  def change
    add_reference :tickets, :validator, null: true, foreign_key: true
  end
end
