def validate_sheler(session)
      current_shelter(session) != nil && Shelter.exitsts?(current_shelter(session).id) ? true : false
end
