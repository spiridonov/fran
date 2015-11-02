class Box < ActiveRecord::Base

  default_scope ->{ order('id desc') }

  mount_uploader :social_image, SocialImageUploader
  
end
