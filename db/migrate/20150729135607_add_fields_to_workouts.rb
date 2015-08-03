class AddFieldsToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :program, :text
    add_column :workouts, :description, :string
    add_column :workouts, :board_photo, :string
    add_column :user_workouts, :visited, :boolean, :default => true, :null => false
  end
end
