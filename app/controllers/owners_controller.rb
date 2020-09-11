class OwnersController
  def new
    @owner = Owner.new()
  end

  def create
    if validate_owner(session)
    Owner.create(owner_params)
    redirect_to owners_login_path
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :email, :home_state, :about_me, :password, :password_confirmation)
  end
end
