class AddCoverImageToAccount < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :cover_image, :string
  end
end
