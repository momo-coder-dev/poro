class AddStatusToEvent < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :status, :string
    add_column :events, :access_visibility, :string
    add_column :events, :location_type, :string
    add_column :events, :entry_requirement, :text
  end
end
