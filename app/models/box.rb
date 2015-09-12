class Box < ActiveRecord::Base

  default_scope ->{ order(:id) }
  
end
