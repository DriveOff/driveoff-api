class RemoveLatAndLngFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :start_lat
    remove_column :trips, :start_lng
    remove_column :trips, :end_lat
    remove_column :trips, :end_lng
    
    change_column :trips, :distance, :decimal, precision: 6, scale: 1, null: false, default: 0
  end
end
