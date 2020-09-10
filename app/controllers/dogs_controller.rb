class DogsController < ApplicationController
  def index
  end
  def new
    @dog = Dog.new()
    if session[:owner_id] && !session[:shelter_id]
      if session[:owner_id] && !Owner.exists?(session[:owner_id])
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
        @owner = Owner.find(session[:owner_id])
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
    end
  end

  def show
    if validate_owner(session)
      @dog = current_owner().dogs.find(params[:id])
    elsif validate_shelter(session)
      @dog = current_shelter().dogs.find(params[:id])
    end
  end

  def index
      @dogs = Dogs.all
  end

  def edit
  end

  def update
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :gender, :description, :location, :owner_id, :shelter_id)
  end

end
