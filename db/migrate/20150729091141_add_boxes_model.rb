class AddBoxesModel < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :address
    end
  end
end
