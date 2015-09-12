class AddFbToken < ActiveRecord::Migration
  def change
    add_column :users, :fb_token, :string
    add_column :users, :fb_id, :string

    add_index :users, [:fb_id]

    change_column :users, :vk_token, :string, null: true
    change_column :users, :vk_id, :string, null: true
  end
end
