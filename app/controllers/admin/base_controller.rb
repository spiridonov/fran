class Admin::BaseController < ApplicationController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :authenticate_administrator!
 
  layout 'admin'

  # def require_admin!
  #   if current_user.admin?
  #     true
  #   else
  #     render nothing: true, status: :unauthorized
  #     false
  #   end
  # end

end