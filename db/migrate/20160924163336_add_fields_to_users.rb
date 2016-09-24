class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :integer, null: false, default: 1
    add_column :users, :avatar, :string
    
    change_column_null :users, :crypted_password, false
    change_column_null :users, :salt, false
    change_column_null :users, :created_at, false
    change_column_null :users, :updated_at, false
  end
end
