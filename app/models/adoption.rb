class Adoption < ApplicationRecord
  belongs_to :dogs
  belongs_to :owners
  belongs_to :shelters

  def transfer(adoption)
    if !adoption.shelter.nil? && !adoption.owner.nil? && !adoption.dog.nil?
      @owner = adoption.owner
      @shelter = adoption.shelter
      @dog = adoption.dog

      if @owner.dogs.find_by(id: @dog.id).nil? && !@shelter.dogs.find_by(id: @dog.id).nil?
        @owner.dogs << @dog
        @dog.shelter = nil
        adoption.adopted = true
      elsif !@owner.dogs.find_by(id: @dog.id).nil? && @shelter.dogs.find_by(id: @dog.id).nil?
        @shelter.dogs << @dog
        @dog.owner = nil
        adoption.adopted = true
      else
        return false
      end
    end
  end
end
