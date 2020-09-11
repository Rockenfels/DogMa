class Dog < ApplicationRecord
  #ADD VALIDATIONS
  belongs_to :owner
  belongs_to :shelter
  has_one :adoption
end
