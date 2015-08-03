class AddUsersModel < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :vk_token, :null => false
      t.string :vk_id, :null => false
      t.string :persistence_token, :null => false

      t.timestamps
    end

    add_index :users, :vk_id
  end
end
