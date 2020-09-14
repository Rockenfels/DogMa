require 'pry'
class ShelterSessionsController < ApplicationController

  def new
    @shelter = Shelter.new()
  end

  def create
      @shelter = Shelter.find_by(email: params[:email])
      return head(:forbidden) unless @shelter.authenticate(params[:password])
      session[:shelter_id] = @shelter.id
      @shelter.uid = auth['uid'] if !auth['uid'].nil?
      redirect_to shelter_path(@shelter.id)
  end

  def destroy
    if validate_shelter && current_shelter == params[:id]
      session.delete :shelter_id
      redirect_to :root
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
