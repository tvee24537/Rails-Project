class User < ApplicationRecord
  has_many :games
  has_many :reviews
  has_many :reviewed_games, through: :reviews, source: :game
  
  has_secure_password 
  
  validates :username, presence: true, uniqueness: true 
  validates :email, presence: true 
  
  def self.create_by_google_omniauth(auth)
    self.find_or_create_by(username: auth[:info][:email]) do |u|
      u.email = auth[:info][:email]  
      u.password = SecureRandom.hex
  
    end
  end
  
end
