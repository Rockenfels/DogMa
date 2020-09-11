module OwnersHelper

  def validate_owner(session)
      current_owner(session) != nil && Owner.exitsts?(current_owner(session)) ? true : false
  end
end
