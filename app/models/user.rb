class User < ActiveRecord::Base

  has_many :user_workouts
  has_many :workouts, through: :user_workouts
  belongs_to :invited_by, class_name: 'User'
  
  before_save :ensure_referral_code
  
  acts_as_authentic do |config|
    # config.disable_perishable_token_maintenance(true)
  end

  default_scope { order('id DESC') }

  def admin?
    self.admin == true
  end

  def ensure_referral_code
    if referral_code.blank?
      self.referral_code = generate_referral_code
    end
  end

  private
  
  def generate_referral_code
    loop do
      code = SYMBOLS.sample(8).join
      break code unless User.where(referral_code: code).exists?
    end
  end

  SYMBOLS = (('A'..'Z').to_a + ('0'..'9').to_a).freeze

end
