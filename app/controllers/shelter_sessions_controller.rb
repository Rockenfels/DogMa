require 'pry'
class ShelterSessionsController < ApplicationController
  include ApplicationHelper
  include OwnersHelper
  include SheltersHelper
  def new
    @shelter = Shelter.new()
  end

  def create
      @shelter = Shelter.find_by(email: params[:shelter][:email])
      return head(:forbidden) unless @shelter.authenticate(params[:shelter][:password])
      session[:shelter_id] = @shelter.id
      redirect_to shelter_path(@shelter.id)
  end

  def destroy
    if validate_shelter() && current_shelter().to_s() == params[:id]
      session.delete(:shelter_id)
      redirect_to :root
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
