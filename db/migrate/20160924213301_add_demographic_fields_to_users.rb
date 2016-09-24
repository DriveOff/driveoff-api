class AddDemographicFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :integer
    
    add_column :users, :birthday, :date, null: false, default: Date.strptime("01/01/1980", "%m/%d/%Y")
    
    add_column :users, :gender, :integer, null: false, default: 1
    add_column :users, :custom_gender, :string
    add_column :users, :pronouns, :integer
  end
end
