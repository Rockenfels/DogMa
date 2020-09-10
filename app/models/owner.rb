class Owner < ApplicationRecord
  has_secure_password
  has_many :dogs
  has_many :shelters, through: :dogs
end
