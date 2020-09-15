require 'pry'
class SheltersController < ApplicationController
  include ApplicationHelper
  include SheltersHelper
  include OwnersHelper


  def new
    @shelter = Shelter.new()
  end

  def create
    if session[:shelter_id].nil? && session[:shelter_id].nil?
      @shelter = Shelter.create(shelter_params)
      redirect_to new_shelter_session_path
    else
      redirect_to dogs_path, alert: 'You must sign out before creating a new account.'
    end
  end

  def show
    if validate_shelter()
      @shelter = Shelter.find_by(id: current_shelter())
      @adoptions = Adoption.where(["shelter_id = ? and adopted = ?", @shelter.id, false])
    else
      @shelter = Shelter.find_by(id: params[:id])
      @adoption = Adoption.new()
    end
  end

  def index
    @shelters =Shelter.all
  end

  def edit
    if validate_shelter() && curent_shelter() == params[:id]
      @shelter = Shelter.find(current_shelter())
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  def update
    if validate_shelter() && curent_shelter() == params[:id]
      @shelter = Shelter.find(current_shelter())
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end



  private

  def shelter_params
    params.require(:shelter).permit(:name, :email, :home_state, :about_us, :password, :password_confirmation)
  end
end
