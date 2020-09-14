module OwnersHelper
  def validate_owner
      current_owner() != nil && Owner.exists?(current_owner()) ? true : false
  end
end
