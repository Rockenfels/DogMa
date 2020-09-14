module DogsHelper

  def validate_dog_adopt(id)
    !Dog.find_by(id: id).nil? ? true : false
  end
end
