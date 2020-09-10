def validate_owner(session)
    current_owner(session) != nil && Owner.exitsts?(current_owner(session).id) ? true : false
end
