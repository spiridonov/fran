class Box < ActiveRecord::Base

  default_scope ->{ order(:id) }

  mount_uploader :social_image, SocialImageUploader
  
end
