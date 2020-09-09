class Shelter < ApplicationRecord
  has_secure_password
  has_many :dogs
  

end
