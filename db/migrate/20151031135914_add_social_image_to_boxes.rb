class AddSocialImageToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :social_image, :string
  end
end
