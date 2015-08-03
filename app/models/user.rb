class User < ActiveRecord::Base

  has_many :user_workouts
  has_many :workouts, through: :user_workouts
  
  acts_as_authentic do |config|
    # config.disable_perishable_token_maintenance(true)
  end

  default_scope { order('id DESC') }

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.admin == true
  end

end
