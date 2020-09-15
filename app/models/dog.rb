class Dog < ApplicationRecord
  validates :shelter_id, :owner_id, :description, presence:true, allow_nil: true, allow_blank: true
  validates :name, :breed, :age, :home_state, presence: true
  validates :gender, inclusion: { in: %w(male female M F Male Female),
    message: "%{value} is not a valid dog gender entry" }

  belongs_to :owner, optional: true
  belongs_to :shelter, optional: true
  has_many :adoptions


end
