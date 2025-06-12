class MoveVenueFieldsFromEventsToVenues < ActiveRecord::Migration[8.0]
  def change
    # Remove venue-related fields from events table
    remove_column :events, :latitude, :string
    remove_column :events, :longitude, :string

    # Create venues table
    create_table :venues do |t|
      t.references :event, null: false, foreign_key: true, index: { unique: true } # 1:1 relation
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
