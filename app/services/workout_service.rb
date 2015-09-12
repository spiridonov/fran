module WorkoutService

  extend self

  def can_add_workout?(date)
    date >= Date.today
  end

  def can_mark_absent_users?(workout)
    workout.datetime.to_date <= Date.today
  end

  def can_anybody_take_part?(workout)
    workout.datetime.to_date >= Date.today &&
      workout.cap > workout.user_workouts.count
  end

  def user_free_to_go_to?(workout, user)
    !user.user_workouts.
      joins(:workout).
      where('workouts.datetime::date = ?', workout.datetime.to_date).
      exists?
  end

end
