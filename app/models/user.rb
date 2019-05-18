class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: { message: "needs to be unique" }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  after_initialize :ensure_session_token
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?
      
    password_digest = BCrypt::Password.new(user.password_digest) 

    password_digest.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def unique_session_token?
    unless user.valid?

    end
    true 
  end

  def reset_session_token!
    user.session_token = User.generate_session_token

    user.save!
    user.session_token
  end

  def ensure_session_token
    user.session_token ||= User.generate_session_token
    if !user.valid? && user.errors.messages[:password_digest].includes("needs to be unique")
      user.session_token = User.generate_session_token
    end
  end

  def password=(password)
    @password = password
    user.password_digest = BCrypt::Password.create(password)
  end
end
