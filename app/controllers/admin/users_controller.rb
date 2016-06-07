require 'csv'

class Admin::UsersController < Admin::BaseController
  # before_filter :require_admin!

  def index
    @users = User.where(banned: false)
    if params[:search]
      @users = @users.where('name ILIKE ?', "%#{params[:search]}%")
    end

    # @users = @users.paginate(page: params[:page], per_page: 20).order('id DESC')
  end

  def show
    @user = User.find(params[:id])
  end

  def users_report
    csv_string = CSV.generate do |csv|
      User.where(banned: false).all.each do |user|
        csv << [user.id, user.name, view_context.social_url(user)]
      end
    end
    
    response.headers['Content-Type'] = 'text/csv'
    response.headers['Content-Disposition'] = 'attachment; filename=users.csv'  

    render text: csv_string
  end

  def workouts_report
    csv_string = CSV.generate do |csv|
      Workout.includes(:box, :user_workouts => :user).all.each do |workout|
        workout.user_workouts.each do |user_workout|
          csv << [workout.box.name, workout.datetime, user_workout.user.id, user_workout.user.name, workout.cap, workout.description, workout.program]
        end
      end
    end
    
    response.headers['Content-Type'] = 'text/csv'
    response.headers['Content-Disposition'] = 'attachment; filename=workouts.csv'  

    render text: csv_string
  end

  def ban
    @user = User.find(params[:id])
    @user.update_attributes(banned: true)

    redirect_to admin_user_path(@user)
  end

  def unban
    @user = User.find(params[:id])
    @user.update_attributes(banned: false)

    redirect_to admin_user_path(@user)
  end

  def lazy
    @users = User.
      includes(:user_workouts).
      where(banned: false).
      all.
      select { |user|
        user.user_workouts.blank? ||
          user.user_workouts.
            max_by{ |w| w.workout.datetime }.
            workout.datetime <= Time.zone.now.to_date - 7.days
      }
  end

  def banned
    @users = User.where(banned: true).all
  end

  # def new
  #   @user = User.new(role: :manager)
  # end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   flash[:notice] = 'Менеджер был успешно удален'
  #   redirect_to admin_users_path
  # end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(user_params)
  #     redirect_to admin_users_path
  #   else
  #     render 'edit'
  #   end
  # end

  # def create
  #   @user = User.new(user_params)
  #   @user.role = :manager
  #   if @user.save
  #     flash[:notice] = 'Менеджер был успешно создан'
  #     redirect_to admin_users_path
  #   else
  #     flash[:alert] = 'При сохранении произошли ошибки'
  #     render 'new'
  #   end
  # end

end
