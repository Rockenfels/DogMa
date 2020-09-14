require 'pry'
class OwnersController < ApplicationController
  include OwnersHelper
  include ApplicationHelper
  layout 'owners'
  def new
    @owner = Owner.new()
  end

  def create
    if session[:owner_id].nil? && session[:shelter_id].nil?
      @owner = Owner.create(owner_params)
      redirect_to :root
    else
      redirect_to dogs_path, alert: 'You must sign out before creating a new account.'
    end
  end

  def show
    if validate_owner()
      @owner = Owner.find_by(id: current_owner())
    else
      @owner = Owner.find_by(id: params[:id])
      binding.pry
    end
  end

  def index
    @owners =Owner.all
  end

  def edit
    if validate_owner() && curent_owner() == params[:id]
      @owner = Owner.find(current_owner())
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  def update
    if validate_owner() && curent_owner() == params[:id]
      @owner = Owner.find(current_owner())
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  def destroy
    if validate_owner() && Owner.find_by(id: curent_owner()) == params[:id]
      @owner = Owner.find(current_owner())
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :email, :home_state, :about_me, :password, :password_confirmation, :uid)
  end
end
