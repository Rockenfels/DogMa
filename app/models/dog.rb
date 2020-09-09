class Dog < ApplicationRecord
  has_one :owner
  has_one :shelter

end
