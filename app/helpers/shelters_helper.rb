module SheltersHelper
  def validate_shelter()
              current_shelter() != nil && Shelter.exists?(current_shelter()) ? true : false
  end


  def validate_shelter_adopt(email)
    !Shelter.find_by(email: email).nil? ? true : false
  end
end
