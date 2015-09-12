class AddWorkoutCap < ActiveRecord::Migration
  def change
    add_column :workouts, :cap, :integer
    add_column :boxes, :default_cap, :integer
  end
end
