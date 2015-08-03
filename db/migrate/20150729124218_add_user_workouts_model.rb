class AddUserWorkoutsModel < ActiveRecord::Migration
  def change
    create_table :user_workouts do |t|
      t.integer :user_id
      t.integer :workout_id
    end

    add_index :user_workouts, [:workout_id, :user_id]
  end
end
