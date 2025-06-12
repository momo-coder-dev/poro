class AddPublicReferenceToEvent < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :public_reference, :string
  end
end
