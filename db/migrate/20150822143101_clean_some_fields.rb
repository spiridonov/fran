class CleanSomeFields < ActiveRecord::Migration
  def up
    remove_column :workouts, :board_photo

    create_table :board_photos do |t|
      t.string :file
      t.date :date
      t.integer :box_id
    end
  end
  
  def down
    add_column :workouts, :board_photo, :string
    drop_table :board_photos
  end
end
