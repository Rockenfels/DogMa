module AdoptionsHelper
  def transfer(adoption, owner, shelter, dog)
      @adoption = adoption
      @owner = owner
      @shelter = shelter
      @dog = dog

      if @owner.dogs.find_by(id: @dog.id).nil? && !@shelter.dogs.find_by(id: @dog.id).nil?
        @owner.dogs << @dog
        @dog.shelter = nil
        @adoption.adopted = true
      elsif !@owner.dogs.find_by(id: @dog.id).nil? && @shelter.dogs.find_by(id: @dog.id).nil?
        @shelter.dogs << @dog
        @dog.owner = nil
        @adoption.adopted = true
      else
        return false
      end
    end
  end
