class SetBuyerOptionalInOrder < ActiveRecord::Migration[8.0]
  def change
    change_column_null :orders, :buyer_id, true
  end
end
