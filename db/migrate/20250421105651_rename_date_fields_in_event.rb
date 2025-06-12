class RenameDateFieldsInEvent < ActiveRecord::Migration[8.0]
  def change
    rename_column :events, :start_time, :start_at
    rename_column :events, :end_time, :end_at
  end
end
