class SheltersController
  def new
    @shelter = Shelter.new()
  end

  def create
    if session[:shelter_id] === nil && session[:shelter_id] === nil
      Shelter.create(shelter_params)
      redirect_to shelters_login_path
    else
      redirect_to dogs_path, alert: 'You must sign out before creating a new account.'
    end
  end

  def show
    if validate_shelter(session) && curent_shelter(session) = params[:id]
      @shelter = Shelter.find(current_shelter(session))
      render :private_show
    else
      @shelter = Shelter.find_by(id: params[:id])
      render layout: :application, template: :public_show
    end
  end

  def index
    @shelters =Shelter.all
  end

  def edit
    if validate_shelter(session) && curent_shelter(session) = params[:id]
      @shelter = Shelter.find(current_shelter(session))
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  def update
    if validate_shelter(session) && curent_shelter(session) = params[:id]
      @shelter = Shelter.find(current_shelter(session))
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end



  private

  def shelter_params
    params.require(:shelter).permit(:name, :email, :home_state, :about_us, :password, :password_confirmation, :uid)
  end
end
