class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.string :logo
      t.string :website

      t.timestamps
    end
    add_index :accounts, :slug, unique: true
  end
end
