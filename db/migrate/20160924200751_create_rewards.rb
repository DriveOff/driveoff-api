class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.belongs_to :business, index: true, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :cost, null: false
    end
  end
end
