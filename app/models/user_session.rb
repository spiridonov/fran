class UserSession < Authlogic::Session::Base
  remember_me_for 3.years

  def remember_me
    true
  end
  
end
