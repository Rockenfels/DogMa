class Dog < ApplicationRecord
  validates :shelter_id, presence: true, allow_blank: true
  validates :owner_id, presence: true allow_blank: true
  validates :owner_is_real,
    unless: Proc.new { |a| a.owner_id.blank? }
  validates :shelter_is_real,
    unless: Proc.new { |a| a.shelter_id.blank? }
  validates :name, presence: true
  validates :breed, presence: true
  validates :age, presence: true
  validates :gender, inclusion: { in: %w(male female M F Male Female),
    message: "%{value} is not a valid dog gender entry" }
  validates :home_state, presence: true
  validates :description, presence: true, allow_blank: true

  belongs_to :owner
  belongs_to :shelter
  has_many :adoptions

  def owner_is_real
    if !Owner.find_by(owner_id: :owner_id).valid?
      errors.add(:owner_id, 'Invalid Owner')
    end
  end

  def shelter_is_real
    if !Shelter.find_by(shelter_id: :shelter_id).valid?
      errors.add(:shelter_id, 'Invalid Shelter')
    end
  end

end
