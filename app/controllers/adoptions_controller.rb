class AdoptionsController < ApplicationController
  include ApplicationHelper
  include OwnersHelper
  include SheltersHelper
  include DogsHelper
#Access to adoption form can only come from shelter page with hidden shelter & dog info fields in form
#Only owners can adopt or abandon dogs; shelters must confirm
  def new
    #checks for shelter id to indicate adoption
    if params[:shelter][:id]
      @adoption = Adoption.new()
      @shelter = Shelter.find_by(id: params[:shelter][:id])
      @dog = @shelter.dogs.find_by(id: params[:dog][:id])

      #faulty multiple login check
      if session[:owner_id] && !session[:shelter_id]
        #owner not logged in check
        if !helpers.validate_owner(session)
          redirect_to index_path, alert: "Please login or signup first"
        #checks owner logged in & invalid shelter
      elsif helpers.validate_owner(session) && !helpers.validate_shelter_adopt(@shelter.email)
          redirect_to shelters_path, alert: 'Cannot find the shelter you\'re trying to adopt from.'
        elsif helpers.validate_owner(session) && helpers.validate_shelter_adopt(@shelter.email) ! helpers.validate_dog_adopt(@dog.id)
          redirect_to shelter_path(@shelter), alert: 'Couldn\'t find the dog you were trying to adopt.'
        end
      end
    #checks for lack of shelter id to indicate abandonment
    elsif params[:shelter][:id].nil?
      @adoption = Adoption.new()
      @owner = Owner.find_by(helpers.current_owner(session))
      @dog = @owner.dogs.where(id: params[:dog][:id])
      @shelter = Shelter.new()
      #faulty multiple login check
      if session[:owner_id] && !session[:shelter_id]
        #owner not logged in check
        if !helpers.validate_owner(session)
          redirect_to index_path, alert: "Please login or signup first"
        elsif helpers.validate_owner(session) &&  helpers.validate_dog_adopt(@dog.id)
          redirect_to shelter_path(@shelter), alert: 'Couldn\'t find the dog you were trying to adopt.'
        end
        render 'abandon'
      end
    end
  end

  def create
    @dog = Dog.find_by(id: params[:dog][:id])
    @shelter = Shelter.find_by(id: params[:shelter][:id])
    #faulty multiple login check
    if session[:owner_id] && !session[:shelter_id]
      #owner not logged in check
      if !helpers.validate_owner(session)
        redirect_to index_path, alert: "Please login or signup first"
      #checks owner logged in & invalid shelter
    elsif helpers.validate_owner(session) && !helpers.validate_shelter_adopt(@shelter.email)
        redirect_to shelters_path, alert: 'Cannot find the shelter you\'re trying to adopt from.'
      elsif helpers.validate_owner(session) && helpers.validate_shelter_adopt(@shelter.email) && !helpers.validate_dog_adopt(@dog.id)
        redirect_to shelter_path(@shelter), alert: 'Couldn\'t find the dog you were trying to adopt.'
      else
        @adoption = Adoption.new(params[:owner_conf])
        @owner = Owner.find_by(id: helpers.current_owner(session))
        @owner.adoptions << @adoption
        @shelter.adoptions << @adoption
        @dog.adoptions << @adoption
        redirect_to owner_path(@owner), alert: 'Move in progress- you\'ll see this take effect if the shelter accepts.'
      end
    end
  end

  def move
    @adoption = Adoption.find_by(id: params[:adoption][:id])
    @dog = @adoption.dog
    @shelter = @adoption.shelter
    @owner = @adoption.owner

    #checks for owner & shelter confirmation of adoption & that the transfer info passed is valid
    if @adoption.owner_conf && @adoption.shelter_conf && @adoption.transfer() != false
      Adoption.transfer(@adoption)
      redirect_to owner_path(@owner), alert: "Transfer made- here's your dog's new home!"
    end

  end
end
