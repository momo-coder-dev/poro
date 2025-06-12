class AddReferenceToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :reference, :string
  end
end
