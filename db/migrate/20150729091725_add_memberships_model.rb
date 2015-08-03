class AddMembershipsModel < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
    end
  end
end
