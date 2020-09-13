class AdoptionsController < ApplicationController
#Access to adoption form can only come from shelter page with hidden shelter & dog info fields in form
#Only owners can adopt or abandon dogs; shelters must confirm
  def new
    if params[:shelter][:id]
      @adoption = Adoption.new()
      @shelter = Shelter.find_by(id: params[:shelter][:id])
      @dog = @shelter.dogs.find_by(id: params[:dog][:id])

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
        render 'adoption'
      end

    elsif params[:shelter][:id].nil?
      @adoption = Adoption.new()
      @owner = Owner.find_by(current_owner(session))
      @dog = @owner.dogs.find_by(id: params[:dog][:id])
      @shelter = Shelter.new()
      #faulty multiple login check
      if session[:owner_id] && !session[:shelter_id]
        #owner not logged in check
        if !validate_owner(session)
          redirect_to index_path, alert: "Please login or signup first"
        elsif validate_owner(session) && validate_dog_adopt(@dog.id)
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
      if !validate_owner(session)
        redirect_to index_path, alert: "Please login or signup first"
      #checks owner logged in & invalid shelter
      elsif validate_owner(session) && !validate_shelter_adopt(@shelter.email)
        redirect_to shelters_path, alert: 'Cannot find the shelter you\'re trying to adopt from.'
      elsif validate_owner(session) && validate_shelter_adopt(@shelter.email) !validate_dog_adopt(@dog.id)
        redirect_to shelter_path(@shelter), alert: 'Couldn\'t find the dog you were trying to adopt.'
      else
        @adoption = Adoption.new(params[:owner_conf])
        @owner = Owner.find_by(id: current_owner(session))
        @owner.adoptions << @adoption
        @shelter.adoptions << @adoption
        @dog.adoptions << @adoption
        redirect_to owner_path(@owner), alert: 'Move in progress- you\'ll see this take effect if the shelter accepts.'
      end
    end
  end
end
