def validate_owner(session)
    session[:owner_id] === current_owner().id ? true : false
end
