class OwnersController < ApplicationController
  include OwnersHelper
  include ApplicationHelper

  def new
    @owner = Owner.new()
  end

  def create
    if session[:shelter_id].nil? && session[:shelter_id].nil?
      @owner = Owner.new(owner_params)
      if @owner.valid?
        @owner.save
        redirect_to new_owner_session_path
      else
        render :new
      end
    else
      redirect_to dogs_path, alert: 'You must sign out before creating a new account.'
    end
  end

  def show
    if validate_owner() && current_owner().to_s == params[:id]
      @owner = Owner.find_by(id: current_owner())
    else
      @owner = Owner.find_by(id: params[:id])
    end
  end

  def index
    @owners =Owner.all
  end

  def edit

    if validate_owner() && current_owner().to_s == params[:id]
      @owner = Owner.find_by(id: current_owner())
    else
      redirect_to :root, alert: 'Please login, signup, or edit your own profile.'
    end
  end

  def update
    if validate_owner() && current_owner().to_s == params[:id]
      @owner = Owner.find_by(id: current_owner())
      if @owner.update(owner_params)
        redirect_to owner_path(@owner.id)
      else
        render :edit
      end
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
