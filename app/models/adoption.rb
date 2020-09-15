class Adoption < ApplicationRecord
  belongs_to :dogs, optional: true
  belongs_to :owners, optional: true
  belongs_to :shelters, optional: true

  def init
      self.owner_conf ||= false
      self.shelter_conf ||= false
  end

  
end
