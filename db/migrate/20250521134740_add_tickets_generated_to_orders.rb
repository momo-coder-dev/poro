class AddTicketsGeneratedToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :tickets_generated, :boolean, default: false
  end
end
