class User < ApplicationRecord
  attr_reader :password

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  before_validation :ensure_session_token
  
  def self.find_by_credentials(username, password)
  end

end
