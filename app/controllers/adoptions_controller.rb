class AdoptionsController < ApplicationController
  include ApplicationHelper
  include OwnersHelper
  include SheltersHelper
  include DogsHelper
  include AdoptionsHelper
#Access to adoption form can only come from shelter page with hidden shelter & dog info fields in form
#Only owners can adopt or abandon dogs; shelters must confirm
#Added in owner-confirmation

  def create
    @dog = Dog.find_by(id: params[:dog])
    @shelter = Shelter.find_by(id: @dog.shelter.id)

    if validate_owner() && @adoption.owner_conf == true
      @adoption = Adoption.new()
      @adoption.owner_conf = true
      @owner = Owner.find_by(id: current_owner())
      @adoption.save

      redirect_to owner_path(@owner), alert: 'Move in progress- you\'ll see this take effect if the shelter accepts.'
    else
      @adoption.destroy()
      redirect_to owner_path(@owner), alert: 'Adoptin canceled.'
    end
  end

  def move
    @adoption = Adoption.find_by(id: params[:adoption])
    @adoption.shelter_conf = true
    @dog = Dog.find_by(id: @adoption.dog_id)
    @shelter = Shelter.find_by(id: @adoption.shelter_id)
    @owner = Owner.find_by(id: @adoption.owner_id)
    #checks for owner & shelter confirmation of adoption & that the transfer info passed is valid
    if @adoption.owner_conf && @adoption.shelter_conf && !@adoption.adopted
      transfer(@adoption, @shelter, @owner, @dog)
      @adoption.adopted = true
      @adoption.save
      redirect_to shelter_path(@shelter.id), alert: "Transfer made- here's your dog's new home!"
    else
      redirect_to shelter_path(@shelter.id), alert: 'Transfer not completed'
    end

  end
end
