class CreateValidators < ActiveRecord::Migration[8.0]
  def change
    create_table :validators do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
