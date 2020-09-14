require 'pry'
class OwnerSessionsController < ApplicationController
  def new
    @owner = Owner.new()
  end

  def create
    if !auth.nil?
      @owner = Owner.find_or_create_by(uid: auth['uid']) do |o|
        o.name = auth['info']['name']
        o.email = auth['info']['email']
      end
      @owner.save
      session[:owner_id] = @owner.id
      redirect_to owner_login_path
    else
      @owner = Owner.find_by(email: params[:owner][:email])
      return head(:forbidden) unless @owner.authenticate(params[:owner][:password])
      session[:owner_id] = @owner.id
      redirect_to owner_path(@owner.id)
    end
  end


  def destroy_owner
    if validate_owner && current_owner == params[:id]
      session.delete :owner_id
      redirect_to :root
    else
      redirect_to :root, alert: 'You\'re barking up the wrong tree!'
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
