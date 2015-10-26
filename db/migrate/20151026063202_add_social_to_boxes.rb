class AddSocialToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :social_url, :string
    add_column :boxes, :social_title, :string
    add_column :boxes, :social_description, :string
  end
end
