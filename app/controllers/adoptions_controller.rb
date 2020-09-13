class AdoptionsController < ApplicationController
#Access to adoption form can only come from shelter page with hidden shelter & dog info fields in form
#Only owners can adopt or abandon dogs; shelters must confirm
  def new
    @adoption = Adoption.new()
    @dog = @shelter.dogs.find_by(id: params[:dog][:id])
    @shelter = Shelter.find_by(id: @dog.shelter.id)
    #faulty multiple login check
    if session[:owner_id] && !session[:shelter_id]
      #owner not logged in check
      if !validate_owner(session)
        redirect_to index_path, alert: "Please login or signup first"
      #checks owner logged in & invalid shelter
      elsif validate_owner(session) && !validate_shelter_adopt(@shelter.email)
        redirect_to shelters_path, alert: 'Cannot find the shelter you\'re trying to adopt from.'
      elsif validate_owner(session) && validate_shelter_adopt(@shelter.email) !validate_dog_adopt(@dog.id)
        redirect_to shelter_path(@shelter), alert: 'Couldn\'t find the dog you were trying to adopt.'
      end
    end
  end

  def ownerAdopt
    @dog = Dog.find_by(id: params[:dog][:id])
    @shelter = Shelter.find_by(id: params[:shelter][:id])
    #faulty multiple login check
    if session[:owner_id] && !session[:shelter_id]
      #owner not logged in check
      if !validate_owner(session)
        redirect_to index_path, alert: "Please login or signup first"
      #checks owner logged in & invalid shelter
      elsif validate_owner(session) && !validate_shelter_adopt(@shelter.email)
        redirect_to shelters_path, alert: 'Cannot find the shelter you\'re trying to adopt from.'
      elsif validate_owner(session) && validate_shelter_adopt(@shelter.email) !validate_dog_adopt(@dog.id)
        redirect_to shelter_path(@shelter), alert: 'Couldn\'t find the dog you were trying to adopt.'
      else
        @adoption = Adoption.new()
        @adoption
      end
    end
  end

  def ownerAbandon

  end

  private

  def adoption_params
    params.require(:adoption).permit(:owner_id, :shelter_id, :dog_id, :owner_email, :shelter_email, :owner_conf, :shelter_conf, :adopted)
  end

end
