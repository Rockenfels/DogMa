class SheltersController < ApplicationController
  def create
    Shelter.create(owner_params)
  end

  private

  def shelter_params
    params.require(:shelter).permit(:name, :email, :home_state, :about_us, :password, :password_confirmation)
  end
end
