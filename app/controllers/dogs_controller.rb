class DogsController < ApplicationController
  include ApplicationHelper
  include OwnersHelper
  include SheltersHelper

  def index
    @dogs = Dog.all
  end

  def new
    @dog = Dog.new()
    if session[:owner_id] && !session[:shelter_id]
      if validate_owner()
        @owner = Owner.find_by(id: current_owner())
      else
        redirect_to index_path, alert: "Please login or signup first"
      end
    elsif session[:shelter_id] && !session[:owner_id]
      if validate_shelter()
        @shelter= Shelter.find_by(id: current_shelter())
      else
          redirect_to index_path, alert: "Please login or signup first"
      end
    end
  end

  def create

    if session[:owner_id] && !session[:shelter_id]
      if !validate_owner()
        redirect_to index_path, alert: "Please login or signup first"
      elsif validate_owner()
        @owner = Owner.find_by(id: current_owner())
        @dog = Dog.create(dog_params)
        @dog.owner_id = @owner.id
        binding.pry
        redirect_to owner_path(@owner)
      end
    elsif session[:shelter_id] && !session[:owner_id]
      if !validate_shelter()
        redirect_to index_path, alert: "Please login or signup first"
      elsif validate_shelter()

        @shelter = Shelter.find_by(id: current_shelter())
        @dog = Dog.create(dog_params)
        @shelter.dogs << @dog

      end
    else
      redirect_to dogs_path, alert: 'You must be logged in to edit dog information.'
    end
  end

  def show
    @dog = Dog.find_by(params[:id])
    if @dog.nil?
      redirect_to dogs_path, alert: 'Dog not found.'
    end
  end

  def edit
    @dog = Dog.find_by(id: params[:id])

    if validate_owner() && @dog.owner.id == current_owner()
      @owner = Owner.find_by(id: current_owner())
    elsif validate_shelter && @dog.shelter.id == current_shelter()
      @dog = Shelter.find_by(id: current_shelter()).dogs.find(params[:id])
    else
      redirect_to dogs_path, alert: 'Please sign in to edit dog information.'
    end
  end

  def update
    if validate_owner() && @dog.owner.id == current_owner()
      @dog.update(dog_params)
      redirect_to dog_path(@dog.id)
    elsif validate_shelter(session) && @dog.shelter.id == current_shelter()
      @dog.update(dog_params)
      redirect_to dog_path(@dog.id)
    else
      redirect_to dogs_path, alert: 'Please sign in to edit dog information.'
    end
  end

  def destroy
    if validate_owner() && @dog.owner.id == current_owner()
      @dog = current_owner().dogs.find(params[:id]).destory
      redirect_to owner_path(current_owne())
    elsif validate_shelter && @dog.shelter.id == current_shelter()
      @dog = current_shelter().dogs.find(params[:id]).destroy
      redirect_to shelter_path(current_shelter.id)
    else
      redirect_to dogs_path, alert: 'You must be signed in to remove a dog.'
    end

  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :gender, :description, :home_state, :owner_id, :shelter_id)
  end


end
