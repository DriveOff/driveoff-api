class FixTimestamps < ActiveRecord::Migration
  def change
    add_column :businesses, :created_at, :datetime, null: false
    add_column :businesses, :updated_at, :datetime, null: false
    
    add_column :rewards, :created_at, :datetime, null: false
    add_column :rewards, :updated_at, :datetime, null: false
    
    change_column_null :trips, :created_at, false
    change_column_null :trips, :updated_at, false
  end
end
