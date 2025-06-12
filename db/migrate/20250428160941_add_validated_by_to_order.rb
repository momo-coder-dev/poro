class AddValidatedByToOrder < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :validated_by, null: true, foreign_key: { to_table: :validators }
  end
end
