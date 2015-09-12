class HomeController < ApplicationController

  skip_before_filter :require_user

  def index
    if current_user.present?
      if current_user.admin?
        redirect_to admin_workouts_path
      else      
        redirect_to workouts_path
      end
    else
      if params[:ref].present?
        user = User.where(referral_code: params[:ref]).first
        if user.present?
          ShareService.new(user).add_clicks
          session[:referral_id] = user.id
        end
      end
      flash[:notice] = "You must be logged in to access this page"
      redirect_to auth_sign_in_path
    end
  end

end