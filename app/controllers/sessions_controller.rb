class SessionsControlelr < ApplicationController
  def createOwner
      @owner = Owner.find_by(email: params[:email])
      return head(:forbidden) unless @owner.authenticate(params[:password])
      session[:owner_id] = @owner.id
      redirect_to owner_path(@owner.id)
  end

  def createShelter
      @shelter = Shelter.find_by(email: params[:email])
      return head(:forbidden) unless @shelter.authenticate(params[:password])
      session[:shelter_id] = @shelter.id
      redirect_to shelter_path(@shelter.id)
  end


  def destroyOwner
    if validate_owner(session) && current_owner(session) = params[:id]
      session.delete :owner_id
      redirect_to :root
    else
      redirect_to :root, alert: 'You\'re barking up the wrong tree!'
    end
  end

  def destroyShelter
    if validate_shelter(session) && current_shelter(session) = params[:id]
      session.delete :shelter_id
      redirect_to :root
    end
  end
end
