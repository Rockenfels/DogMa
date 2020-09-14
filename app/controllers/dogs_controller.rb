class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end
  def new
    @dog = Dog.new()
    if session[:owner_id] && !session[:shelter_id]
      if validate_owner(session)
        redirect_to index_path, alert: "Please login or signup first"
      end
    elsif session[:shelter_id] && !session[:owner_id]
      if session[:shelter_id] && !Shelter.exists?(session[:shelter_id])
        redirect_to index_path, alert: "Please login or signup first"
      end
    end
  end

  def create
    @dog = Dog.new()
    if session[:owner_id] && !session[:shelter_id]
      if !validate_owner(session)
        redirect_to index_path, alert: "Please login or signup first"
      else
        render :layout => 'owners'
        @owner = current_owner(session)
        @dog = Dog.new(dog_params)
        @owner.dogs << @dog
        redirect_to owner_path(@owner)
      end
    elsif session[:shelter_id] && !session[:owner_id]
      if !validate_shelter(session)
        redirect_to index_path, alert: "Please login or signup first"
      else
        render :layout => 'shelters'
        @shelter = Shelter.find(session[:shelter_id])
        @dog = Dog.new(dog_params)
        @shelter.dogs << @dog
        redirect_to shelter_path(@shelter)
      end
    else
      redirect_to dogs_path, alert: 'You must be logged in to edit dog information.'
    end
  end

  def show
    if validate_owner(session)
      @dog = current_owner().dogs.find(params[:id])
    elsif validate_shelter(session)
      @dog = current_shelter().dogs.find(params[:id])
    else
      @dog = Dog.find(params[:id])
    end
  end

  def edit
    if validate_owner(session)
      @dog = current_owner().dogs.find(params[:id])
    elsif validate_shelter(session)
      @dog = current_shelter().dogs.find(params[:id])
    else
      redirect_to dogs_path, alert: 'Please sign in to edit dog information.'
    end
  end

  def update
    if validate_owner(session)
      @dog = current_owner().dogs.find(params[:id])
      redirect_to dog_path(@dog)
    elsif validate_shelter(session)
      @dog = current_shelter().dogs.find(params[:id])
      redirect_to dog_path(@dog)
    else
      redirect_to dogs_path, alert: 'Please sign in to edit dog information.'
    end
  end

  def destroy
    if validate_owner(session)
      @dog = current_owner().dogs.find(params[:id]).destory
      redirect_to owner_path(current_owner(session).id)
    elsif validate_shelter(session)
      @dog = current_shelter().dogs.find(params[:id]).destroy
      redirect_to shelter_path(current_shelter(session).id)
    else
      redirect_to dogs_path, alert: 'You must be signed in to remove a dog.'
    end

  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :gender, :description, :home_state, :owner_id, :shelter_id)
  end

end
