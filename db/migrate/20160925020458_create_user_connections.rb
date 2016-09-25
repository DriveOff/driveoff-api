class CreateUserConnections < ActiveRecord::Migration
  def change
    create_table :user_connections, force: true, id: false do |t|
      t.integer "user_1_id", null: false
      t.integer "user_2_id", null: false
    end
  end
end
