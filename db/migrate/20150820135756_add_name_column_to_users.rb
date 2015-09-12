class AddNameColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :name, :string

    execute <<-SQL
      UPDATE users
      SET name = first_name || ' ' || last_name
    SQL

    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :name
  end
end
