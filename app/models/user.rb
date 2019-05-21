class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: { message: "needs to be unique" }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  after_initialize :ensure_session_token

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat,
    dependent: :destroy

  has_many :requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :CatRentalRequest,
    dependent: :destroy
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?
      
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def valid_session_token?
    return true if self.valid?
    return false if self.errors.include?(:session_token)  
    true
  end

  def reset_session_token!
    self.ensure_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    until valid_session_token?
      self.session_token = User.generate_session_token
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    password_digest = BCrypt::Password.new(user.password_digest)
    password_digest.is_password?(password)
  end
end
