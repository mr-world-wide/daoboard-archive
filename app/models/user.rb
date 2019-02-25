class User < ApplicationRecord
  validates :password, length: {minimum: 6}, presence: true
  before_save {self.email = email.downcase}
  validates  :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 250}, format: VALID_EMAIL_REGEX, uniqueness: {case_sensitive: false}
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


end