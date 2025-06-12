class CreateAccountSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :account_settings do |t|
      t.references :account, null: false, foreign_key: true
      t.string :data

      t.timestamps
    end
  end
end
