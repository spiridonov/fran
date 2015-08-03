class HomeController < ApplicationController

  def index
    redirect_to workouts_path
  end

end