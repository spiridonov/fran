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

  def copy_previous_week(current_week)
    current_week_empty = !Workout.
      where('datetime::date >= ?', current_week).
      where('datetime::date <= ?', current_week.end_of_week).
      exists?

    if current_week_empty
      previous_week = current_week - 7.days
      workouts = Workout.
        where('datetime::date >= ?', previous_week).
        where('datetime::date <= ?', previous_week.end_of_week).
        all
      workouts.each do |workout|
        Workout.create(
          box_id: workout.box_id,
          datetime: workout.datetime + 7.days,
          cap: workout.cap,
          description: workout.description,
        )
      end
    end
  end
end
