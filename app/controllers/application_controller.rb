class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_user

  helper_method :current_user_session, :current_user

  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    if current_user.present?
      if current_user.banned
        flash[:notice] = "User is banned"
        redirect_to root_path
        false
      else
        true
      end
    else
      flash[:notice] = "You must be logged in to access this page"
      redirect_to auth_sign_in_path
      false
    end
  end
end
