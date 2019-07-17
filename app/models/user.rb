class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_reader :remember_token
  attr_accessor :activation_token
  before_save :email_downcase
  before_create :create_activation_digest

  has_many :orders
  has_many :comment_foods

  validates :name, presence: true,
    length: {maximum: Settings.name_max_length}
  validates :username, presence: true,
    length: {minimum: Settings.username_min_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password_min_length},
    allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_token: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"

    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def activate
    update_attributes activated: true
    update_attributes activated_at: Time.zone.now
  end

  def send_activation_email
    email = {user_name: self.name, activation_token: self.activation_token, mail: self.email}
    UserMailer.account_activation(email).deliver_later
  end

  private

  def email_downcase
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
