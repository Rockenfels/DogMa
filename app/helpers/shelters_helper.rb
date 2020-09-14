module SheltersHelper
  def validate_shelter(session)
        current_shelter(session) != nil && Shelter.exitsts?(current_shelter(session).id) ? true : false
  end


  def validate_shelter_adopt(email)
    !Shelter.find_by(email: email).nil? ? true : false
  end
end
