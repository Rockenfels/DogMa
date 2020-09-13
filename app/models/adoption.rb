class Adoption < ApplicationRecord
  belongs_to :dogs
  belongs_to :owners
  belongs_to :shelters

  def transfer
    if !self.shelter.nil? && !self.owner.nil? && !self.dog.nil?
      @owner = self.owner
      @shelter = self.shelter
      @dog = self.dog

      if @owner.dogs.find_by(id: @dog.id).nil?
        @owner.dogs << @dog
        @dog.shelter = nil
      else
        @shelter.dogs << @dog
        @dog.owner = nil
      end
    end
  end
end
