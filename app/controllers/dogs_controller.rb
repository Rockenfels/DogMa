class DogsController < ApplicationController

  def new
    if session[:owner_id] && !session[:shelter_id]
      if session[:owner_id] && !Owner.exists?(session[:owner_id])
        redirect_to index_path, alert: "Please login or signup first"
      else
        @owner = Owner.find(session[:owner_id])
        @dog = Dog.new(dog_params)
        @owner.dogs << @dog
      end
    elsif session[:shelter_id] && !session[:owner_id]
      if session[:shelter_id] && !Shelter.exists?(session[:shelter_id])
        redirect_to index_path, alert: "Please login or signup first"
      else
        @shelter = Shelter.find(session[:shelter_id])
        @dog = Dog.new(dog_params)
        @shelter.dogs << @dog
      end
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :gender, :description, :location, :owner_id, :shelter_id)
  end

end
