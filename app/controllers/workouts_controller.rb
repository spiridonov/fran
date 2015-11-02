class WorkoutsController < ApplicationController

  def index
    if params[:start_date].present?
      start_date = Date.parse(params[:start_date])
    else
      start_date = Time.zone.now.to_date.beginning_of_week
    end
    
    end_date = start_date.end_of_week
    workouts = Workout.
      where('datetime::date >= ?', start_date).
      where('datetime::date <= ?', end_date).
      includes(:users).
      all
    @week = Week.new(start_date, workouts)
  end

  def show
    @workout = Workout.find(params[:id])
  end

  def will_go
    workout = Workout.find(params[:id])

    if !workout.users.include?(current_user) && WorkoutService.can_anybody_take_part?(workout)
      current_user.user_workouts.
      joins(:workout).
      where('workouts.datetime::date = ?', workout.datetime.to_date).
      delete_all

      workout.user_workouts.create(user: current_user)
    end

    # redirect_to workouts_path(start_date: workout.datetime.to_date.beginning_of_week)
    redirect_to workout_path(workout)
  end

  def will_not_go
    workout = Workout.find(params[:id])

    if workout.users.include?(current_user)
      workout.user_workouts.where(user_id: current_user.id).destroy_all
    end

    # redirect_to workouts_path(start_date: workout.datetime.to_date.beginning_of_week)
    redirect_to workout_path(workout)
  end

end