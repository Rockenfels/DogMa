module ApplicationHelper
  helper_method :current_owner
  helper_method :current_shelter

  def current_shelter(session)
    session[:shelter_id] ||= nil
  end

  def current_owner(session)
    session[:owner_id] ||= nil
  end
end
