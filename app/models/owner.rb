class Owner < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :email, presence: true, on: :update
  validates :password_digest, presence: true, allow_blank: true, if: :fb_logged?
  validates :about_me, :home_state, presence: true, allow_blank: true
  validates :uid, presence: true, allow_blank: true

  has_many :dogs
  has_many :adoptions
  has_many :shelters, through: :adoptions

  def fb_logged?
    uid != nil
  end

end
