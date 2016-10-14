class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string, :default => nil
    add_column :users, :authentication_token_expires_at, :datetime, :default => nil
    
    add_index :users, :authentication_token
  end
end
