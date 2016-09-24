class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.decimal :start_lat, precision: 10, scale: 6, null: false
      t.decimal :start_lng, precision: 10, scale: 6, null: false
      t.decimal :end_lat, precision: 10, scale: 6, null: false
      t.decimal :end_lng, precision: 10, scale: 6, null: false
      t.integer :distance, null: false, default: 0
      t.integer :time, null: false, default: 0
      t.integer :points, null: false, default: 0
      t.belongs_to :user, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
