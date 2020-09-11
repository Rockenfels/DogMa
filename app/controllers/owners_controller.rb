class OwnersController
  def new
    @owner = Owner.new()
  end

  def create
    if session[:owner_id] === nil && session[:shelter_id] === nil
      Owner.create(owner_params)
      redirect_to owners_login_path
    else
      redirect_to dogs_path, alert: 'You must sign out before creating a new account.'
    end
  end

  def show
    if validate_owner(session) && curent_owner(session) = params[:id]
      @owner = Owner.find(current_owner(session))
      render :private_show
    else
      @owner = Owner.find_by(id: params[:id])
      render layout: :application, template: :public_show
    end
  end

  def index
    @owners =Owner.all
  end

  def edit
    if validate_owner(session) && curent_owner(session) = params[:id]
      @owner = Owner.find(current_owner(session))
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  def update
    if validate_owner(session) && curent_owner(session) = params[:id]
      @owner = Owner.find(current_owner(session))
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  

  private

  def owner_params
    params.require(:owner).permit(:name, :email, :home_state, :about_me, :password, :password_confirmation)
  end
end
