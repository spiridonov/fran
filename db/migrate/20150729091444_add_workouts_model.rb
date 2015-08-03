class AddWorkoutsModel < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :box_id
      t.datetime :datetime
    end
  end
end
