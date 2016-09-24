class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name, null: false
    end
  end
end
