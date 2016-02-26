class AddColorColumn < ActiveRecord::Migration
  def change
    add_column :workouts, :color, :integer
    add_column :boxes, :enabled, :boolean
  end
end
