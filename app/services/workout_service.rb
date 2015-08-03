module WorkoutService

  extend self

  def can_add_workout?(date)
    date >= Date.today
  end

  def can_mark_absent_users?(workout)
    workout.datetime.to_date <= Date.today
  end

  def can_anybody_take_part?(workout)
    workout.datetime.to_date >= Date.today
  end

  def can_go?(workout, user)
    !user.user_workouts.
      joins(:workout).
      where('workouts.datetime::date = ?', workout.datetime.to_date).
      exists?
  end

end
