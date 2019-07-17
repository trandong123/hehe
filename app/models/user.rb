class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :orders
  has_many :comment_foods

  validates :name, presence: true,
    length: {maximum: Settings.name_max_length}
  validates :username, presence: true,
    length: {minimum: Settings.username_min_length}
  validates :password, presence: true,
    length: {minimum: Settings.password_min_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX}

  has_secure_password
end
