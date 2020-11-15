class User < ApplicationRecord
  has_many :games
  has_many :reviews
  has_many :reviewed_games, through: :reviews, source: :game
  
  has_secure_password 
  
  validates :username, presence: true, uniqueness: true 
  validates :email, presence: true 
  
  def self.from_google(uid:, email:, full_name:, avatar_url:)
    if user = User.find_by(email: email)
      user.update(uid: uid, full_name: full_name, avatar_url: avatar_url) unless user.uid.present?
      user
    else
      User.create(
        email: email,
        uid: uid,
        full_name: full_name,
        avatar_url: avatar_url,
        password: SecureRandom.hex
      )
    end
  
end
