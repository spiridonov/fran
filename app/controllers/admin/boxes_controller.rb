class Admin::BoxesController < Admin::BaseController

  def index
    @boxes = Box.all
  end

  def show
    @box = Box.find(params[:id])
  end

  def new
    @box = Box.new
  end

  def edit
    @box = Box.find(params[:id])
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   flash[:notice] = 'Менеджер был успешно удален'
  #   redirect_to admin_users_path
  # end

  def update
    @box = Box.find(params[:id])
    if @box.update_attributes(box_params)
      redirect_to admin_boxes_path
    else
      render 'edit'
    end
  end

  def create
    @box = Box.new(box_params)
    if @box.save
      flash[:notice] = 'Бокс был успешно создан'
      redirect_to admin_boxes_path
    else
      flash[:alert] = 'При сохранении произошли ошибки'
      render 'new'
    end
  end

  private

  def box_params
    params.
      require(:box).
      permit(
        :name, :address, :default_cap
      )
  end

end