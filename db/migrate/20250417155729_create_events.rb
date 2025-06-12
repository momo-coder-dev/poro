class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
    add_index :events, :slug, unique: true
  end
end
