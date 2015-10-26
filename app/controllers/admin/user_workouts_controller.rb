class Admin::UserWorkoutsController < Admin::BaseController

  def destroy
    user_workout = UserWorkout.find(params[:id])
    user_workout.destroy

    redirect_to admin_workout_path(user_workout.workout_id)    
  end

  def mark_as_visited
    user_workout = UserWorkout.find(params[:id])

    user_workout.visited = true
    user_workout.save!

    redirect_to admin_workout_path(user_workout.workout_id)
  end

  def mark_as_not_visited
    user_workout = UserWorkout.find(params[:id])

    user_workout.visited = false
    user_workout.save!

    redirect_to admin_workout_path(user_workout.workout_id)
  end



end
