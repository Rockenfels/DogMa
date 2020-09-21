class Shelter < ApplicationRecord
  has_secure_password

  validates :name, :password_digest, presence: true, on: :create
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :email, presence: true, on: :update
  validates :about_us, :home_state, presence: true, allow_blank: true

  has_many :dogs
  has_many :adoptions
  has_many :owners, through: :adoptions
end
