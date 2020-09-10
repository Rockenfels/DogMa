class Shelter < ApplicationRecord
  has_secure_password
  has_many :dogs
  has_many :owners, through: :dogs

end
