class Shelter < ApplicationRecord
  #ADD VALIDATIONS
  has_secure_password
  has_many :dogs
  has_many :adoptions
  has_many :owners, through: :adoptions
end
