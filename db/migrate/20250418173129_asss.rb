class Asss < ActiveRecord::Migration[8.0]
  def change
    add_reference :tickets, :event, null: false, foreign_key: true
    add_column :tickets, :active, :boolean, default: true
    add_column :tickets, :validated_at, :datetime
  end
end
