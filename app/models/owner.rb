class Owner < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :


  has_many :dogs
  has_many :adoptions
  has_many :shelters, through: :adoptions
end
