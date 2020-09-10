module ApplicationHelper
  helper_method :current_owner
  helper_method :current_shelter

  def current_shelter
    session[:shelter_id] ||= nil
  end

  def current_owner
    session[:owner_id] ||= nil
  end
end
