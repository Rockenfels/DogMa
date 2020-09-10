def validate_sheler(session)
    session[:shelter_id] === current_shelter().id ? true : false
end
