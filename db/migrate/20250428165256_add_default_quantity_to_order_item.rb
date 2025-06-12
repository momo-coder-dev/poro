class AddDefaultQuantityToOrderItem < ActiveRecord::Migration[8.0]
  def change
    change_column_default :order_items, :quantity, from: nil, to: 1
  end
end
