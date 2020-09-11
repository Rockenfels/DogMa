class Adoption < ApplicationRecord
  belongs_to :dogs
  belongs_to :owners
  belongs_to :shelters
  
end
