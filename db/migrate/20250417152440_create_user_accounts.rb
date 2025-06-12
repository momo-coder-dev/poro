class CreateUserAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :user_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
