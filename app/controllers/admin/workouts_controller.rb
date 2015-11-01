class Admin::WorkoutsController < Admin::BaseController

  def index
    if params[:start_date].present?
      start_date = Date.parse(params[:start_date])
    else
      start_date = Date.today.beginning_of_week
    end
    
    end_date = start_date.end_of_week
    workouts = Workout.
      where('datetime::date >= ?', start_date).
      where('datetime::date <= ?', end_date).
      includes(:users, :box).
      all
    @week = Week.new(start_date, workouts)
  end

  def show
    @workout = Workout.find(params[:id])
  end

  def new
    @workout = WorkoutForm.build(params)
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    flash[:notice] = 'Тренировка успешно удалена'
    redirect_to admin_workouts_path(start_date: @workout.datetime.to_date.beginning_of_week)
  end

  def update
    @workout = Workout.find(params[:id])
    @workout.update_attributes(workout_params)

    render 'show'
  end

  def create
    @workout = WorkoutForm.new(workout_params)
    @workout.date = Date.parse(@workout.date)
    @workout.hours = @workout.hours.to_i
    @workout.mins = @workout.mins.to_i

    @workout.datetime = @workout.date + @workout.hours.hours + @workout.mins.minutes
    
    if @workout.save
      flash[:notice] = 'Тренировка успешно создана'
      redirect_to admin_workouts_path(start_date: @workout.date.beginning_of_week)
    else
      flash[:alert] = 'При сохранении произошли ошибки'
      render 'new'
    end
  end

  private

  def workout_params
    params.
      require(:workout).
      permit(
        :program, :description, :date, :hours, :mins, :box_id, :cap
      )
  end

end
