class AdoptionsController < ApplicationController
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

end
