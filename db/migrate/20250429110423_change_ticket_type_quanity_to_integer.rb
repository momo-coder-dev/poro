class ChangeTicketTypeQuanityToInteger < ActiveRecord::Migration[8.0]
  def up
    change_column :ticket_types, :quantity, :integer, using: 'quantity::integer'
  end

  def down
    change_column :ticket_types, :quantity, :string
  end
end
